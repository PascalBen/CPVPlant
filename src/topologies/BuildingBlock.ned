//
// Copyright (C) 2012 Fraunhofer Institut for Solar Energy Systems 
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program; if not, see <http://www.gnu.org/licenses/>.
//
// created: 	2012-11-16
// author(s):	Pascal Benoit (pascal.benoit@ise.fraunhofer.de)

package ise.cpvplant.topologies;
import ise.cpvplant.components.Copper;
import ise.cpvplant.components.EtherSwitchPos;
import ise.cpvplant.components.EthernetIPv4SunTracker;
import ise.cpvplant.components.ManagedSwitch;
import ise.cpvplant.interfaces.IBuildingBlock;
import ise.cpvplant.interfaces.IManagedSwitch;
import ise.cpvplant.interfaces.ISunTracker;


// 
// This building block creates an extended star topology of SunTrackers with switches (EtherSwitchPos). 
// The most important configuration parameters are numTrackerWE and numTrackerNS .
//
module RectStarEthernet like IBuildingBlock
{
    parameters:
        @display("i=block/network_vl");

        //input parameter for number of trackers in east-west orientation
        int numTrackerWE = default(10);		//input parameter for number of trackers in east-west orientation
        //input parameter for number of trackers in north-south orientation
        int numTrackerNS = default(6);		//input parameter for number of trackers in north-south orientation
        //input parameter for distance between two trackers in WE-orientation
        int distWE @unit(m) = default(25m);		//input parameter for distance between two trackers in WE-orientation
        //input parameter for distance between two trackers in NS-orientation
        int distNS @unit(m) = default(26m);		//input parameter for distance between two trackers in NS-orientation
        //output value for number of trackers 
        int BBnumT = sizeof(tracker);	//output value for number of trackers 
        //output value for number of unmanaged switches 
        int BBnumS_um = sizeof(S_um);		//output value for number of unmanaged switches 
        //output value for number of managed switches 
        int BBnumS_m = 1;				//output value for number of managed switches 
        //this parameter is set and used by the Plant network to position the X-position of every BuildingBlock
        int posX = default(200);		//this parameter is set and used by the Plant network to position the X-position of every BuildingBlock
        //this parameter is set and used by the Plant network to position the Y-position of every BuildingBlock
        int posY = default(250);		//this parameter is set and used by the Plant network to position the Y-position of every BuildingBlock
        //this parameter is set by the Plant network and used inside the BuildingBlock to assign BuilidingBlock-dependend values such as timing shiftings etc.  
        int blockIndex = default(0);    	//this parameter is set by the Plant network and used inside the BuildingBlock to assign BuilidingBlock-dependend values such as timing shiftings etc.  
    gates:
        inout phys[] @labels(EtherFrame-conn);

    types:
        channel firstLastEW extends Copper
        {
            distance = distWE+1m;
        }
        channel defaultTrackerSw extends Copper
        {
            distance = 0.5m;
        }
        channel defaultEW extends Copper
        {
            distance = distWE+1m;
        }



    submodules:
        tracker[numTrackerWE*numTrackerNS]: EthernetIPv4SunTracker {
            @display("p=$trackPosX,$trackPosY");
            trackPosX = 250 + 200*index-200*((ceil((index+1)/numTrackerWE)-1)*numTrackerWE);
            trackPosY = 300 + 300*(ceil((index+1)/numTrackerWE)-1);


            // Configuration of trackers to send amount of bytes to CC.PPC			
            numTcpApps = default(1);
            tcpApp[0].typename = default("TCPSesEstablishTimeReturn");
            tcpApp[0].connectAddress = default("PlantIPv4.CC.PPC");
            tcpApp[0].port = default(1000);
            tcpApp[0].tOpen = default(1.0s+blockIndex*numTrackerWE*numTrackerNS*70ms+index*70ms);
            //tOpen+2ms
            tcpApp[0].tSend = default(1.0s+blockIndex*numTrackerWE*numTrackerNS*70ms+index*70ms+20ms); //tOpen+2ms
            //tSend+3ms
            tcpApp[0].tClose = default(1.0s+blockIndex*numTrackerWE*numTrackerNS*70ms+index*70ms+40ms); //tSend+3ms
            tcpApp[0].sendBytes = default(1KiB);


			//Pings configuration
            numPingApps = default(1);
            // Important 
            pingApp[0].typename = default("PingApp_mod"); // Important 
            //pingApp[0].printPing		=		default("true");
            //Destination of the device ping	
            pingApp[0].destAddr = default("PlantIPv4.CC.PPC");	 //Destination of the device ping	
            pingApp[0].startTime = default(0.5s+blockIndex*numTrackerWE*numTrackerNS*500ms+index*500ms);

        }

        S_um[(numTrackerWE-2)*numTrackerNS]: EtherSwitchPos {
            @display("p=$swPosX,$swPosY");
            swPosX = 450 + 200*index-200*(ceil(((index+1)/(numTrackerWE-2))-1)*(numTrackerWE-2));
            swPosY = 400	+ 300*ceil(((index+1)/(numTrackerWE-2))-1);
        }
        S_m: ManagedSwitch {
            **.mac[*].txQueueLimit = 3000;
            @display("p=100,100");

        }


    connections:

        //first and last trackers in one EW row without own Switch
        for ns=0..(numTrackerNS-1) {
            tracker[ns*(numTrackerWE)].ethg++ <--> firstLastEW <--> S_um[ns*(numTrackerWE-2)].ethg++;				//first in the EW-row (without own Sum)
            tracker[((ns+1)*numTrackerWE)-1].ethg++ <--> firstLastEW <--> S_um[((ns+1)*(numTrackerWE-2))-1].ethg++; //last in the EW-row	
            //connection between switches EW to building block switch CPV
            S_um[ns*(numTrackerWE-2)+(numTrackerWE-2)/2].ethg++ <--> Copper {  distance = distNS*ns+1m; } <--> S_m.ethg++;
        }

        //regular tracker-switch connection apart from left and right side
        for ew=0..(numTrackerWE-3), for ns=0..(numTrackerNS-1) {
            tracker[(ns*numTrackerWE)+1+ew].ethg++ <--> defaultTrackerSw <--> S_um[ns*(numTrackerWE-2)+ew].ethg++;
        }
        //connection between switches:
        for ew=0..(numTrackerWE-4), for ns=0..(numTrackerNS-1) {
            S_um[ns*(numTrackerWE-2)+ew].ethg++ <--> defaultEW <--> S_um[ns*(numTrackerWE-2)+ew+1].ethg++;
        }

	    //connection with outside world
        for i=0..sizeof(phys)-1 {
            S_m.ethg++ <--> phys[i];
        }
}



module RectTopology like IBuildingBlock
{
    parameters:
        @display("i=block/network_vl");

        //@override
        //input parameter for number of trackers in east-west orientation
        int numTrackerWE = default(10);		//input parameter for number of trackers in east-west orientation
        //input parameter for number of trackers in north-south orientation
        int numTrackerNS = default(6);		//input parameter for number of trackers in north-south orientation
        //input parameter for distance between two trackers in WE-orientation
        int distWE @unit(m) = default(25m);		//input parameter for distance between two trackers in WE-orientation
        //input parameter for distance between two trackers in NS-orientation
        int distNS @unit(m) = default(26m);		//input parameter for distance between two trackers in NS-orientation
        //this parameter is set and used by the Plant network to position the X-position of every BuildingBlock
        int posX = default(200);		//this parameter is set and used by the Plant network to position the X-position of every BuildingBlock
        //this parameter is set and used by the Plant network to position the Y-position of every BuildingBlock
        int posY = default(200);		//this parameter is set and used by the Plant network to position the Y-position of every BuildingBlock
        //this parameter is set by the Plant network and used inside the BuildingBlock to assign BuilidingBlock-dependend values such as timing shiftings etc.  
        int blockIndex = default(0);    	//this parameter is set by the Plant network and used inside the BuildingBlock to assign BuilidingBlock-dependend values such as timing shiftings etc.  

    gates:
        inout phys[] @labels(EtherFrame-conn);

    submodules:
        tracker[numTrackerWE*numTrackerNS]: <default("EthernetIPv4SunTracker")> like ISunTracker {
            @display("p=$trackPosX,$trackPosY");
            trackPosX = 250 + 200*index-200*((ceil((index+1)/numTrackerWE)-1)*numTrackerWE);
            trackPosY = 300 + 300*(ceil((index+1)/numTrackerWE)-1);


            mobility.initialX = distWE + distWE*index-distWE*((ceil((index+1)/numTrackerWE)-1)*numTrackerWE);
            mobility.initialY = distNS + distNS*(ceil((index+1)/numTrackerWE)-1);

        }

        S_m: <default("ManagedSwitch")> like IManagedSwitch {
            **.mac[*].txQueueLimit = 3000;
            @display("p=100,100");
            mobility.initialX = 5m;
            mobility.initialY = 5m;
        }

    connections:
	    //connection with outside world
        for i=0..sizeof(phys)-1 {
            S_m.ethg++ <--> phys[i];
        }


}


module RectTopologyWLANLinkT0 extends RectTopology like IBuildingBlock
{
    connections:
        tracker[0].ethg++ <--> Copper {  distance = distNS; } <--> S_m.ethg++;

}


module RectTopologyEthernet extends RectTopology like IBuildingBlock
{
    types:
        channel firstLastEW extends Copper
        {
            distance = distWE+1m;
        }
        channel defaultTrackerSw extends Copper
        {
            distance = 0.5m;
        }
        channel defaultEW extends Copper
        {
            distance = distWE+1m;
        }

    submodules:
        S_um[(numTrackerWE-2)*numTrackerNS]: EtherSwitchPos {
            @display("p=$swPosX,$swPosY");
            swPosX = 450 + 200*index-200*(ceil(((index+1)/(numTrackerWE-2))-1)*(numTrackerWE-2));
            swPosY = 400	+ 300*ceil(((index+1)/(numTrackerWE-2))-1);
        }


    connections:
        //first and last trackers in one EW row without own Switch
        for ns=0..(numTrackerNS-1) {
            tracker[ns*(numTrackerWE)].ethg++ <--> firstLastEW <--> S_um[ns*(numTrackerWE-2)].ethg++;				//first in the EW-row (without own Sum)
            tracker[((ns+1)*numTrackerWE)-1].ethg++ <--> firstLastEW <--> S_um[((ns+1)*(numTrackerWE-2))-1].ethg++; //last in the EW-row	
            //connection between switches EW to building block switch CPV
            S_um[ns*(numTrackerWE-2)+(numTrackerWE-2)/2].ethg++ <--> Copper {  distance = distNS*ns+1m; } <--> S_m.ethg++;
        }

        //regular tracker-switch connection apart from left and right side
        for ew=0..(numTrackerWE-3), for ns=0..(numTrackerNS-1) {
            tracker[(ns*numTrackerWE)+1+ew].ethg++ <--> defaultTrackerSw <--> S_um[ns*(numTrackerWE-2)+ew].ethg++;
        }
        //connection between switches:
        for ew=0..(numTrackerWE-4), for ns=0..(numTrackerNS-1) {
            S_um[ns*(numTrackerWE-2)+ew].ethg++ <--> defaultEW <--> S_um[ns*(numTrackerWE-2)+ew+1].ethg++;
        }

}

module RectTopologyEthernetLayer3 extends RectTopology like IBuildingBlock
{
    types:
        channel firstLastEW extends Copper
        {
            distance = distWE+1m;
        }
        channel defaultTrackerSw extends Copper
        {
            distance = 0.5m;
        }
        channel defaultEW extends Copper
        {
            distance = distWE+1m;
        }


    connections:

        //for each row connections in we-orientation,
        for ew=0..(numTrackerWE-2), for ns=0..(numTrackerNS-1) {
            tracker[(ns*numTrackerWE)+ew].ethg++ <--> defaultTrackerSw <--> tracker[(ns*numTrackerWE)+ew+1].ethg++;
        }

        //for each line connections in ns-orientation,
        for ns=0..(numTrackerNS-2) {
            tracker[ns*(numTrackerWE)+((numTrackerWE)/2)].ethg++ <--> Copper {  distance = distNS*ns+1m; } <--> tracker[(ns+1)*(numTrackerWE)+((numTrackerWE)/2)].ethg++;
        }

		//connection to managed switch
        tracker[(numTrackerWE)/2].ethg++ <--> Copper {  distance = distNS; } <--> S_m.ethg++;

}


// PARAMETERS TCPSessionAPP


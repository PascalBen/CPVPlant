//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package ise.cpvplant.interfaces;


moduleinterface IBuildingBlock
{
    parameters:
        @display("i=block/network_l;is=l");        
        
        int numTrackerWE;		//input parameter for number of trackers in east-west orientation
        int numTrackerNS;		//input parameter for number of trackers in north-south orientation
        int distWE	@unit(m);		//input parameter for distance between two trackers in EW-orientation
        int distNS	@unit(m);		//input parameter for distance between two trackers in NS-orientation
        int posX;		//this parameter is set and used by the Plant network to position the X-position of every BuildingBlock
        int posY;		//this parameter is set and used by the Plant network to position the Y-position of every BuildingBlock
        int blockIndex;    	//this parameter is set by the Plant network and used inside the BuildingBlock to assign BuilidingBlock-dependend values such as timing shiftings etc.  
	
	gates:
        inout phys[] @labels(EtherFrame-conn);

}

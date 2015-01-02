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

package ise.cpvplant.components;

import inet.nodes.inet.StandardHost;
import inet.nodes.ipv6.StandardHost6;
import inet.nodes.ethernet.EtherSwitch;
import ise.cpvplant.components.Ideal;
import ise.cpvplant.interfaces.IManagedSwitch;

//
// EtherSwitchPos extends the X- and Y- positioning to EtherSwitch. 
// It is used in BuildingBlock .
module EtherSwitchPos extends EtherSwitch
{
    parameters:
		@display("i=device/switch");        
        int swPosX = default(200);
        int swPosY = default(200);
}



// ManagedSwitch enables X- and Y- positioning and consists of an EtherSwitch and a StandardHost. 
// It is used in BuildingBlock .
module ManagedSwitch like IManagedSwitch
{
    parameters:
		@display("i=device/router");        
        int swPosX = default(200);
        int swPosY = default(200);
    gates:
        inout ethg[] @labels(EtherFrame-conn);    
    submodules:
        standardHost: StandardHost {
            @display("p=277,144");
        }
        etherSwitch: EtherSwitch {
            @display("p=131,143");
        }
    connections:
        etherSwitch.ethg++ <--> Ideal <--> standardHost.ethg++;
        for i=0..sizeof(ethg)-1 {
            ethg[i] <--> etherSwitch.ethg++;
        }     
}


// ManagedSwitch enables X- and Y- positioning and consists of an EtherSwitch and a StandardHost. 
// It is used in BuildingBlock .
module ManagedSwitch6 like IManagedSwitch
{
    parameters:
		@display("i=device/router");        
        int swPosX = default(200);
        int swPosY = default(200);
    gates:
        inout ethg[] @labels(EtherFrame-conn);    
    submodules:
        standardHost: StandardHost6 {
            @display("p=277,144");
        }
        etherSwitch: EtherSwitch {
            @display("p=131,143");
        }
    connections:
        etherSwitch.ethg++ <--> Ideal <--> standardHost.ethg++;
        for i=0..sizeof(ethg)-1 {
            ethg[i] <--> etherSwitch.ethg++;
        }     
}

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

package ise.cpvplant.topologies.plants;


import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;

network PlantIPv4 extends Plant
{
    	submodules:

			//How can I specify an interface in the inherited class??   
			// CC.typename =   "ControlCenterIPv4";	    
    	    
        	configurator: IPv4NetworkConfigurator {
				parameters:
          	      @display("p=100,90");
        	}        
}
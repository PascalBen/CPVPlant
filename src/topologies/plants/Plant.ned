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

package ise.cpvplant.topologies.plants;
import inet.nodes.inet.StandardHost;
import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;
import inet.world.radio.ChannelControl;
import ise.cpvplant.interfaces.IBuildingBlock;
import ise.cpvplant.interfaces.IControlCenter;
import ise.cpvplant.applications.NoGatesTestApp;
import ise.cpvplant.applications.PlantAnalyzeApp;
import ise.cpvplant.topologies.RectStarEthernet;
import ise.cpvplant.topologies.RectTopology;
import ise.cpvplant.components.Fibre800m;
import ise.cpvplant.components.Fibre;


//
// The default power plant consist of a Plant Control Center (PPC) implemented as StandardHost
// and an array of BuildingBlock s. The quantity of Blocks can be set up as configuration value numBlocks.
// The two other parameters numT and numS_um are intended to hold the result of the cost calculation during
// the topology generation. This features has not been implemented yet.  
//
network Plant
{
    parameters:
        //quantity of building blocks
        int numBlocks = default(5);
        int distBetweenBlocks @unit(m) = default(800m);

    submodules:
        CC: <default("ControlCenterIPv6")> like IControlCenter {
            @display("p=100,250");
        }

        Blocks[numBlocks]: <default("RectStarEthernet")> like IBuildingBlock {
            @display("p=$posX,$posY");
            posX = 400;
            posY = 400+200*index;
            blockIndex = index;
        }


        plantAnalyzeApp: PlantAnalyzeApp {
            @display("p=400,250");
        }
        channelControl: ChannelControl {
            @display("p=579,249");
        }
    connections:
        for i=0..numBlocks-2, if numBlocks > 1 {
            Blocks[i].phys++ <--> Fibre {  distance = distBetweenBlocks*(i+1); } <--> Blocks[i+1].phys++;
        }
        CC.ethg++ <--> Fibre {  distance = 10m; } <--> Blocks[0].phys++;

}


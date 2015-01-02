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
// created: 	2012-11-19
// author(s):	Pascal Benoit (pascal.benoit@ise.fraunhofer.de)

package ise.cpvplant.components;

import inet.nodes.inet.AdhocHost;
import inet.nodes.inet.StandardHost;
import inet.nodes.ipv6.StandardHost6;
import ise.cpvplant.interfaces.IControlCenter;


//
// ControlCenterIPv4 contains a EtherSwitch and the Power Plant Control PC which is implemented as StandardHost .
//
module ControlCenterIPv4 like IControlCenter
{
    parameters:
        @display("i=device/server_l;is=l");

        int ccPosX = default(200);
        int ccPosY = default(200);

    gates:
        inout ethg[] @labels(EtherFrame-conn);
    submodules:
        S_m: ManagedSwitch {
            @display("p=135,116");
        }
        PPC: StandardHost {
            @display("p=305,117");
        }
    connections:
        //generic for Switch
        for i=0..sizeof(ethg)-1 {
            S_m.ethg++ <--> ethg[i];
        }
        PPC.ethg++ <--> Copper <--> S_m.ethg++;

}

module ControlCenterIPv6 like IControlCenter
{
    parameters:
        @display("i=device/server_l;is=l");

        int ccPosX = default(200);
        int ccPosY = default(200);

    gates:
        inout ethg[] @labels(EtherFrame-conn);
    submodules:
        S_m: ManagedSwitch6 {
            @display("p=135,116");
        }
        PPC: StandardHost6 {
            @display("p=305,117");
        }
    connections:
        //generic for Switch
        for i=0..sizeof(ethg)-1 {
            S_m.ethg++ <--> ethg[i];
        }
        PPC.ethg++ <--> Copper <--> S_m.ethg++;

}

//
// ControlCenterIPv4 contains a EtherSwitch and the Power Plant Control PC which is implemented as StandardHost .
// @author Clara Kowald (clara.ines.kowald@ise.fraunhofer.de)
// @date 2014-02-07
//
module AdhocControlCenterIPv4 like IControlCenter
{
    parameters:
        @display("i=device/server_l;is=l");

        int ccPosX = default(200);
        int ccPosY = default(200);

    gates:
        inout ethg[] @labels(EtherFrame-conn);
    submodules:
        S_m: ManagedSwitch {
            @display("p=135,116");
        }
        PPC: AdhocHost {
            @display("p=305,117");
            numRadios = 0;
        }
    connections:
        //generic for Switch
        for i=0..sizeof(ethg)-1 {
            S_m.ethg++ <--> ethg[i];
        }
        PPC.ethg++ <--> Copper <--> S_m.ethg++;

}



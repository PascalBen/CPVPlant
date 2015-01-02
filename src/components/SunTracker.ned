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

//package ise;
package ise.cpvplant.components;

import inet.nodes.inet.AdhocHost;
import inet.nodes.inet.StandardHost;
import inet.nodes.ipv6.StandardHost6;
import ise.cpvplant.applications.SendApp;
import ise.cpvplant.applications.TCPSendApp;
import ise.cpvplant.interfaces.ISunTracker;


module WLANIPv4SunTracker extends AdhocHost like ISunTracker
{
    parameters:
        @display("i=device/tracker;is=vs");

        int trackPosX = default(200);
        int trackPosY = default(200);
        bool hasPingApp = default(false);
        bool hasTCPPollingApp = default(false);

    submodules:
        sendApp: SendApp if hasPingApp {
            @display("p=244,141");
        }
        TCPSendApp: TCPSendApp if hasTCPPollingApp {
            @display("p=147,225");
        }
    connections allowunconnected:
        sendApp.msgOut --> networkLayer.pingIn++ if hasPingApp;
        sendApp.msgIn <-- networkLayer.pingOut++ if hasPingApp;
        TCPSendApp.tcpOut --> tcp.appIn++ if hasTCPPollingApp;
        TCPSendApp.tcpIn <-- tcp.appOut++ if hasTCPPollingApp;
}

module WLANIPv6SunTracker extends StandardHost6 like ISunTracker
{
    parameters:
        @display("i=device/tracker");

        int trackPosX = default(200);
        int trackPosY = default(200);
        bool hasTCPPollingApp = default(false);

}


module EthernetIPv4SunTracker extends StandardHost like ISunTracker
{
    parameters:
        @display("i=device/tracker");

        int trackPosX = default(200);
        int trackPosY = default(200);
}


module EthernetIPv6SunTracker extends StandardHost6 like ISunTracker
{
    parameters:
        @display("i=device/tracker");

        int trackPosX = default(200);
        int trackPosY = default(200);
}

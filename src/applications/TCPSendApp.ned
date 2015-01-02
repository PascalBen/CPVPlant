//
// Copyright (C) 2014 Fraunhofer Institut for Solar Energy Systems 
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
// created: 	2014-03-07
// author(s):	Clara Kowald (clara.ines.kowald@ise.fraunhofer.de)

package ise.cpvplant.applications;

//
//This is an application that polls the indicated hosts in the network
// @author	Clara Kowald (clara.ines.kowald@ise.fraunhofer.de)
// @date 	2014-03-07
//
simple TCPSendApp
{
    parameters:
        string localAddress = default(""); // may be left empty ("")
        int localPort = default(1000); // is set to 1000 in order to avoid a inet-error (does only free port 1000 at the end of a connection)
        int connectPort = default(1000);
        int maxCycles = default(-1); //number of max polling cycles; default = -1 means there is no max number
        string srcAddr = default(""); // source address
        double startTime @unit("s") = default(uniform(0s,this.sendInterval)); // send first ping at startTime
        string dataTransferMode @enum("bytecount","object","bytestream") = default("bytecount");
        volatile int requestLength @unit(B) = default(200B); // length of a request
        volatile int replyLength @unit(B) = default(1MiB); // length of a reply
        volatile int numRequestsPerSession = default(1);  // number of requests sent per session
        volatile double thinkTime @unit(s); // time gap between requests
        volatile double idleInterval @unit(s); // time gap between sessions
        volatile double reconnectInterval @unit(s) = default(0.1s);  // if connection breaks, waits this much before trying to reconnect
    gates:
        input tcpIn @labels(TCPCommand/up);
        output tcpOut @labels(TCPCommand/down);
}

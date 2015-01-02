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
simple SendApp
{
    parameters:
        string srcAddr = default(""); // source address (useful with multi-homing)
        double startTime @unit("s") = default(uniform(0s,this.sendInterval)); // send first ping at startTime
    gates:
        input msgIn @labels(PingPayload/up);
        output msgOut @labels(PingPayload/down);
}

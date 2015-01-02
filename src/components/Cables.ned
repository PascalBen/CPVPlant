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

@license(LGPL);
package ise.cpvplant.components;

import ned.DatarateChannel;


//
// The implementation of ExtDatarateChannel adds the parameters distance and the function double getDistance()
//
channel ExtDatarateChannel extends DatarateChannel
{
    parameters:
        double distance @unit(m) = default(1.0m);
}


channel Ideal extends ExtDatarateChannel
{
    parameters:
        //Copper: wikipedia says 5ns/m for CAT5 -> means 2e8 m/s
        delay = 0s;
        datarate = 1000Mbps;
        per = 0.00;	//packet error rate
        ber = 0.00; 	// bit error rate
}


// Standard Ethernet copper cable that allows to calculate delay out of distance in meter
channel Copper extends ExtDatarateChannel
{
    parameters:
        //Copper: wikipedia says 5ns/m for CAT5 -> means 2e8 m/s
        distance @unit(m) = default(25m); 
        delay = (this.distance / 200000km ) * 1s;//Copper: wikipedia says 5ns/m for CAT5 -> means 2e8 m/s
        datarate = 1000Mbps;
        per = 0.00;	//packet error rate
        ber = 0.00; 	// bit error rate
}

// Standard Ethernet fibre cable that allows to calculate delay out of distance in meter
channel Fibre extends ExtDatarateChannel
{
    parameters:
        //Speed estimation: 2.7e8 m/s
        distance @unit(m) = default(800m);	//Speed estimation: 2.7e8 m/s
        delay = (this.distance / 270000km ) * 1s;
        datarate = 1000Mbps;
        per = 0.00;	//packet error rate
        ber = 0.00; 	// bit error rate
}

channel Fibre800m extends Fibre
{
    parameters:
        distance = 800m;
}

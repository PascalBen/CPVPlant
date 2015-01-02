/**
 * @file
 * @author Clara Kowald <clara.ines.kowald@ise.fraunhofer.de>
 * @version 1.0
 *
 * @section LICENSE
 *
 * Copyright (C) 2014 Fraunhofer Institut for Solar Energy Systems
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 *
 * @section DESCRIPTION
 *
 * Application to poll other hosts
 *
 */

#ifndef SENDAPP_H_
#define SENDAPP_H_

class SendApp : public cSimpleModule{
public:
    SendApp();
    ~SendApp();

    virtual int numInitStages() const { return 4; }

    /**
     * Initiates a self-message that provokes the first polling message
     *
     * @param destAddr
     * @param srcAddr
     */
    virtual void initialize(int stage);

    /**
     * Manages the self-messages (to send first polling message) and the incoming messages
     * which provoke the polling of the next host
     *
     * @param msg
     */
    virtual void handleMessage(cMessage *msg);

    virtual IPvXAddress getSrcAddress(PingPayload *msg);

    /**
     * Function that sends ping message to the indicated destination address
     *
     * @param destAddr
     * @param srcAddr
     */
    virtual void sendMessage(IPvXAddress destAddr, IPvXAddress srcAddr);

    /**
     * Function that gets the number of hosts that have to polled
     *
     * @author Pascal Benoit
     * @param destAddr
     * @param srcAddr
     */
    virtual void getAddressesOfTrackers();

    //virtual void finish();


protected:
    int packetSize;
    int hopLimit;
    std::vector<IPv4Address> destAddresses;
    IPvXAddress srcAddr;
    IPvXAddress destAddr;
    int destAddrCount;
    int sendSeqNo;
    int trackerNo;
    //cDoubleHistogram msgTimeStats;
    cOutVector msgTimeVector;
    simtime_t time;
    //cDoubleHistogram pollingTimeStats;
    cOutVector pollingTimeVector;
    simtime_t pollingTime;
    cMessage *timer;

};

#endif /* SENDAPP_H_ */

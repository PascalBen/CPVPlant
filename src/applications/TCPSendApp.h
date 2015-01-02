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

#include "INETDefs.h"

#include "TCPAppBase.h"
#include "NodeStatus.h"

#ifndef SENDAPP_H_
#define SENDAPP_H_

class INET_API TCPSendApp : public TCPAppBase
{
public:
    TCPSendApp();
    ~TCPSendApp();

    virtual int numInitStages() const { return 4; }

    /**
     * Initiates a self-message that provokes the first polling message
     *
     * @param destAddr
     * @param srcAddr
     */
    virtual void initialize(int stage);

    /**
     * Function that gets the number of hosts that have to be polled
     *
     * @param destAddr
     * @param srcAddr
     */
    virtual void getAddressesOfTrackers();

    /**
     * Function that gets a connection to the destination address that is indicated
     *
     * @param destAddr
     */
    virtual void connect(IPvXAddress destAddr);

    virtual void handleTimer(cMessage *msg);

    virtual void sendRequest();

    virtual void socketEstablished(int, void *);

    virtual void rescheduleOrDeleteTimer(simtime_t d, short int msgKind);

    virtual void socketDataArrived(int connId, void *ptr, cPacket *msg, bool urgent);

    virtual void socketClosed(int connId, void *ptr);

    virtual void socketFailure(int connId, void *ptr, int code);

//    virtual void switchWlanInterface();

//    virtual void socketStatusArrived(int connId, void *yourPtr, TCPStatusInfo *status);

protected:
    int packetSize;
    int replyLength;
    int hopLimit;
    std::vector<IPv4Address> destAddresses;
    IPvXAddress srcAddr;
    int destAddrCount;
    int sendSeqNo;
    int trackerNo;
    int numRequestsToSend; // requests to send in this session
    //cOutVector msgTimeVector;
    simtime_t time;
    simtime_t startTime;
    simtime_t stopTime;
    cOutVector pollingTimeVector;
    simtime_t pollingTime;
    cMessage *timermsg;
    int maxCycles;
    int cycleNumber;
};

#endif /* SENDAPP_H_ */

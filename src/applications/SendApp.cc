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

#include <omnetpp.h>
#include <iostream>
#include <vector>
#include <string>
#include "IPvXAddressResolver.h"
#include "IPv4ControlInfo.h"
#include "IPv6ControlInfo.h"
#include "INETDefs.h"
#include "PingPayload_m.h"
#include "coutvector.h"
#include <IPv4Datagram.h>
#include "IInterfaceTable.h"
#include "InterfaceEntry.h"
#include "IPv4InterfaceData.h"
#include <IPv4.h>

#include "IPvXAddress.h"

#include "SendApp.h"

Define_Module(SendApp);

SendApp::SendApp(){

    msgTimeVector.setName("SimTime");
    pollingTimeVector.setName("PollingTime");

    msgTimeVector.setType(cOutVector::TYPE_DOUBLE);
    pollingTimeVector.setType(cOutVector::TYPE_DOUBLE);

}

SendApp::~SendApp(){

}

void SendApp::initialize(int stage) {

    cSimpleModule::initialize(stage);

    if (stage != 3)
        return;

    packetSize = 56;  //TODO: ini
    hopLimit = 32;
    destAddrCount = 0;
    sendSeqNo = 0;

    ev << "SendApp wurde initialisiert\n";

    getAddressesOfTrackers();

    //get first destination address
    if(!destAddresses.size()){

        return;
    }

    destAddr = destAddresses[0];

    //get source address
    srcAddr = IPvXAddressResolver().resolve(par("srcAddr"));

    getDisplayString().setTagArg("t",0, "Hallo!");

    timer = new cMessage("sendPing");
    scheduleAt(par("startTime"), timer);

    time = (par("startTime"));
    pollingTime = (par("startTime"));
}


void SendApp::handleMessage(cMessage *msg)
{

    //either time-out for first message to send
    //or probably a message got lost => time-out => message is resent
    if (msg->isSelfMessage())
    {

        std::cout << "timer wird aufgerufen\n";

        //new timer for same destination:
        timer = new cMessage("sendPing");
        //simtime_t nextPing = simTime() + 1.0;   //TODO: Interval is hard coded => change
        simtime_t nextPing = simTime() + 1.0;   //TODO: Interval is hard coded => change
        scheduleAt(nextPing, timer);

        //Send Message to chosen destination
        sendMessage(destAddr, srcAddr);

    }
    else
    {

        // process ping response
        IPvXAddress src = getSrcAddress(check_and_cast<PingPayload *>(msg));

        //check if the answer of this src was already received:
        if(destAddr.equals(src)){

            simtime_t last_time;

            //delete old timer
            cancelAndDelete(timer);

            //new timer for same destination
            timer = new cMessage("sendPing");
            simtime_t nextPing = simTime() + 1.0;   //TODO: Interval is hard coded => change
            scheduleAt(nextPing, timer);

            //calculate number of next destination
            destAddrCount = (destAddrCount+1)%destAddresses.size();

            //send message to next destination
            destAddr = destAddresses[destAddrCount];

            //Recording before each message
            last_time = time;
            time = simTime();
            msgTimeVector.record(time - last_time);

            //Recording before every polling cycle
            if(destAddrCount == 0){

                  simtime_t last_pollingTime = pollingTime;
                  pollingTime = simTime();

                  pollingTimeVector.record(pollingTime - last_pollingTime);
            }

            //Send Message to chosen destination
            sendMessage(destAddr, srcAddr);
        }
    }

}

IPvXAddress SendApp::getSrcAddress(PingPayload *msg){

    IPv4ControlInfo *ctrl = (IPv4ControlInfo *)msg->getControlInfo();
    IPvXAddress src = ctrl->getSrcAddr();

    return src;
}

void SendApp::sendMessage(IPvXAddress destAddr, IPvXAddress srcAddr){

    ev << "Nachricht nach " << destAddr << "\n";

    PingPayload *msg = new PingPayload("hallo");
    msg->setOriginatorId(getId());
    msg->setSeqNo(sendSeqNo);
    msg->setByteLength(packetSize);

    // send to IPv4
    IPv4ControlInfo *ctrl = new IPv4ControlInfo();
    ctrl->setSrcAddr(srcAddr.get4());
    ctrl->setDestAddr(destAddr.get4());
    ctrl->setTimeToLive(hopLimit);
    msg->setControlInfo(ctrl);
    send(msg, "msgOut");
    emit(SIMSIGNAL_NULL, 1);

    sendSeqNo++;
}

void SendApp::getAddressesOfTrackers() {
    cTopology topo;
    topo.extractByNedTypeName(cStringTokenizer("ise.cpvplant.components.WLANIPv4SunTracker").asVector());

    //look at every tracker of the topology and collect the IP-Addresses of every interface
    for (int i=0; i<topo.getNumNodes(); i++){

        cModule *mod = topo.getNode(i)->getModule();
        IInterfaceTable *ift = IPvXAddressResolver().findInterfaceTableOf(mod);

        for (int k=0; k<ift->getNumInterfaces(); k++)
        {
            InterfaceEntry *ie = ift->getInterface(k);

            if (strstr(ie->getName(), "wlan")!=NULL)
            {
                IPv4Address ip = ie->ipv4Data()->getIPAddress();
                destAddresses.push_back(ip);

                ev << "IP-Adresse: " << ip << "\n";
            }
        }
    }
}

/*void SendApp::finish(){
    //msgTimeStats.recordAs("SimTime_stats");
    //pollingTimeStats.recordAs("PollingTime_stats");
}*/





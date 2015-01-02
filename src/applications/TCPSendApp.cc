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
#include "IInterfaceTable.h"
#include "InterfaceEntry.h"
#include "IPv4InterfaceData.h"
#include "GenericAppMsg_m.h"
#include "NodeOperations.h"

#include "IPvXAddress.h"

#include "TCPSendApp.h"

Define_Module(TCPSendApp);

#define FIRST_MSG        0
#define MSGKIND_SEND     1

int failure_flag;

TCPSendApp::TCPSendApp(){

//    msgTimeVector.setName("SimTime");
    pollingTimeVector.setName("PollingTime");

//    msgTimeVector.setType(cOutVector::TYPE_DOUBLE);
    pollingTimeVector.setType(cOutVector::TYPE_DOUBLE);

    timermsg = NULL;

}

TCPSendApp::~TCPSendApp(){

    cancelAndDelete(timermsg);
}

void TCPSendApp::initialize(int stage) {

    TCPAppBase::initialize(stage);
    if (stage != 3)
        return;

    hopLimit = 10;
    destAddrCount = 0;
    sendSeqNo = 0;

    ev << "TCPSendApp wurde initialisiert\n";

    getAddressesOfTrackers();

    getDisplayString().setTagArg("t",0, "Hallo!");

    timermsg = new cMessage("timer");
    timermsg->setKind(FIRST_MSG);
    scheduleAt(par("startTime"), timermsg);
    replyLength = par("replyLength");

    time = (par("startTime"));
    pollingTime = (par("startTime"));
    maxCycles = par("maxCycles");
    cycleNumber = 0;

    //switchWlanInterface();

    //signales a socket failure:
    failure_flag = 0;
}

/*void TCPSendApp::switchWlanInterface(){

    //Versuch: parameter aus wlan-Interface auslesen und ändern:
    cTopology topo;
    topo.extractByNedTypeName(cStringTokenizer("ise.cpvplant.components.WLANIPv4SunTracker").asVector());

    //Print
    cModule *mod = topo.getNode(1)->getModule();
    cModule *wlan_int = mod->getSubmodule("wlan", 0);
    double bitrate = wlan_int->par("bitrate");
    std::cout << "bitrate: " << bitrate << "\n";
}*/


void TCPSendApp::handleTimer(cMessage *msg)
{

    IPvXAddress destAddr;
    simtime_t last_time;

    switch (msg->getKind())
    {
        case FIRST_MSG:

            //get first destination address
            if(!destAddresses.size()){

                return;
            }
            destAddr = destAddresses[0];

            //First recording for the message sending time
            time = simTime();

            //First recording for the polling cycle time
            pollingTime = simTime();

            //TCP connection
            connect(destAddr);

            //get source address
            srcAddr = IPvXAddressResolver().resolve(par("srcAddr"));

            break;

        case MSGKIND_SEND:

            //stop simulation if maximal number of polling cycles is reached
            if(maxCycles != -1 && cycleNumber >= maxCycles){
                EV << "Maximal number of polling cycles is reached: " << maxCycles << " -> Stop simulation\n";
                endSimulation();
            }

            //check if failure occured -> same tracker is polled
            if(failure_flag){

                failure_flag = 0;
            }else{
                //calculate number of next destination
                destAddrCount = (destAddrCount+1)%destAddresses.size();
            }

            //send message to next destination
            destAddr = destAddresses[destAddrCount];

            ev << destAddrCount << ". Nachricht nach " << destAddr << "\n";

            //Recording before each message
            last_time = time;
            time = simTime();
            //msgTimeVector.record(time - last_time);

            //Recording before every polling cycle
            if(destAddrCount == 0){

                  simtime_t last_pollingTime = pollingTime;
                  pollingTime = simTime();

                  pollingTimeVector.record(pollingTime - last_pollingTime);
                  cycleNumber++;
            }

            //TCP connection
            connect(destAddr);

           break;

        default:
            throw cRuntimeError("Invalid timer msg: kind=%d", msg->getKind());
    }
}

void TCPSendApp::socketEstablished(int connId, void *ptr)
{

    TCPAppBase::socketEstablished(connId, ptr);

    // determine number of requests in this session
    numRequestsToSend = (long) par("numRequestsPerSession");
    if (numRequestsToSend < 1)
        numRequestsToSend = 1;

    // perform first request if not already done (next one will be sent when reply arrives)
    sendRequest();

    numRequestsToSend--;
}

void TCPSendApp::sendRequest()
{
     EV << "sending request, " << numRequestsToSend-1 << " more to go\n";

     long requestLength = par("requestLength");
     long replyLength = par("replyLength");
     if (requestLength < 1)
         requestLength = 1;
     if (replyLength < 1)
         replyLength = 1;

     GenericAppMsg *msg = new GenericAppMsg("data");
     msg->setByteLength(requestLength);
     msg->setExpectedReplyLength(replyLength);
     msg->setServerClose(false);

     sendPacket(msg);
}

void TCPSendApp::connect(IPvXAddress destAddr)
{

    // we need a new connId if this is not the first connection
    socket.renewSocket();

    // connect
    int connectPort = par("connectPort");

    EV << "issuing OPEN command\n";
    setStatusString("connecting");

    socket.connect(destAddr, connectPort);
}


void TCPSendApp::getAddressesOfTrackers() {
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


void TCPSendApp::rescheduleOrDeleteTimer(simtime_t d, short int msgKind)
{
    cancelEvent(timermsg);

    timermsg->setKind(msgKind);
    scheduleAt(d, timermsg);
}

void TCPSendApp::socketDataArrived(int connId, void *ptr, cPacket *msg, bool urgent)
{
    bytesRcvd += msg->getByteLength();
    //emit(rcvdPkSignal, msg);
    delete msg;

    if (numRequestsToSend > 0)
    {
        EV << "reply arrived\n";


        if (msg)
        {
            simtime_t d = simTime() + (simtime_t) par("thinkTime");
            rescheduleOrDeleteTimer(d, MSGKIND_SEND);
        }
    }else if(bytesRcvd >= replyLength)
    {
        EV << "reply to last request arrived, closing session\n";

        close();

        bytesRcvd = 0;
    }
}

void TCPSendApp::socketClosed(int connId, void *ptr)
{
    TCPAppBase::socketClosed(connId, ptr);

    // start another session after a delay
    if (timermsg)
    {

        simtime_t d = simTime() + (simtime_t) par("idleInterval");
        rescheduleOrDeleteTimer(d, MSGKIND_SEND);
    }
}


void TCPSendApp::socketFailure(int connId, void *ptr, int code)
{
    TCPAppBase::socketFailure(connId, ptr, code);

    failure_flag = 1;

    // reconnect after a delay
    if (timermsg)
    {
        simtime_t d = simTime() + (simtime_t) par("reconnectInterval");
        rescheduleOrDeleteTimer(d, MSGKIND_SEND);
    }
}



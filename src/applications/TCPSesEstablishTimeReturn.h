//
// Copyright 2004 Andras Varga
//
// This library is free software, you can redistribute it and/or modify
// it under  the terms of the GNU Lesser General Public License
// as published by the Free Software Foundation;
// either version 2 of the License, or any later version.
// The library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU Lesser General Public License for more details.
//


#include <omnetpp.h>

#include "INETDefs.h"

#include "TCPSocket.h"

#ifndef TCPSESESTABLISHTIMERETURN_H_
#define TCPSESESTABLISHTIMERETURN_H_


class INET_API TCPSesEstablishTimeReturn : public cSimpleModule{
protected:
    struct Command
    {
        simtime_t tSend;
        int numBytes;
    };
    typedef std::vector<Command> CommandVector;
    CommandVector commands;

    TCPSocket socket;

    // statistics
    int packetsRcvd;
    long bytesRcvd;
    long bytesSent;
    int indicationsRcvd;
    static simsignal_t rcvdPkSignal;
    static simsignal_t sentPkSignal;
    static simsignal_t recvIndicationsSignal;
    simtime_t tTCPEstablished;

  public:
    TCPSesEstablishTimeReturn() : cSimpleModule(65537) {}

  protected:
    virtual void parseScript(const char *script);
    virtual void waitUntil(simtime_t t);
    virtual void count(cMessage *msg);

    virtual cPacket* genDataMsg(long sendBytes);

    virtual void activity();
    virtual void finish();


};

#endif


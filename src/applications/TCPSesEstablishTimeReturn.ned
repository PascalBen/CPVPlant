//
// Copyright (C) 2004 Andras Varga
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



package ise.cpvplant.applications;
import inet.applications.ITCPApp;


simple TCPSesEstablishTimeReturn like ITCPApp
{
   parameters:
       	string localAddress = default("");
        int localPort = default(-1);  // local port
        bool active = default(true);
        string connectAddress;
        int connectPort = default(1000);
        string dataTransferMode @enum("bytecount","object","bytestream") = default("bytecount");
        double tOpen @unit(s) = default(1s);
        double tSend @unit(s) = default(1s);
        int sendBytes @unit(B) = default(1MiB);
        string sendScript = default("");
        double tClose @unit(s) = default(2s);
        @display("i=block/app");
        @signal[sentPk](type=cPacket);
        @signal[rcvdPk](type=cPacket);
        @signal[rcvdIndications](type=cMessage);
        @signal[endToEndDelay](type=simtime_t;unit=s);
        @statistic[rcvdPk](title="packets received"; source=rcvdPk; record=count,"sum(packetBytes)","vector(packetBytes)"; interpolationmode=none);
        @statistic[sentPk](title="packets sent"; source=sentPk; record=count,"sum(packetBytes)","vector(packetBytes)"; interpolationmode=none);
        @statistic[endToEndDelay](title="end-to-end delay"; source="messageAge(rcvdPk)"; unit=s; record=histogram,vector; interpolationmode=none);
       
   gates:
       	input tcpIn @labels(TCPCommand/up);
       	output tcpOut @labels(TCPCommand/down);
           
}







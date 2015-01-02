/*
 * (c) Fraunhofer Institut for Solar Energy Systems (ISE)
 * Division Electrical Energy Systems (EES)
 * Department Intelligent Energy Systems (IES)
 *
 * SecondApp.cc
 *
 * Created on:  Nov 19, 2012
 * Author(s):   Pascal Benoit
 *
 */

#include <omnetpp.h>
#include <cpar.h>

#include "Topology.h"
#include "NoGatesTestApp.h"

Define_Module(NoGatesTestApp);


void NoGatesTestApp::initialize(int stage) {
    ev << "NoGatesTestApp Simulation-Stage: " << stage;

    cTopology topo("topo");
    // NodeInfoVector nodeInfo; // will be of size topo.nodes[]
    topo.extractByProperty("node");
    ev << "cTopology found " << topo.getNumNodes() << " nodes\n";
    ev << topo.getNamePooling();
    recordScalar("numTrs",topo.getNumNodes() );

    Topology::Node *node;
    cModule *module;
    for (int i = 0 ; i < topo.getNumNodes() ; i++  ) {
        node = (Topology::Node *) topo.getNode(i);
        //module  =   node->getModule();
        //ev << "full name: " << module->getFullName() << "\n";


        //ev << " Num of Paths for node  " << i << " is: " << module->getName() << "\n";


        //ev <<  module->getFullPath() << " \n";
        //(id=" << << "


    }


}



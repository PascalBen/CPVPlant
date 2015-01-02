/*
 * (c) Fraunhofer Institut for Solar Energy Systems (ISE)
 * Division Electrical Energy Systems (EES)
 * Department Intelligent Energy Systems (IES)
 *
 * Plant.cc
 *
 * Created on:  Nov 19, 2012
 * Author(s):   Pascal Benoit
 *
 */

#include <omnetpp.h>
#include <cpar.h>

#include "Plant.h"


Define_Module(Plant);



void Plant::initialize(int stage) {

    ev << "Plant Simulation-Stage: " << stage;
    printf("Plant Simulation-Stage: %i",stage);

    if (stage == 2) {
        //numS_m  =   0;
        //    numS_um =   0;
        //    numT    =   1000;

        //    WATCH(numS_m);
        //    WATCH(numS_um);
        //    WATCH(numT);





            cTopology topo("topo");
           // NodeInfoVector nodeInfo; // will be of size topo.nodes[]
            topo.extractByProperty("node");
            EV << "cTopology found " << topo.getNumNodes() << " nodes\n";

            recordScalar("numTrs",topo.getNumNodes() );
    }



}
void Plant::finish() {
    ev << "PlantCCTest!!";

    //recordScalar("testA", 10111, "s");
    //recordScalar("numT", 1055, "s");

    //recordScalar("testZwei", 5423.0, "");

}

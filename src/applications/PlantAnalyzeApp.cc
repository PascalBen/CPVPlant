/*
 * (c) Fraunhofer Institut for Solar Energy Systems (ISE)
 * Division Electrical Energy Systems (EES) 
 * Department Intelligent Energy Systems (IES)
 * 
 * PlantAnalyzeApp.cc
 *
 * Created on:	Jan 21, 2013
 * Author(s):	Pascal Benoit
 *
 */



#include <omnetpp.h>
#include "Topology.h"
#include "PlantAnalyzeApp.h"

//NOTE: all doxygen comments specifying the functions in header file PlantAnalyzeApp.h!

Define_Module(PlantAnalyzeApp);

PlantAnalyzeApp::PlantAnalyzeApp() {
    numTrackers     =   0;
    numSwitches     =   0;
    numSwitchesM    =   0;
    numSwitchesUM   =   0;
    lengthEthernet  =   0;
    lengthFiber     =   0;
    lengthTotal     =   0;
}

void PlantAnalyzeApp::initialize(int stage) {
    if (stage == 5) {
        analyzePlant();
        updateDisplay();
    }
}

void PlantAnalyzeApp::analyzePlant() {
    std::map<std::set<unsigned>, EdgeAttr> edgeTopology;

    numBlocks       =   getNumberOfBlocks();
    numTrackerWE    =   getNumberOfTrackerWE();
    numTrackerNS    =   getNumberOfTrackerNS();
    numNodes        =   getNumberOfNodes();
    numTrackers     =   getNumberOfTrackers();
    numSwitchesUM   =   getNumberOfSwitchesUM();
    numSwitchesM    =   getNumberOfSwitchesM();
    numSwitches =   numSwitchesM + numSwitchesUM;

    edgeTopology    =   getEdgeTopology();
    //showTopologyMap(edgeTopology);
    lengthEthernet  =   getChannelLengthCopper(edgeTopology);
    lengthFiber     =   getChannelLengthFibre(edgeTopology);
    lengthTotal     =   getChannelLengthTotal(edgeTopology);
}

void PlantAnalyzeApp::finish() {

    recordScalar("numBlocks", numBlocks);
    recordScalar("numTrackerWE", numTrackerWE);
    recordScalar("numTrackerNS", numTrackerNS);
    recordScalar("numNodes", numNodes);
    recordScalar("numTrackers", numTrackers);
    recordScalar("numSwitches", numSwitches);
    recordScalar("numSwitchesM", numSwitchesM);
    recordScalar("numSwitchesUM", numSwitchesUM);
    recordScalar("lengthEthernet", lengthEthernet);
    recordScalar("lengthFiber", lengthFiber);
    recordScalar("lengthTotal", lengthTotal);
}

void PlantAnalyzeApp::updateDisplay() {
    if ( !ev.isGUI() )
        return;

    char out[100];
    sprintf(out, "nodes N=%d\ntrackers T=%d\nswitches S=%d\nEth Cable=%lf\n Fibre=%lf\n Total=%lf\n", numNodes,numTrackers,numSwitches,lengthEthernet,lengthFiber,lengthTotal);
    getDisplayString().setTagArg("t",0, out);

}


int PlantAnalyzeApp::getNumberOfBlocks() {
    cTopology topo;
    cTopology::Node *node;
    cModule *module;
    cPar *distPar;
    int result;

    result = -1;
    topo.extractByNedTypeName(cStringTokenizer("ise.cpvplant.topologies.plants.PlantIPv4").asVector());
    if ( topo.getNumNodes() > 0) {
        node   = topo.getNode(0);
        module = node->getModule();
        distPar = &module->par("numBlocks");
        result = (int) distPar->doubleValue();
    } else {
        ev << "Error PlantAnalyzeApp::getNumberOfBlocks() module Plant found. ";
        return -1;
    }

    return result;
}

int PlantAnalyzeApp::getNumberOfTrackerWE() {
    cTopology topo;
    cTopology::Node *node;
    cModule *module;
    cPar *distPar;
    int result;

    result = -1;
    topo.extractByNedTypeName(cStringTokenizer("ise.cpvplant.topologies.RectTopologyEthernet").asVector());
    if ( topo.getNumNodes() > 0) {
        node   = topo.getNode(0);
        module = node->getModule();
        distPar = &module->par("numTrackerWE");
        result = (int) distPar->doubleValue();
    } else {
        ev << "Error PlantAnalyzeApp::getNumberOfTrackerWE() No IBuildingBlock found. ";
        return -1;
    }
    return result;
}

int PlantAnalyzeApp::getNumberOfTrackerNS() {
    cTopology topo;
    cTopology::Node *node;
    cModule *module;
    cPar *distPar;
    int result;

    result = -1;
    topo.extractByNedTypeName(cStringTokenizer("ise.cpvplant.topologies.RectTopologyEthernet").asVector());
    if ( topo.getNumNodes() > 0) {
        node   = topo.getNode(0);
        module = node->getModule();
        distPar = &module->par("numTrackerNS");
        result = (int) distPar->doubleValue();
    } else {
        ev << "Error PlantAnalyzeApp::getNumberOfTrackerNS() No IBuildingBlock found. ";
        return -1;
    }
    return result;
}

int PlantAnalyzeApp::getNumberOfNodes() {
    cTopology topoNodes;
    topoNodes.extractByProperty("node");
    return topoNodes.getNumNodes();
}

int PlantAnalyzeApp::getNumberOfTrackers() {
    cTopology topoTracker;
    topoTracker.extractByNedTypeName(cStringTokenizer("ise.cpvplant.components.EthernetIPv4SunTracker").asVector());
    return topoTracker.getNumNodes();
}

int PlantAnalyzeApp::getNumberOfSwitchesUM() {
    cTopology topoSwitchesUM;
    topoSwitchesUM.extractByNedTypeName(cStringTokenizer("ise.cpvplant.components.EtherSwitchPos").asVector());
    return topoSwitchesUM.getNumNodes();
}

int PlantAnalyzeApp::getNumberOfSwitchesM() {
    cTopology topoSwitchesM;
    topoSwitchesM.extractByNedTypeName(cStringTokenizer("ise.cpvplant.components.ManagedSwitch").asVector());
    return topoSwitchesM.getNumNodes();
}


std::map<std::set<unsigned>, PlantAnalyzeApp::EdgeAttr> PlantAnalyzeApp::getEdgeTopology() {
    cTopology topoNodes;
    cTopology::Node *node;
    cModule *module;
    cTopology::LinkIn *linkIn;
    EdgeAttr edge;
    cChannel* ch;
    std::set<unsigned> nodesIDs;

    //map:
    // * most efficient direct access to elements
    // * assignation between two elements as pair
    //std::set<unsigned> is the first element of pair and contains the two ModuleIDs the edge connects in a unordered manner
    //Edge is the second element of the pair, it contains all attributes
    std::map<std::set<unsigned>, EdgeAttr> edgeTopology;

    /*
     * map:
     *   +------------------------ First Module-ID connected to the edge
     *   |
     *   | +---------------------- Second Module-ID connected to the edge
     *   | |
     *   | |      +--------------- Attribute object of type Edge
     *   | |      |
     *  (4,6) -> Edge( 4,6,20m  )
      *  (4,7) -> Edge( 4,7,500m )
     *
     */

    topoNodes.extractByProperty("node");

    //iterating every node
    for ( int i=0 ; i<topoNodes.getNumNodes() ; i++ ) {
        node = topoNodes.getNode(i);
        module = node->getModule();

        //iteration over every in-link of a node
        for (int j=0; j<node->getNumInLinks(); j++)  {

            linkIn      =   node->getLinkIn(j);
            ch          =   linkIn->getRemoteGate()->getTransmissionChannel();

            edge.nodeA          =   node->getModuleId();
            edge.nodeB          =   linkIn->getRemoteNode()->getModuleId();
            edge.distance       =   getChannelLength(linkIn->getRemoteGate());
            edge.nedTypeName    =   ch->getNedTypeName();

            nodesIDs = std::set<unsigned>(); //Explicit call of constructor to generate new instance during each for-run
            nodesIDs.insert(edge.nodeA);
            nodesIDs.insert(edge.nodeB);

            //ev << "size of nodes_unordered: " << nodesIDs.size() << "\n";

            //since map's require a unique key, the insert function allready checks if there is no doubled entry
            edgeTopology.insert(std::make_pair(nodesIDs,edge));

            //std::map<std::set<unsigned>, EdgeAttr>::iterator iter = edgeTopology.find(nodesIDs);

            //if the edge is new
            //if(iter==edgeTopology.end())    {
            //    edgeTopology.insert(std::make_pair(nodesIDs,edge));
                //ev << "Adding : [" << edge.nodeA << "]<->[" << edge.nodeB << "] ( "<< edge.distance << " m) as " << edge.nedTypeName << " , size=" << edgeTopology.size() <<"\n";
            //} else {
                //ev << "NOT Adding : [" << edge.nodeA << "]<->[" << edge.nodeB << "] ( "<< edge.distance << " m), size=" << node_map.size() <<"\n";
            //}
        }
    }
    return edgeTopology;
}


double PlantAnalyzeApp::getChannelLengthOfNedType( std::map<std::set<unsigned>, EdgeAttr> topoMap, const char* nedTypeName ) {
    EdgeAttr edge;
    double result;

    result = 0;

    for (std::map<std::set<unsigned>, EdgeAttr>::iterator it = topoMap.begin(); it!=topoMap.end(); ++it  ) {
        edge    =   it->second;
        if ( !strcmp(edge.nedTypeName, nedTypeName) ) {
            result += edge.distance;
            //ev << "adding " << edge.distance << "m to " << nedTypeName << " result= " << result << "\n";
        }
    }

    return result;
}


double PlantAnalyzeApp::getChannelLengthTotal( std::map<std::set<unsigned>, EdgeAttr> topoMap) {
    EdgeAttr edge;
    double result;

    result = 0;

    for (std::map<std::set<unsigned>, EdgeAttr>::iterator it = topoMap.begin(); it!=topoMap.end(); ++it  ) {
        edge    =   it->second;
        result += edge.distance;
    }

    return result;
}

double PlantAnalyzeApp::getChannelLengthFibre( std::map<std::set<unsigned>, EdgeAttr> topoMap ) {
    double result;
    result  =   0;
    result  +=  getChannelLengthOfNedType(topoMap, "ise.cpvplant.components.Fibre" );
    result  +=  getChannelLengthOfNedType(topoMap, "ise.cpvplant.components.Fibre800m" );
    return result;
}

double PlantAnalyzeApp::getChannelLengthCopper( std::map<std::set<unsigned>, EdgeAttr> topoMap ) {
    return getChannelLengthOfNedType(topoMap, "ise.cpvplant.components.Copper" );
}

double PlantAnalyzeApp::getChannelLength(cGate *gate) {
    cChannel* ch;
    cPar *distPar;
    ch = gate->getTransmissionChannel();

    distPar     =  &ch->par("distance");
    //ch->getNedTypeName()
    return distPar->doubleValue();
}

void PlantAnalyzeApp::showTopologyMap(std::map<std::set<unsigned>, EdgeAttr> topoMap) {
    int i=0;

    EdgeAttr edge;
    ev << "Edges of the topology (total " << topoMap.size() << " edges)\n";


    for (std::map<std::set<unsigned>, EdgeAttr>::iterator it = topoMap.begin(); it!=topoMap.end(); ++it  ) {
        edge = it->second;
        ev << "\t" << i++ << ": [" << edge.nodeA << "]<->[" << edge.nodeB << "] d=" << edge.distance << " m, typ: " << edge.nedTypeName << "\n" ;
    }
}






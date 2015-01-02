/*
 * (c) Fraunhofer Institut for Solar Energy Systems (ISE)
 * Division Electrical Energy Systems (EES) 
 * Department Intelligent Energy Systems (IES)
 * 
 * PlantAnalyzeApp.h
 *
 * Created on:	Jan 21, 2013
 * Author(s):	Pascal Benoit
 *  
 */
#ifndef PLANTANALYZEAPP_H_
#define PLANTANALYZEAPP_H_

/**
 * @file PlantAnalyzeApp.h
 * @brief Header file of plant analyze module.
 */

#include <omnetpp.h>
#include <set>


/**
 * @brief The class analyzes the plant's topology and determines values such as the number of tracker, switches etc
 *
 * The class analyzes the topology via OMNeT's cTopology object.
 * The resulting values are stored in statistical values and output in the GUI.
 */
class PlantAnalyzeApp : public cSimpleModule {



    /**
     * value of parameter Plant.numBlocks of the actual run
     */
    int numBlocks;

    /**
     * value of parameter *.numTrackerNS of the actual run
     */
    int numTrackerNS;

    /**
     * value of parameter *.numTrackerWE of the actual run
     */
    int numTrackerWE;

    /**
     * holds total number of nodes
     */
    int numNodes;

    /**
     * total number of sun trackers
     */
    int numTrackers;

    /**
     * total number of network switches (managed or unmanaged)
     */
    int numSwitches;

    /**
     * total number of managed switches
     */
    int numSwitchesM;

    /**
     * total number of unmanaged switches
     */
    int numSwitchesUM;

    /**
     * total length of Ethernet copper cable in meter
     */
    double lengthEthernet;

    /**
     * total length of Fiber cable in meter
     */
    double lengthFiber;

    /**
     * total cable length in network topology without filtering cable type
     */
    double lengthTotal;



    /**
     * @brief Inner class EdgeAttr contains all attributes of an edge in the topology.
     *
     * An edge is given by the two module IDs of the two nodes that it connects (nodeA and nodeB).
     * Further it contains the distance in meter between them and the nedTypeName of the channel.
     */
    class EdgeAttr {
        public:
            int nodeA;
            int nodeB;
            double distance;
            const char* nedTypeName;
    };

    public:
        //Constructor
        PlantAnalyzeApp();

    //implemented inherited functions:
    protected:
        virtual int numInitStages() const  { return 6; }
        virtual void handleMessage(cMessage *msg) { throw cRuntimeError("this module doesn't handle messages, it runs only in initialize() and finish()"); }
        virtual void initialize(int stage);

        //cComponent function finish, called to record statistics
        virtual void finish();

    private:
        /**
         * @brief Main function for analyzing the plant topology.
         *
         * The function calls the worker functions and fills all statistical variables
         * with values.
         */
        void analyzePlant();

        /**
         * @brief Updates the TCL/TK interface
         *
         * The function updates the dynamic tag argument of the module in OMNeT's TCL/TK GUI.
         * If no GUI is active, it doesn't do anything.
         */
        void updateDisplay();

        /**
         * @brief Returns the number of building blocks of the current run. This value is directly determined by the parameter Plant.numBlocks.
         * @return -1 if parameter does no exist
         */
        int getNumberOfBlocks();

        /**
         * @brief Returns the number of trackers in WE orientation of the current run. This value is determined by the parameter **.Blocks[*].numTrackerWE.
         * @return -1 if parameter does not exist
         */
        int getNumberOfTrackerWE();

        /**
         * @brief Returns the number of trackers in NS orientation of the current run. This value is determined by the parameter **.Blocks[*].numTrackerWE.
         * @return -1 if parameter does not exist
         */
        int getNumberOfTrackerNS();

        /**
         * @brief Returns the total number of network node in the topology.
         */
        int getNumberOfNodes();

        /**
         * @brief Returns the total number of trackers of the topology
         *
         * Trackers are identified by the ned type ise.cpvplant.components.SunTracker
         */
        int getNumberOfTrackers();

        /**
         * @brief Returns the total number of unmanaged switches of the topology
         *
         * Unmanaged switches are identified by the ned type ise.cpvplant.components.EtherSwitchPos
         */
        int getNumberOfSwitchesUM();

        /**
         * @brief Returns the total number of managed switches of the topology
         *
         * Managed switches are identified by the ned type ise.cpvplant.components.ManagedSwitch
         *
         */
        int getNumberOfSwitchesM();

        /**
         * @brief Creates a map with the unique edges of the topology between network nodes.
         * @return A map that assigns a  tuple of the nodes modules ids (e.g. (4,1)) to an instance of the EdgeAttr object which contains more attributes of the edge. The particular characteristic of the map is that each edge only appears once.
         */
        std::map<std::set<unsigned>, PlantAnalyzeApp::EdgeAttr> getEdgeTopology();

        /**
         * @brief Calculation of fiber optic cable length.
         * @param topoMap The map that contains all edges between nodes of the topology. Usually generated by getEdgeTopology().
         * @return The length of fiber optic cables in meter.
         */
        double getChannelLengthFibre( std::map<std::set<unsigned>, EdgeAttr> topoMap );

        /**
         * @brief Calculation of Copper cable length.
         * @param topoMap The map that contains all edges between nodes of the topology. Usually generated by getEdgeTopology().
         * @return The length of fiber copper cables in meter.
         */
        double getChannelLengthCopper( std::map<std::set<unsigned>, EdgeAttr> topoMap);

        /**
         * @brief Calculation of cable length of a given ned type name.
         * @param topoMap The map that contains all edges between nodes of the topology. Usually generated by getEdgeTopology().
         * @param nedTypeName The name of the ned type which distances should be filtered and accumulated.
         * @return The length of the cables of the given nedTypeName in meter.
         */
        double getChannelLengthOfNedType( std::map<std::set<unsigned>, EdgeAttr> topoMap, const char* nedTypeName );

        /**
         * @brief Calculation of the total cable length of the complete topology.
         * @param topoMap The map that contains all edges between nodes of the topology. Usually generated by getEdgeTopology().
         * @return The total length of all edges that are composed of channels which have an parameter "distance".
         */
        double getChannelLengthTotal( std::map<std::set<unsigned>, EdgeAttr> topoMap);

        /**
         * @brief Gets the channel length of a given gate.
         * @param gate Pointer to a gate of which the channel length is requested.
         * @return Length in meter.
         */
        double getChannelLength(cGate *gate);


        /**
         * @brief Helper/Debugging function that shows the complete topology map with all attributes.
         * @param topoMap The map that contains all edges between nodes of the topology. Usually generated by getEdgeTopology().
         */
        void showTopologyMap(std::map<std::set<unsigned>, EdgeAttr> topoMap);



};

#endif /* PLANTANALYZEAPP_H_ */

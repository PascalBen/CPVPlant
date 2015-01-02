#
# OMNeT++/OMNEST Makefile for libCPVPlant
#
# This file was generated with the command:
#  opp_makemake -f --deep --make-so -I../../inet-2.3/src/networklayer/ipv6tunneling -I../../inet-2.3/src/util/headerserializers/sctp -I../../inet-2.3/src/transport/udp -I../../inet-2.3/src/networklayer/ipv4 -I../../inet-2.3/src/transport/contract -I../../inet-2.3/src/networklayer/xmipv6 -I../../inet-2.3/src/applications/pingapp -I../../inet-2.3/src/util/headerserializers/ipv6 -I../../inet-2.3/src/networklayer/arp -I../../inet-2.3/src/transport/tcp_common -I../../inet-2.3/src/base -I../../inet-2.3/src/util/headerserializers/tcp -I../../inet-2.3/src/linklayer/contract -I../../inet-2.3/src/networklayer/autorouting/ipv4 -I../../inet-2.3/src/util/headerserializers/ipv4 -I../../inet-2.3/src/mobility/contract -I../../inet-2.3/src/util/headerserializers -I../../inet-2.3/src/networklayer/common -I../../inet-2.3/src/util/headerserializers/udp -I../../inet-2.3/src/status -I../../inet-2.3/src/applications/tcpapp -I../../inet-2.3/src/networklayer/icmpv6 -I../../inet-2.3/src/transport/sctp -I../../inet-2.3/src/networklayer/contract -I../../inet-2.3/src/networklayer/ipv6 -I../../inet-2.3/src/util -I../../inet-2.3/src -I../../inet-2.3/src/battery/models -I../../inet-2.3/src/world/obstacles -I../../inet-2.3/src/world/radio -I../../inet-2.3/src/linklayer/radio/propagation -I../../inet-2.3/src/linklayer/radio -L../../inet-2.3/out/$$\(CONFIGNAME\)/src -linet -DINET_IMPORT -KINET_2_3_PROJ=../../inet-2.3
#

# Name of target to be created (-o option)
TARGET = libCPVPlant$(SHARED_LIB_SUFFIX)

# C++ include paths (with -I)
INCLUDE_PATH = \
    -I../../inet-2.3/src/networklayer/ipv6tunneling \
    -I../../inet-2.3/src/util/headerserializers/sctp \
    -I../../inet-2.3/src/transport/udp \
    -I../../inet-2.3/src/networklayer/ipv4 \
    -I../../inet-2.3/src/transport/contract \
    -I../../inet-2.3/src/networklayer/xmipv6 \
    -I../../inet-2.3/src/applications/pingapp \
    -I../../inet-2.3/src/util/headerserializers/ipv6 \
    -I../../inet-2.3/src/networklayer/arp \
    -I../../inet-2.3/src/transport/tcp_common \
    -I../../inet-2.3/src/base \
    -I../../inet-2.3/src/util/headerserializers/tcp \
    -I../../inet-2.3/src/linklayer/contract \
    -I../../inet-2.3/src/networklayer/autorouting/ipv4 \
    -I../../inet-2.3/src/util/headerserializers/ipv4 \
    -I../../inet-2.3/src/mobility/contract \
    -I../../inet-2.3/src/util/headerserializers \
    -I../../inet-2.3/src/networklayer/common \
    -I../../inet-2.3/src/util/headerserializers/udp \
    -I../../inet-2.3/src/status \
    -I../../inet-2.3/src/applications/tcpapp \
    -I../../inet-2.3/src/networklayer/icmpv6 \
    -I../../inet-2.3/src/transport/sctp \
    -I../../inet-2.3/src/networklayer/contract \
    -I../../inet-2.3/src/networklayer/ipv6 \
    -I../../inet-2.3/src/util \
    -I../../inet-2.3/src \
    -I../../inet-2.3/src/battery/models \
    -I../../inet-2.3/src/world/obstacles \
    -I../../inet-2.3/src/world/radio \
    -I../../inet-2.3/src/linklayer/radio/propagation \
    -I../../inet-2.3/src/linklayer/radio \
    -I. \
    -IR \
    -Iapplications \
    -Icomponents \
    -Iinterfaces \
    -Ilinklayer \
    -Ilinklayer/ieee80211 \
    -Ilinklayer/ieee80211/radio \
    -Ilinklayer/radio \
    -Itopologies \
    -Itopologies/plants

# Additional object and library files to link with
EXTRA_OBJS =

# Additional libraries (-L, -l options)
LIBS = -L../../inet-2.3/out/$(CONFIGNAME)/src  -linet
LIBS += -Wl,-rpath,`abspath ../../inet-2.3/out/$(CONFIGNAME)/src`

# Output directory
PROJECT_OUTPUT_DIR = ../out
PROJECTRELATIVE_PATH = src
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Object files for local .cc and .msg files
OBJS = \
    $O/applications/TCPSesEstablishTimeReturn.o \
    $O/applications/NoGatesTestApp_test.o \
    $O/applications/SendApp.o \
    $O/applications/TCPSendApp.o \
    $O/applications/PlantAnalyzeApp_test.o \
    $O/applications/NoGatesTestApp.o \
    $O/applications/PlantAnalyzeApp.o \
    $O/applications/PingApp_mod.o \
    $O/applications/TCPSinkApp_Modified.o \
    $O/linklayer/radio/Err_Radio.o \
    $O/topologies/plants/Plant.o

# Message files
MSGFILES =

# Other makefile variables (-K)
INET_2_3_PROJ=../../inet-2.3

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

# Simulation kernel and user interface libraries
OMNETPP_LIB_SUBDIR = $(OMNETPP_LIB_DIR)/$(TOOLCHAIN_NAME)
OMNETPP_LIBS = -L"$(OMNETPP_LIB_SUBDIR)" -L"$(OMNETPP_LIB_DIR)" -loppenvir$D $(KERNEL_LIBS) $(SYS_LIBS)

COPTS = $(CFLAGS) -DINET_IMPORT $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
MSGCOPTS = $(INCLUDE_PATH)

# we want to recompile everything if COPTS changes,
# so we store COPTS into $COPTS_FILE and have object
# files depend on it (except when "make depend" was called)
COPTS_FILE = $O/.last-copts
ifneq ($(MAKECMDGOALS),depend)
ifneq ("$(COPTS)","$(shell cat $(COPTS_FILE) 2>/dev/null || echo '')")
$(shell $(MKPATH) "$O" && echo "$(COPTS)" >$(COPTS_FILE))
endif
endif

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target
all: $O/$(TARGET)
	$(Q)$(LN) $O/$(TARGET) .

$O/$(TARGET): $(OBJS)  $(wildcard $(EXTRA_OBJS)) Makefile
	@$(MKPATH) $O
	@echo Creating shared library: $@
	$(Q)$(SHLIB_LD) -o $O/$(TARGET)  $(OBJS) $(EXTRA_OBJS) $(AS_NEEDED_OFF) $(WHOLE_ARCHIVE_ON) $(LIBS) $(WHOLE_ARCHIVE_OFF) $(OMNETPP_LIBS) $(LDFLAGS)
	$(Q)$(SHLIB_POSTPROCESS) $O/$(TARGET)

.PHONY: all clean cleanall depend msgheaders

.SUFFIXES: .cc

$O/%.o: %.cc $(COPTS_FILE)
	@$(MKPATH) $(dir $@)
	$(qecho) "$<"
	$(Q)$(CXX) -c $(CXXFLAGS) $(COPTS) -o $@ $<

%_m.cc %_m.h: %.msg
	$(qecho) MSGC: $<
	$(Q)$(MSGC) -s _m.cc $(MSGCOPTS) $?

msgheaders: $(MSGFILES:.msg=_m.h)

clean:
	$(qecho) Cleaning...
	$(Q)-rm -rf $O
	$(Q)-rm -f CPVPlant CPVPlant.exe libCPVPlant.so libCPVPlant.a libCPVPlant.dll libCPVPlant.dylib
	$(Q)-rm -f ./*_m.cc ./*_m.h
	$(Q)-rm -f R/*_m.cc R/*_m.h
	$(Q)-rm -f applications/*_m.cc applications/*_m.h
	$(Q)-rm -f components/*_m.cc components/*_m.h
	$(Q)-rm -f interfaces/*_m.cc interfaces/*_m.h
	$(Q)-rm -f linklayer/*_m.cc linklayer/*_m.h
	$(Q)-rm -f linklayer/ieee80211/*_m.cc linklayer/ieee80211/*_m.h
	$(Q)-rm -f linklayer/ieee80211/radio/*_m.cc linklayer/ieee80211/radio/*_m.h
	$(Q)-rm -f linklayer/radio/*_m.cc linklayer/radio/*_m.h
	$(Q)-rm -f topologies/*_m.cc topologies/*_m.h
	$(Q)-rm -f topologies/plants/*_m.cc topologies/plants/*_m.h

cleanall: clean
	$(Q)-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(qecho) Creating dependencies...
	$(Q)$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES)  ./*.cc R/*.cc applications/*.cc components/*.cc interfaces/*.cc linklayer/*.cc linklayer/ieee80211/*.cc linklayer/ieee80211/radio/*.cc linklayer/radio/*.cc topologies/*.cc topologies/plants/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/applications/NoGatesTestApp.o: applications/NoGatesTestApp.cc \
	applications/NoGatesTestApp.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/base/Topology.h
$O/applications/NoGatesTestApp_test.o: applications/NoGatesTestApp_test.cc \
	applications/NoGatesTestApp.h
$O/applications/PingApp_mod.o: applications/PingApp_mod.cc \
	applications/PingApp_mod.h \
	$(INET_2_3_PROJ)/src/applications/pingapp/PingPayload_m.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4ControlInfo.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4ControlInfo_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6ControlInfo.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6ControlInfo_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddressResolver.h
$O/applications/PlantAnalyzeApp.o: applications/PlantAnalyzeApp.cc \
	applications/PlantAnalyzeApp.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/base/Topology.h
$O/applications/PlantAnalyzeApp_test.o: applications/PlantAnalyzeApp_test.cc \
	applications/PlantAnalyzeApp.h
$O/applications/SendApp.o: applications/SendApp.cc \
	applications/SendApp.h \
	$(INET_2_3_PROJ)/src/applications/pingapp/PingPayload_m.h \
	$(INET_2_3_PROJ)/src/base/AbstractQueue.h \
	$(INET_2_3_PROJ)/src/base/ILifecycle.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/base/INotifiable.h \
	$(INET_2_3_PROJ)/src/base/ModuleAccess.h \
	$(INET_2_3_PROJ)/src/base/NotificationBoard.h \
	$(INET_2_3_PROJ)/src/base/NotifierConsts.h \
	$(INET_2_3_PROJ)/src/base/ProtocolMap.h \
	$(INET_2_3_PROJ)/src/base/QueueBase.h \
	$(INET_2_3_PROJ)/src/base/ReassemblyBuffer.h \
	$(INET_2_3_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_2_3_PROJ)/src/networklayer/arp/IARPCache.h \
	$(INET_2_3_PROJ)/src/networklayer/common/IInterfaceTable.h \
	$(INET_2_3_PROJ)/src/networklayer/common/INetfilter.h \
	$(INET_2_3_PROJ)/src/networklayer/common/InterfaceEntry.h \
	$(INET_2_3_PROJ)/src/networklayer/common/InterfaceToken.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4ControlInfo.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4ControlInfo_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6ControlInfo.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6ControlInfo_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddressResolver.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/ICMP.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/ICMPAccess.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/ICMPMessage.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/ICMPMessage_m.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IPv4.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IPv4Datagram.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IPv4Datagram_m.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IPv4FragBuf.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IPv4InterfaceData.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IPv4Route.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IRoutingTable.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/RoutingTableAccess.h
$O/applications/TCPSendApp.o: applications/TCPSendApp.cc \
	applications/TCPSendApp.h \
	$(INET_2_3_PROJ)/src/applications/pingapp/PingPayload_m.h \
	$(INET_2_3_PROJ)/src/applications/tcpapp/GenericAppMsg_m.h \
	$(INET_2_3_PROJ)/src/applications/tcpapp/TCPAppBase.h \
	$(INET_2_3_PROJ)/src/base/ILifecycle.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/base/INotifiable.h \
	$(INET_2_3_PROJ)/src/base/LifecycleOperation.h \
	$(INET_2_3_PROJ)/src/base/ModuleAccess.h \
	$(INET_2_3_PROJ)/src/base/NodeOperations.h \
	$(INET_2_3_PROJ)/src/base/NotificationBoard.h \
	$(INET_2_3_PROJ)/src/base/NotifierConsts.h \
	$(INET_2_3_PROJ)/src/linklayer/contract/MACAddress.h \
	$(INET_2_3_PROJ)/src/networklayer/common/IInterfaceTable.h \
	$(INET_2_3_PROJ)/src/networklayer/common/InterfaceEntry.h \
	$(INET_2_3_PROJ)/src/networklayer/common/InterfaceToken.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPProtocolId_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4ControlInfo.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4ControlInfo_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6ControlInfo.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6ControlInfo_m.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddressResolver.h \
	$(INET_2_3_PROJ)/src/networklayer/ipv4/IPv4InterfaceData.h \
	$(INET_2_3_PROJ)/src/status/NodeStatus.h \
	$(INET_2_3_PROJ)/src/transport/contract/TCPCommand_m.h \
	$(INET_2_3_PROJ)/src/transport/contract/TCPSocket.h
$O/applications/TCPSesEstablishTimeReturn.o: applications/TCPSesEstablishTimeReturn.cc \
	applications/TCPSesEstablishTimeReturn.h \
	$(INET_2_3_PROJ)/src/applications/tcpapp/GenericAppMsg_m.h \
	$(INET_2_3_PROJ)/src/base/ByteArray.h \
	$(INET_2_3_PROJ)/src/base/ByteArrayMessage.h \
	$(INET_2_3_PROJ)/src/base/ByteArrayMessage_m.h \
	$(INET_2_3_PROJ)/src/base/ByteArray_m.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddressResolver.h \
	$(INET_2_3_PROJ)/src/transport/contract/TCPCommand_m.h \
	$(INET_2_3_PROJ)/src/transport/contract/TCPSocket.h
$O/applications/TCPSinkApp_Modified.o: applications/TCPSinkApp_Modified.cc \
	applications/TCPSinkApp_Modified.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_2_3_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_2_3_PROJ)/src/transport/contract/TCPCommand_m.h \
	$(INET_2_3_PROJ)/src/transport/contract/TCPSocket.h
$O/linklayer/radio/Err_Radio.o: linklayer/radio/Err_Radio.cc \
	linklayer/radio/Err_Radio.h \
	$(INET_2_3_PROJ)/src/base/BasicModule.h \
	$(INET_2_3_PROJ)/src/base/Coord.h \
	$(INET_2_3_PROJ)/src/base/ILifecycle.h \
	$(INET_2_3_PROJ)/src/base/INETDefs.h \
	$(INET_2_3_PROJ)/src/base/INotifiable.h \
	$(INET_2_3_PROJ)/src/base/LifecycleOperation.h \
	$(INET_2_3_PROJ)/src/base/ModuleAccess.h \
	$(INET_2_3_PROJ)/src/base/NodeOperations.h \
	$(INET_2_3_PROJ)/src/base/NotificationBoard.h \
	$(INET_2_3_PROJ)/src/base/NotifierConsts.h \
	$(INET_2_3_PROJ)/src/battery/models/BasicBattery.h \
	$(INET_2_3_PROJ)/src/linklayer/contract/PhyControlInfo_m.h \
	$(INET_2_3_PROJ)/src/linklayer/contract/RadioState.h \
	$(INET_2_3_PROJ)/src/linklayer/radio/AirFrame_m.h \
	$(INET_2_3_PROJ)/src/linklayer/radio/INoiseGenerator.h \
	$(INET_2_3_PROJ)/src/linklayer/radio/IRadioModel.h \
	$(INET_2_3_PROJ)/src/linklayer/radio/ModulationType.h \
	$(INET_2_3_PROJ)/src/linklayer/radio/Radio80211aControlInfo_m.h \
	$(INET_2_3_PROJ)/src/linklayer/radio/SnrList.h \
	$(INET_2_3_PROJ)/src/linklayer/radio/propagation/IReceptionModel.h \
	$(INET_2_3_PROJ)/src/status/NodeStatus.h \
	$(INET_2_3_PROJ)/src/util/FWMath.h \
	$(INET_2_3_PROJ)/src/world/annotations/AnnotationManager.h \
	$(INET_2_3_PROJ)/src/world/obstacles/Obstacle.h \
	$(INET_2_3_PROJ)/src/world/obstacles/ObstacleControl.h \
	$(INET_2_3_PROJ)/src/world/radio/ChannelAccess.h \
	$(INET_2_3_PROJ)/src/world/radio/IChannelControl.h
$O/topologies/plants/Plant.o: topologies/plants/Plant.cc \
	topologies/plants/Plant.h


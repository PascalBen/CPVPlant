#!/bin/sh

LOGFILE=tonight.log

#opp_run -r 0 -u Cmdenv -c OLSR5x5 -n ../src:../../inet-2.3/examples:../../inet-2.3/src -l ../src/CPVPlant -l ../../inet-2.3/src/inet  WirelessScaling.ini >> ${LOGFILE}

#opp_run -r 0 -u Cmdenv -c BATMAN5x5 -n ../src:../../inet-2.3/examples:../../inet-2.3/src -l ../src/CPVPlant -l ../../inet-2.3/src/inet WirelessScaling.ini >> ${LOGFILE}

opp_run -r 0 -u Cmdenv -c DSR5x5 -n ../src:../../inet-2.3/examples:../../inet-2.3/src -l ../src/CPVPlant -l ../../inet-2.3/src/inet WirelessScaling.ini >> ${LOGFILE}

opp_run -r 0 -u Cmdenv -c DYMO5x5 -n ../src:../../inet-2.3/examples:../../inet-2.3/src -l ../src/CPVPlant -l ../../inet-2.3/src/inet WirelessScaling.ini >> ${LOGFILE}







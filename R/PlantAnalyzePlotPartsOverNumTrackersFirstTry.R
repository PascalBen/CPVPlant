## (c) Fraunhofer Institut for Solar Energy Systems (ISE)
## Division Electrical Energy Systems (EES) 
## Department Intelligent Energy Systems (IES)
##
## PlantAnalyzePlotPartsOverNumTrackersFirstTry.R
##
## Created 06.05.2013
## Author(s): Pascal Benoit, pascal.benoit@ise.fraunhofer.de
##



###################
# Parameters 
###################
resultdir <- "~/workspace-omnet/CPVPlant/simulations/results/PlantAnalyze"  #location of .sca files
experimentLabel <- "20130513-exp1-"
lastRunNumber <-319


###############
## Functions ##
###############

##' Reads in the data from file into data frame 
##'
##' @param filename filename of .sca-File to read
##' @return one entry of data frame
getMeasurementEntry <- function(scaFilename) {
  cat("reading: \t", scaFilename  , "\n")  
  sca <- loadDataset(scaFilename)  
  
  
  numTrackers <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "numTrackers")] )  
  numNodes <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "numNodes")] )  
  numSwitches <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "numSwitches")])
  numSwitchesM <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "numSwitchesM")] )
  numSwitchesUM <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "numSwitchesUM")] ) 
  lengthEthernet <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "lengthEthernet")] )
  lengthFiber <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "lengthFiber")] )
  lengthTotal <- c( scaFilename = sca$scalars$value[which(sca$scalars$name == "lengthTotal")]  )
  
  entry <- cbind.data.frame (numTrackers, numNodes, numSwitches, numSwitchesM,numSwitchesUM,lengthEthernet, lengthFiber ,lengthTotal)
  
  # entry is a dataframe, similar as one row of the following table
  #
  #entry {  numTrackers  numNodes    numSwitches   numSwitchesM  numSwitchesUM lengthEthernet    lengthFiber    lengthTotal 
  #           30             59             26              2             24            118             10            844 
  #
  
  return(entry)
  
}  

##' Plots the quantities of nodes, switches, managed switches, unmanaged switches out of dfTable
##'
##' @param dfTable data frame with all data as table
##' @return nothing
plotPartsOverTrackers <- function(dfTable) {
  plot(             #plots the first red line 
    dfTable$numTrackers,  #x-values
    dfTable$numNodes,     #y-values
    col="red",            #colors 
    pch=1,                #form 1: circles
    xlim=c(0,3200),
    ylim=c(0,7000),  #1.3*max(1.1*max(value35)), #y-axis start and ende
    ann=FALSE
    )
  
  par( #Numerical vectors of the form c(bottom, left, top, right)
    #mai=c(0,0,0,0), #margin size specified in inches. don't use mar
    #omi=c(0,0,0,0) #outer margins in lines of text, don't us oma
    #mgp=c(3, 1, 0) #Axis margin (titel,label, line)
    mfrow=c(1,1) #mfrow Set the size of a multiple figure array :1 arrow, 1 column
    )
  
  #Adds points or connected lines to the current plot.
  lines( dfTable$numTrackers,dfTable$numSwitches, type="p", pch=2, col="purple" )
  lines( dfTable$numTrackers,dfTable$numSwitchesM, type="p", pch=3, col="orange3" )
  lines( dfTable$numTrackers,dfTable$numSwitchesUM, type="p", pch=7, col="olivedrab4")
  
  title(main="Number of devices ", font.main=4) # Change the graphic title
  title(xlab="Trackers", font.main=4) # Change the x-axis title
  title(ylab="Number of entities") # Change the y-axis title
  
  legend(
    "topright",
    #40,     #x-position
    #1.5*max(value35),
    #0.0145, #y-position
    #names
    c("Number of nodes", "Number of switches", "Number of managed switches","Number of unmanaged switches","Number of nodes"),
    cex=0.8, #Character expansion. The value is the desired size of text characters (including plotting characters) relative to the default text size.
    col=(c("blue", "olivedrab4", "orange3", "purple", "red")),
    pch=c(5,7,3,2,1),
    #bty="" #border
    )  
  
}

##' Plots the length of cables
##'
##' @param dfTable data frame with all data as table
##' @return nothing
plotCableLength <- function(dfTable) {

  plot(             #plots the first red line 
    dfTable$numTrackers,  #x-values
    dfTable$lengthTotal,     #y-values
    col="red",            #colors 
    pch=1,                #form 1: circles
    xlim=c(0,3200),
    ylim=c(0,140000),  #1.3*max(1.1*max(value35)), #y-axis start and ende
    ann=FALSE
    )
  
  par( #Numerical vectors of the form c(bottom, left, top, right)
    #mai=c(0,0,0,0), #margin size specified in inches. don't use mar
    #omi=c(0,0,0,0) #outer margins in lines of text, don't us oma
    #mgp=c(3, 1, 0) #Axis margin (titel,label, line)
    mfrow=c(1,1) #mfrow Set the size of a multiple figure array :1 arrow, 1 column
    )
  
  #Adds points or connected lines to the current plot.
  lines( dfTable$numTrackers,dfTable$lengthEthernet, type="p", pch=2, col="purple" )
  lines( dfTable$numTrackers,dfTable$lengthFiber, type="p", pch=3, col="orange3" )
  
  title(main="Cable Length ", font.main=4) # Change the graphic title
  title(xlab="Trackers", font.main=4) # Change the x-axis title
  title(ylab="Cable Length") # Change the y-axis title
  
  legend(
    "topright",
    #40,     #x-position
    #1.5*max(value35),
    #0.0145, #y-position
    #names
    c("Total cable length", "Ethernet length", "Fiber length"),
    cex=0.8, #Character expansion. The value is the desired size of text characters (including plotting characters) relative to the default text size.
    col=(c("red", "purple", "orange3")),
    pch=c(1,2,3),
    #bty="" #border
    )
}


##############################
#Setup working directory etc.
##############################
require(omnetpp)
setwd(resultdir)

filename <- paste(experimentLabel,0,".sca",sep="")  
dfTable <- getMeasurementEntry(filename)

for ( i in c(1:lastRunNumber) ) {  
  filename <- paste(experimentLabel,i,".sca",sep="")  
  row <- getMeasurementEntry(filename)  
  dfTable <-rbind(dfTable,row)  
}


  





 



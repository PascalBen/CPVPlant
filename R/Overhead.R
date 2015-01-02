## (c) Fraunhofer Institut for Solar Energy Systems (ISE)
## Division Electrical Energy Systems (EES) 
## Department Intelligent Energy Systems (IES)
##
## Overhead.R
##
## Created 24.04.2014
## Author(s): Clara Kowald, clara.ines.kowald@ise.fraunhofer.de
##
## The absolute value of the protocol overhead is calculated and the number of collisions is given
##

############################
# Load Libraries and Files #
############################

require(omnetpp)

runid <- "20140725-09:42:02-recordSelective_4000s_d30"
config <- "BATMAN12x12"
resultdir <- paste("~/workspace-omnet/CPVPlant/simulations/results/", config,sep="")
setwd(resultdir)
filename_sca <- paste(runid,".sca",sep="")
sca <- loadDataset(filename_sca)
out <- paste(runid,"-Overhead.txt",sep="")

###################
# Sum Calculation #
###################

sum1 <- sum(sca$scalars$value[which(sca$scalars$name == "bytesSent")])
sum2 <- sum(sca$scalars$value[which(sca$scalars$name == "bytesRcvd")])
sumBytesTotal <- sum1 + sum2
collisions <- sum(sca$scalars$value[which(sca$scalars$name == "number of collisions")])
rcvdBytesFromLL <- sum(sca$scalars$value[which(sca$scalars$name == "rcvdPkFromLL:sum(packetBytes)")])
simTime <- sca$scalars$value[which(sca$scalars$name == "simulated time")]
overhead <- rcvdBytesFromLL - sumBytesTotal

#################
# Print Results #
#################

cat("Dateiname: ", filename_sca, " Config: ", config, "\n", file=out, append= FALSE)
cat("Sum: bytesTotal: ", sumBytesTotal, "\n",file=out, append=TRUE)
cat("number of collisions: ", collisions, "\n",file=out, append=TRUE)
cat("received Bytes From Lower Layer: ", rcvdBytesFromLL, "\n",file=out, append=TRUE)
cat("simTime: ", simTime[1], "\n",file=out, append=TRUE)
cat("Protocol Overhead: ", overhead, "\n",file=out, append=TRUE)
cat("Ratio: Transmitted Data/Total Received Bytes: ", 100*sumBytesTotal/rcvdBytesFromLL, " %\n",file=out, append=TRUE)

#setwd("~/workspace-omnet/CPV-Plant-svn/src/R")
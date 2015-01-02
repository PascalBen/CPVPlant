
##########################
# Parameters
# CONFIGURATION FOR 35 BLOCKS OF 60 TRACKERS EACH ONE
##########################

datetime <- "20130205-19:06:23"
configname <- "TCPSessionEstablishment"

resultdir <- "~/workspace-omnet/CPVPlant/simulations/results/"

##############################
#Setup working directory etc.
##############################
require(omnetpp)

path <- paste(resultdir,configname,sep="")
setwd(path)
filename_vec <- paste(datetime,".vec",sep="")
filename_sca <- paste(datetime,".sca",sep="")
out <- paste(datetime,"-SessionDelay.txt",sep="")
#load scalar data
sca <- loadDataset(filename_sca)
#load vector data
#vec <- loadDataset(filename_vec)
#discard('vector', 'name("*")'))
headline <-0
##############################
#General analyse
##############################
#sum(sca$scalars$value[grep("ARP requests sent", sca$scalars$name)])
cat("Analyzes of", as.character(unique(sca$runattrs$runid)), "\n\n", file=out, append=FALSE)

headline <- headline+1
cat(headline, ". Scalar files: \n", file=out, append=TRUE)
cat("\t Number of scalars:\t", length(unique(sca$scalars$resultkey)), " variables\n", file=out, append=TRUE)
cat("\t Number of modules:\t", length(unique(sca$scalars$module)), " modules\n", file=out, append=TRUE)
cat("\t Number of names:\t", length(unique(sca$scalars$name)), " names\n", file=out, append=TRUE)
cat("\t Number of S_m:\t\t", length(grep("S_m.mac[0]", unique(sca$scalars$module), fixed=TRUE)), " \n\n", file=out, append=TRUE)

#Calculate and print list with longest and shortest establish-time
TCPTime <- list( module=sca$scalars$module[which(sca$scalars$name == "timeTCPEstablished")], value=sca$scalars$value[which(sca$scalars$name == "timeTCPEstablished")])
TCPTimeOrderedI <- order(TCPTime$value, decreasing=TRUE)
TCPTimeOrdered <- list( module=TCPTime$module[TCPTimeOrderedI], value=TCPTime$value[TCPTimeOrderedI]  )

value1 <- TCPTime$value[grep( sprintf("Blocks[%i]",0), TCPTime$module, fixed=TRUE)]
value10 <- TCPTime$value[grep( sprintf("Blocks[%i]",9), TCPTime$module, fixed=TRUE)]
value20 <- TCPTime$value[grep( sprintf("Blocks[%i]",19), TCPTime$module, fixed=TRUE)]
value30 <- TCPTime$value[grep( sprintf("Blocks[%i]",29), TCPTime$module, fixed=TRUE)]
value35 <- TCPTime$value[grep( sprintf("Blocks[%i]",34), TCPTime$module, fixed=TRUE)] # Is the last block



headline <- headline+1
cat(headline, ". Max TCP Session delay: \n",  file=out, append=TRUE)
cat("\t Summ of all TCP Session delay: \t", sum(TCPTime$value), " s\n",  file=out, append=TRUE)
for(i in 1:60){
  cat("\t\t ", i, "\t",  as.character(TCPTimeOrdered$module[i]), "\t", TCPTimeOrdered$value[i], " seconds\n",  file=out, append=TRUE)
}
cat("\t\t  ...\n",  file=out, append=TRUE)

for(i in (length(TCPTimeOrdered$module)-10):(length(TCPTimeOrdered$module))){
  cat("\t\t ", i, "\t", as.character(TCPTimeOrdered$module[i]), "\t", TCPTimeOrdered$value[i], " seconds\n",  file=out, append=TRUE)
}


#calculate everything only for BB 34
BB <- 0

TCPTimeBB <- list ( id=0:length(grep( sprintf("Blocks[%i]",BB) , TCPTime$module, fixed=TRUE)) ,module=TCPTime$module[grep( sprintf("Blocks[%i]",BB) , TCPTime$module, fixed=TRUE)], value=TCPTime$value[grep( sprintf("Blocks[%i]",BB) , TCPTime$module, fixed=TRUE)] )
TCPTimeBBOrderedI <- order(TCPTimeBB$value, decreasing=TRUE)
TCPTimeBBOrdered <-  list ( id=TCPTimeBB$id[TCPTimeBBOrderedI], module=TCPTimeBB$module[TCPTimeBBOrderedI], value=TCPTimeBB$value[TCPTimeBBOrderedI]  )
headline <- headline+1
cat(headline, ". Max TCP Session delay of BB 34: \n",  file=out, append=TRUE)
for(i in 1:length(TCPTimeBBOrdered$value)){
  cat("\t\t ", i, "\t",  as.character(TCPTimeBBOrdered$id[i]),  "\t",  as.character(TCPTimeBBOrdered$module[i]), "\t", TCPTimeBBOrdered$value[i], " seconds\n",  file=out, append=TRUE)
}

#FUNCTIONS
#
plotAll <- function(value1,value10,value20,value30,value35 ) {

  
  #pdf(
  #  file="./SessionEstablishTime5BlocksNew.pdf", 
  #  #horizontal=FALSE, 
  #  width=8, 
  #  height=5,
  #  paper="special", 
  #  family="Times", 
  #  pointsize=11
  #  )  
  
  
  #plotting
  plot(             #plots the first red line 
    c(0:59),        #x-values
    value1,         #y-values
    col="red",      #colors 
    pch=1,          #form 1=circles
    ylim=c(0,1.4*max(value35)),  #1.3*max(1.1*max(value35)), #y-axis start and ende
    ann=FALSE
  )

  
  par( #Numerical vectors of the form c(bottom, left, top, right)
    #mai=c(0,0,0,0), #margin size specified in inches. don't use mar
    #omi=c(0,0,0,0) #outer margins in lines of text, don't us oma
    #mgp=c(3, 1, 0) #Axis margin (titel,label, line)
    mfrow=c(1,1) #mfrow Set the size of a multiple figure array :1 arrow, 1 column
  )
  
  #Adds points or connected lines to the current plot.
  lines( value10, type="p", pch=2, col="purple" )
  lines( value20, type="p", pch=3, col="orange3" )
  lines( value30, type="p", pch=7, col="olivedrab4")
  lines( value35, type="p", pch=5, col="blue")
  #title(main="TCP Session Establish Time ", font.main=4) # Change the graphic title
  title(xlab="Trackers 0-59", font.main=4) # Change the x-axis title
  title(ylab="Time in s") # Change the y-axis title
  
  #legend(x, y, legend, ...)
  #Adds a legend to the current plot at the specified position. Plotting characters,
  #line styles, colors etc., are identified with the labels in the character vector
  #legend.   
  legend(
    "topright",
    #40,     #x-position
    #1.5*max(value35),
    #0.0145, #y-position
            #names
    c("Building Block 35", "Building Block 30", "Building Block 20","Building Block 10","Building Block 5"),
    cex=0.8, #Character expansion. The value is the desired size of text characters (including plotting characters) relative to the default text size.
    col=(c("blue", "olivedrab4", "orange3", "purple", "red")),
    pch=c(5,7,3,2,1),
    #bty="" #border
  )  
  
  #text(location, "text to place", pos, ...) 
  #mtext("text to place", side, line=n, ...) 
    
  #dev.off();
}

plotAll(value1,value10,value20,value30,value35 )

plotOneBlock <- function(value) {
  #plotting
  plot(             #plots the first red line 
    c(0:59),        #x-values
    value1,         #y-values
    col="red",      #colors 
    ylim=c(0,0.00005),  #1.3*max(1.1*max(value35)), #y-axis start and ende
    ann=FALSE
    )
  
  par( #Numerical vectors of the form c(bottom, left, top, right)
    #mai=c(0,0,0,0), #margin size specified in inches. don't use mar
    #omi=c(0,0,0,0) #outer margins in lines of text, don't us oma
    #mgp=c(3, 1, 0) #Axis margin (titel,label, line)
    mfrow=c(1,1) #mfrow Set the size of a multiple figure array :1 arrow, 1 column
    )
  
  #Adds points or connected lines to the current plot.
  
  title(main="TCP Session Establish Time ", font.main=4) # Change the graphic title
  title(xlab="Trackers 1-60") # Change the x-axis title
  title(ylab="Time in s") # Change the y-axis title
  
  #legend(x, y, legend, ...)
  #Adds a legend to the current plot at the specified position. Plotting characters,
  #line styles, colors etc., are identified with the labels in the character vector
  #legend.   
  legend(
    15,     #x-position
    0.0,
    #0.0145, #y-position
    #names
    c("relayUnit.processTime: 0.0, ip.procDelay: 0.0"),
    cex=0.9, #Character expansion. The value is the desired size of text characters (including plotting characters) relative to the default text size.
    col=(c("red")),
    pch=c(1) )
  
}
#plotOneBlock(value1)

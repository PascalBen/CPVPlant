


#number of routes of each tracker per second


#               0  1  2  3  4  5  6  7  8  9  10  11  12  13  14 
seconds   <- c( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18);

tracker0  <- c( 4, 4, 4, 4, 4, 6, 8, 8, 9, 9,  9,  9, 18, 18, 18, 18, 18, 18, 18);
tracker1  <- c( 1, 1, 1, 1, 3, 3, 8, 8, 8, 8,  8,  8, 15, 15, 15, 15, 15, 15, 15 );
tracker2  <- c( 1, 1, 1, 1, 3, 4, 8, 8, 9, 9,  9,  9, 15, 15, 15, 15, 15, 15, 15 );
tracker3  <- c( 1, 1, 1, 1, 3, 3, 8, 8, 8, 8,  8,  8, 15, 15, 15, 15, 15, 15, 15 );
tracker4  <- c( 1, 1, 1, 1, 2, 2, 5, 5, 6, 6,  6,  6, 15, 15, 15, 15, 15, 15, 15 );
tracker5  <- c( 1, 1, 1, 1, 3, 2, 7, 7, 7, 7,  7,  7, 15, 15, 15, 15, 15, 15, 15 );
tracker6  <- c( 1, 1, 1, 1, 2, 5, 8, 8,10,10, 10, 10, 15, 15, 15, 15, 15, 15, 15 );
tracker7  <- c( 1, 1, 1, 1, 3, 3,11,11,11,11, 11, 11, 15, 15, 15, 15, 15, 15, 15 );
tracker8  <- c( 1, 1, 1, 1, 3, 6, 8, 8,10,10, 10, 10, 15, 15, 15, 15, 15, 15, 15 );
tracker9  <- c( 1, 1, 1, 1, 3, 4, 7, 7, 7, 7,  7,  7, 15, 15, 15, 15, 15, 15, 15 );
tracker10 <- c( 1, 1, 1, 1, 1, 4, 5, 5, 6, 6,  6,  6, 14, 15, 15, 15, 15, 15, 15 );
tracker11 <- c( 1, 1, 1, 1, 2, 3, 8, 8, 8, 8,  8,  8, 15, 15, 15, 15, 15, 15, 15 );
tracker12 <- c( 1, 1, 1, 1, 2, 5, 6, 8, 9, 9,  9,  9, 15, 15, 15, 15, 15, 15, 15 );
tracker13 <- c( 1, 1, 1, 1, 2, 3, 8, 8, 8, 8,  8,  8, 15, 15, 15, 15, 15, 15, 15 );
tracker14 <- c( 1, 1, 1, 1, 1, 5, 5, 5, 6, 6,  6,  6, 14, 14, 14, 14, 14, 15, 15 );

setwd("/home/pbenoit/workspace-omnet/CPVPlant/src/R/")
png(file="OLSRRountingConvergence.png",
    width=800,
    height=600,
    units="px",
    pointsize=16,
    bg="white",
    type="cairo-png") #c("cairo-png", "cairo", "Xlib", "quartz"))#

plot( 
  seconds,  #x-values
  tracker0, #y-value
  type="o",
  col="red",  #y-v
  ylim=c(0,22),
  xlim=c(0,20),
  xlab = NA, #x-axis label
 ylab= NA, #y-axis label
  pch=1,
  axes=F
  )



#par( #Numerical vectors of the form c(bottom, left, top, right)
  #mai=c(0,0,0,0), #margin size specified in inches. don't use mar
  #oma=c(3,3,3,3),  # all sides have 3 lines of space
  #omi=c(0,0,0,0) #outer margins in lines of text, don't us oma
  #mgp=c(3, 1, 0) #Axis margin (titel,label, line)
#  mfrow=c(1,1) #mfrow Set the size of a multiple figure array :1 arrow, 1 column
#  )

#Adds points or connected lines to the current plot.
lines( seconds,tracker1, type="o", pch=2, col="purple" )
lines( seconds,tracker2, type="o", pch=3, col="orange3" )
lines( seconds,tracker3, type="o", pch=7, col="olivedrab4")
lines( seconds,tracker4, type="o", pch=8, col="orange2")
lines( seconds,tracker5, type="o", pch=9, col="peachpuff")
lines( seconds,tracker6, type="o", pch=10, col="blue2")
lines( seconds,tracker7, type="o", pch=11, col="rosybrown3")
lines( seconds,tracker8, type="o", pch=12, col="blue3")
lines( seconds,tracker9, type="o", pch=13, col="mediumpurple")
lines( seconds,tracker10, type="o", pch=14, col="pink1")
lines( seconds,tracker11, type="o", pch=15, col="lightskyblue2")
lines( seconds,tracker12, type="o", pch=16, col="orchid2")
lines( seconds,tracker13, type="o", pch=17, col="salmon2")
lines( seconds,tracker14, type="o", pch=18, col="slateblue")

abline( v=17,
       lty=2,
       lm=0)

#mtext("17", 
#      side=1, #(1=bottom, 2=left, 3=top, 4=right)
#      line=0, #which margin line?
#      adj=1.0, cex=1, col="green")  

#text( x=17.35, #x
#      y=-0.1, #y
#      pos=1, #position below (1) the coordinates
#      labels="17",
#      adj=0)

text( x=18.2, #x
      y=14, #y
      pos=1, #position below (1) the coordinates
      labels="routing\ntables\ncompleted",
      adj=0)

legend(
  #"topleft",
  1,     #x-position
  22,
  #0.0145, #y-position
  #names
  c("Tracker 0 (uplink)",
    "Tracker 1",
    "Tracker 2",
    "Tracker 3",
    "Tracker 4",
    "Tracker 5",
    "Tracker 6",
    "Tracker 7",
    "Tracker 8",
    "Tracker 9",
    "Tracker 10",
    "Tracker 11",
    "Tracker 12",
    "Tracker 13",
    "Tracker 14"),
  cex=0.8, #Character expansion. The value is the desired size of text characters (including plotting characters) relative to the default text size.
  col=(
    c("red", 
      "purple",
      "orange3",
      "olivedrab4",
      "orange2",
      "peachpuff",
      "blue2",
      "rosybrown3",
      "blue3",
      "mediumpurple",
      "pink1",
      "lightskyblue2",
      "orchid2",
      "salmon2",
      "slateblue")),
  pch=c(1,2,3,7,8,9,10,11,12,13,14,15,16,17,18),
  #bty="" #border
  )

title(main="OLSR Convergence Time in 5x3 Tracker Field", font.main=4) # Change the graphic title
title(xlab="Time in seconds") # Change the x-axis title
title(ylab="Number of routing entries") # Change the y-axis title

axis(
  2, #=1bottom, 2=left, 3=top, 4=right)
  pos=0,
  )

axis(
  1, #1=bottom, 2=left, 3=top, 4=right)
  pos=0)



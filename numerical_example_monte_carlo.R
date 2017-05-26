# prerequsities - install and load packages
source("prerequisites.R", encoding = "UTF-8")

##################################################
# calculation of the example from the article
##################################################

# number of simulations to use
# high number of simulations (over 1 000 000) can take rather long time to calculate
numberOfSimulation = 10000

# define the size of a grid
d <- 10

# define elements of a grid around element z9 according to the image from the article
# randomly selecting numberOfSimulation values from distributions 
z1 <- rtriangle(numberOfSimulation, a=382.81, c=383.41, b=384.01)
z2 <- rtriangle(numberOfSimulation, a=384.34, c=384.92, b=385.5)
z3 <- rtriangle(numberOfSimulation, a=385.83, c=386.38, b=386.93)
z4 <- rtriangle(numberOfSimulation, a=385.63, c=386.13, b=386.63)
z5 <- rtriangle(numberOfSimulation, a=385.46, c=385.84, b=386.22)
z6 <- rtriangle(numberOfSimulation, a=384.13, c=384.5, b=384.87)
z7 <- rtriangle(numberOfSimulation, a=382.63, c=383.08, b=383.53)
z8 <- rtriangle(numberOfSimulation, a=382.74, c=383.26, b=383.785)

# creating matrix of values
data <- cbind(z1, z2, z3, z4, z5, z6, z7, z8)


##################################################
# calculation of partial derivatives
# different methods can be selected
##################################################

# definition of Horn's method for calculation of partial derivatives
Zx <- function(x) ((x[1]+x[2]*2+x[3]) - (x[7]+x[6]*2+x[5])) / (8*d) 
Zy <- function(x) ((x[7]+x[8]*2+x[1]) - (x[5]+x[4]*2+x[3])) / (8*d) 

# definition of Sharpnack and Akins's method for calculation of partial derivatives
# Zx <- function(x) ((x[1]+x[2]+x[3]) - (x[7]+x[6]+x[5])) / (6*d) 
# Zy <- function(x) ((x[7]+x[8]+x[1]) - (x[5]+x[4]+x[3])) / (6*d) 

# definition of 4 Cell method for calculation of partial derivatives
# Zx <- function(x) ( x[2] - x[6] ) / (2*d) 
# Zy <- function(x) ( x[8] - x[4] ) / (2*d) 

# partial derivatives
Zx <- apply(data, 1, Zx)
Zy <- apply(data, 1, Zy)


##################################################
# slope calculation
##################################################

# calculation of slope as rise
S <- sqrt(Zx^2+Zy^2)

# calculation of geographical slope (in degrees)
Sg <- atan(S) * (180/pi)

# basic statistics for comparison
print(min(S*100))
print(max(S*100))
print(mean(S*100))


##################################################
# aspect calculation
##################################################

# simplifying atan2 to use on partial derivatives
arctan2 <- function(x) (atan2(x[1],x[2]))

# calculation of mathmetical orientation
A <- apply(cbind(-Zy,-Zx), 1, arctan2)

# orientation in degrees
A.temp <- A * (180/pi)

# change of originate point and direction of rise
# result is geographical aspect
# geographical aspect
Ag <- ifelse(A.temp>90,450-A.temp,90 - A.temp)

# because the values of Ag contain zero, there is a need
# to calculate the statistics independently
Ag.smaller <- Ag[ which(Ag<180) ]
Ag.higher  <- Ag[ which(Ag>180) ]

# basic statistics for comparison
print(min(Ag.smaller))
print(max(Ag.smaller))
print(mean(Ag.smaller))

# basic statistics for comparison
print(min(Ag.higher))
print(max(Ag.higher))
print(mean(Ag.higher))
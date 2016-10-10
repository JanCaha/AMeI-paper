# prerequsities - install and load packages
source("prerequisites.R", encoding = "UTF-8")

##################################################
# calculation of the example from the article
##################################################

# define the size of a grid
d <- 10

# define elements of a grid around element z9 according to the image from the article
# PiecewiseLinearFuzzyNumbers with 10 alpha cuts
z1 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(382.81, 383.41, 384.01), knot.n = 9)
z2 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(384.34, 384.92, 385.5), knot.n = 9)
z3 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(385.83, 386.38, 386.93), knot.n = 9)
z4 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(385.63, 386.13, 386.63), knot.n = 9)
z5 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(385.46, 385.84, 386.22), knot.n = 9)
z6 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(384.13, 384.5, 384.87), knot.n = 9)
z7 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(382.63, 383.08, 383.53), knot.n = 9)
z8 <- as.PiecewiseLinearFuzzyNumber(TriangularFuzzyNumber(382.74, 383.26, 383.785), knot.n = 9)


##################################################
# calculation of partial derivatives
# different methods can be selected
##################################################

# Horn's method for calculation of partial derivatives
Zx <- ((z1+z2*2+z3) - (z7+z6*2+z5)) / (8*d) 
Zy <- ((z7+z8*2+z1) - (z5+z4*2+z3)) / (8*d) 

# Sharpnack and Akin's method for calculation of partial derivatives
# Zx <- ((z1+z2+z3) - (z7+z6+z5)) / (6*d) 
# Zy <- ((z7+z8+z1) - (z5+z4+z3)) / (6*d) 

# 4 cell method for calculation of partial derivatives
# Zx <- (z2 - z6) / (2*d) 
# Zy <- (z8 - z4) / (2*d) 

# partial derivatives
print(Zx)
print(Zy)


##################################################
# slope calculation
##################################################

# calculation of slope as rise
S <- fapply(Zx^2 + Zy^2, sqrt)

# slope in percent
S <- S * 100

# slope value
print(S)

# calculation of geographical slope (in degrees)
Sg <- fapply(S/100, atan) * (180/pi)

# slope in degrees
print(Sg)

##################################################
# aspect calculation
##################################################

# calculation of mathmetical orientation
A <- arctan2(-Zy, -Zx)

# mathematical orientation
print(A)

# orientation in degrees
A.temp <- A * (180/pi)

# change of originate point and direction of rise
# result is geographical aspect
if(A@a3>90){
  Ag <- 450 - A.temp
}else{
  Ag <- 90 - A.temp
}

# geographical aspect
print(Ag)

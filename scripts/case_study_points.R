# prerequsities - install and load packages
source("scripts/prerequisites.R", encoding = "UTF-8")

#######################################################
### setting the parameters for the experiment
#######################################################

# set the seed number to generate reproducible random numbers 
seed.number = 9431384

# the spatial extent of the data, it will be square with this size
size = 4000

# number of cells and rows of the interpolated grid (the size of the grid is numberOfCells*numberOfCells)
numberOfCells = 400

# cell size calculation
cellSize = size/numberOfCells

# number of generated random points
numberOfPoints = 400

# mean value of the generated random points
meanV = 150

# random numbers added the points will be from normal distribution with this mean and standard deviation
randomAdditionMean = 0
randomAdditionSD = 4

# covarience parameters of the gaussian random field for the generated points
sill = 200
range = 400
nugget = 0.0
covModel = "gaussian"

######################################################
### generation of the artificial data
#######################################################

# simulation of the points according to the parameters
set.seed(seed.number)
simPoints <- grf(numberOfPoints, grid = "irreg", cov.pars=c(sill, range), nug=nugget, 
                 cov.model = covModel, xlims = c(0, size), ylims = c(0, size), mean = meanV)

# addition of the random componen to z value of the points
set.seed(seed.number)
randomAdditions = rnorm(length(simPoints$data), mean = randomAdditionMean, sd = randomAdditionSD)
simPoints$data = simPoints$data + randomAdditions

# simple graphic outpout
points(simPoints, col="red")

# preparation of the data for further use
x = simPoints$coords[,2]
y = simPoints$coords[,1]

temp = cbind(x,y,simPoints$data)
colnames(temp) <- c("x", "y", "z")

# write the points as csv dataset
write.table(temp, file = paste("data/points_case_study.txt", sep=""), append = FALSE, quote = TRUE, sep = ",",
            eol = "\n", na = "NA", dec = ".", col.names = TRUE, row.names = FALSE)

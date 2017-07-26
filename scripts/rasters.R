# prerequsities - install and load packages
source("scripts/prerequisites.R", encoding = "UTF-8")

# path to data
path = "./data/"

# type of gradient 
gradient.type = "horn" # "4cell" "sharpnack"


# rasters with slope
slope.min = readAsciiGrid(paste0(path, "slope_", gradient.type, "_min.txt"), 
                         as.image = FALSE, plot.image = FALSE, dec = ".")
slope.modal = readAsciiGrid(paste0(path, "slope_", gradient.type, "_modal.txt"), 
                               as.image = FALSE, plot.image = FALSE, dec = ".")
slope.max = readAsciiGrid(paste0(path, "slope_", gradient.type, "_max.txt"), 
                               as.image = FALSE, plot.image = FALSE, dec = ".")

# rasters with aspect
aspect.min = readAsciiGrid(paste0(path, "aspect_", gradient.type, "_min.txt"), 
                                as.image = FALSE, plot.image = FALSE, dec = ".")
aspect.modal = readAsciiGrid(paste0(path, "aspect_", gradient.type, "_modal.txt"), 
                                  as.image = FALSE, plot.image = FALSE, dec = ".")
aspect.max = readAsciiGrid(paste0(path, "aspect_", gradient.type, "_max.txt"), 
                                as.image = FALSE, plot.image = FALSE, dec = ".")



# points for data extraction - specification of 10 x and y coordinates
points = as.data.frame(cbind(
  runif(10, min=10, max=4000),
  runif(10, min=10, max=4000)
  ))

extracted.data = points

# example - querying how large portion of the area has minimum value of 0 
length = nrow(slope.min@data)
zeroes = which(slope.min@data[1]==0)
percentage = (length(zeroes)/length) * 100  
print(paste0(percentage, "% of cells has 0 as minimal value."))


# extract slope values
extracted.data[,3] = extract(raster(slope.min), points, method='simple')
extracted.data[,4] = extract(raster(slope.modal), points, method='simple')
extracted.data[,5] = extract(raster(slope.max), points, method='simple')

# extract aspect values
extracted.data[,6] = extract(raster(aspect.min), points, method='simple')
extracted.data[,7] = extract(raster(aspect.modal), points, method='simple')
extracted.data[,8] = extract(raster(aspect.max), points, method='simple')

# name the data
names(extracted.data) <- c("x","y","slope_min","slope_modal","slope_max","aspect_min","aspect_modal","aspect_max")

# write the data to the file
write.csv(extracted.data, paste0(path,"extracted_data.txt"), row.names = FALSE)

# prerequsities - install and load packages
source("prerequisites.R", encoding = "UTF-8")

# path to data
path = "./data/"

# type of gradient 
gradient.type = "horn" # "4cell" "sharpnack"



# rasters with slope
pm10.slope.min = readAsciiGrid(paste(path, "pm10_slope_", gradient.type, "_min.asc", sep=""), 
                         as.image = FALSE, plot.image = FALSE, dec = ".")
pm10.slope.modal = readAsciiGrid(paste(path, "pm10_slope_", gradient.type, "_modal.asc", sep=""), 
                               as.image = FALSE, plot.image = FALSE, dec = ".")
pm10.slope.max = readAsciiGrid(paste(path, "pm10_slope_", gradient.type, "_max.asc", sep=""), 
                               as.image = FALSE, plot.image = FALSE, dec = ".")

# rasters with aspect
pm10.aspect.min = readAsciiGrid(paste(path, "pm10_aspect_", gradient.type, "_min.asc", sep=""), 
                                as.image = FALSE, plot.image = FALSE, dec = ".")
pm10.aspect.modal = readAsciiGrid(paste(path, "pm10_aspect_", gradient.type, "_modal.asc", sep=""), 
                                  as.image = FALSE, plot.image = FALSE, dec = ".")
pm10.aspect.max = readAsciiGrid(paste(path, "pm10_aspect_", gradient.type, "_max.asc", sep=""), 
                                as.image = FALSE, plot.image = FALSE, dec = ".")



# points for data extraction - specification of 10 x and y coordinates
points = as.data.frame(cbind(
  c(18.55,16.60,13.37,14.44,13.43,15.29,14.50,18.18,14.87,15.55),
  c(49.76,49.22,50.47,50.09,49.68,50.72,50.85,49.86,49.13,49.85)))

extracted.data = points

# example - querying how large portion of the area has minimum value of 0 
length = nrow(pm10.slope.min@data)
zeroes = which(pm10.slope.min@data$pm10_slope_horn_min.asc==0)
percentage = (length(zeroes)/length) * 100  



# extract slope values
extracted.data[,3] = extract(raster(pm10.slope.min), points, method='simple')
extracted.data[,4] = extract(raster(pm10.slope.modal), points, method='simple')
extracted.data[,5] = extract(raster(pm10.slope.max), points, method='simple')

# extract aspect values
extracted.data[,6] = extract(raster(pm10.aspect.min), points, method='simple')
extracted.data[,7] = extract(raster(pm10.aspect.modal), points, method='simple')
extracted.data[,8] = extract(raster(pm10.aspect.max), points, method='simple')

# name the data
names(extracted.data) <- c("x","y","slope_min","slope_modal","slope_max","aspect_min","aspect_modal","aspect_max")

# write the data to the file
write.csv(extracted.data, paste(path,"extracted_data.txt", sep=""), row.names = FALSE)

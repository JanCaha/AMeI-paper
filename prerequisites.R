################################################
### prerequisites
################################################

#check for existance of necessary packages and if they are not present in R instalation
#then install them
list.of.packages <- c("FuzzyNumbers", "triangle", "sp", "raster", "maptools")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
#load all the packages
lapply(list.of.packages,function(x){library(x,character.only=TRUE)}) 
#remove the variables related to packages
remove(list.of.packages, new.packages)

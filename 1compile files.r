#Compile(stack) files (by Yingbao Sun)
install.packages("raster")
install.packages("rgdal")
library(rgdal)
library(raster)
library(stringr)
#The path is where the satellite imagery products saved in the disk, and where the stacked file to be saved ('OutputLUCCFactors').
#The download address of the satellite imagery products is: https://neo.sci.gsfc.nasa.gov/
path = "D:/dat-201707yingbao/summerCamp"
setwd(path)
#The six 'year' number need be changed from 2000 to 2015 when run the code below
CWCFileNames = list.files("year2012/CW",pattern = glob2rx('*.FLOAT.TIFF'),ignore.case = TRUE)
NDVIrFileNames = list.files("year2012/NDVI",pattern = glob2rx('*.FLOAT.TIFF'),ignore.case = TRUE)
TsFileNames = list.files("year2012/Ts",pattern = glob2rx('*.FLOAT.TIFF'),ignore.case = TRUE)
#Time =str_match(CWCFileNames[1],"[0-9]*-[0-9]*-[0-9]*_")
for (i in 1:length(CWCFileNames)){
  CWC = raster(paste0("year2012/CW/",CWCFileNames[i]))
  NDVI = raster(paste0("year2012/NDVI/",NDVIrFileNames[i]))
  Ts = raster(paste0("year2012/Ts/",TsFileNames[i]))
  mulitplebrick = brick(CWC,NDVI,Ts)
  Time =str_match(CWCFileNames[i],"[0-9]*-[0-9]*-[0-9]*_")
  name = paste0(Time,"clm")
  writeRaster(mulitplebrick, filename =paste0("OutputLUCCFactors/",name,".tif"), format="GTiff", overwrite=TRUE)
}

#install.packages('raster', repo='http://nbcgib.uesc.br/mirrors/cran/')
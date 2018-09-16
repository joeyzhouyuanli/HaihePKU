#Extract values from the resampled raster files (by Yingbao Sun)
install.packages("xlsx")
library(raster)
library(xlsx)
library(stringr)
path = "D:/dat-201707yingbao/summerCamp"
setwd(path)

#The path 'E:/expr' is where the resampled LUCC map saved in the disk
LUCCName = list.files("E:/expr",pattern = glob2rx('*.TIF'),ignore.case = TRUE)

#Here you only need change the year
#The path 'OutputLUCCFactors' is where the stacked index files saved in the disk
MultipeFactors = list.files("OutputLUCCFactors",pattern = glob2rx('2012*.tif'),ignore.case = TRUE)

#This is the place where you should change,only change the filename of lucc relying on year
LUCC = raster("E:/expr/2012resample.tif")
plot(LUCC)
LUCCMatrix = as.matrix(LUCC)
for (Name in MultipeFactors){
  newdir <- paste0("E:/expr/extractclm","extractclm",str_match(Name,"[0-9][0-9][0-9][0-9]"))
  dir.create(newdir,showWarnings = FALSE) 
  XArray = c()
  YArray = c()
  LuccArray = c()
  NDVIArray = c()
  TsArray = c()
  CWCArray = c()
  RasterLayer = brick(paste0("OutputLUCCFactors/",Name))
  CWCMatrix = as.matrix(RasterLayer[[1]])
  NDVIMatrix = as.matrix(RasterLayer[[2]])
  TsMatrix = as.matrix(RasterLayer[[3]])
  
  #nrow(CWCMatrix)
  #ncol(CWCMatrix)
  for (i in 473:546){
    for (j in 2929:3010){
      XArray  =c(XArray,i)
      YArray  =c(YArray,j)
      CWCArray =c(CWCArray,CWCMatrix[i,j])
      NDVIArray =c(NDVIArray,NDVIMatrix[i,j])
      TsArray =c( TsArray, TsMatrix[i,j])
      LuccArray =c(LuccArray,LUCCMatrix[i,j]) 
      }
  }
  FinalMatirx = cbind(XArray,YArray,LuccArray,NDVIArray,TsArray,CWCArray)
  
  write.xlsx(FinalMatirx, paste0(newdir,"/",paste0("extractcml",str_match(Name,"[0-9]*-[0-9]*-[0-9][0-9]"),".xlsx"))) 
  
}
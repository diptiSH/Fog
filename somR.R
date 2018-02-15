library(ncdf4)
require(kohonen)
library(data.table)
Sys.time()

Sys.time()

ncin <- nc_open("/home/iitm/Documents/SOM_multivariate_loikith/impu_nc/New_SOM_input_ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc")
print("testIN")

slp <- ncvar_get( ncin,"z" )
#str(slp)
att <- ncatt_get(ncin, "z")

print(att)

str(slp)
#image(slp)
#slp<-aperm(slp,c(1,2,3))
dim(slp)<- c(357,2356)
str(slp)
#image(slp)
#persp(slp, expand=0.2)

slp_norm <- scale(slp)

str(slp_norm)
#persp(slp_norm, expand=0.2)

nc_close(ncin)






inData<-list(t(slp_norm))
print("testinDataOk")

typeof(inData)
object.size(inData)
str(inData)
summary(inData)

   

Datasom <- supersom(inData,somgrid(4,3,"rectangular"),rlen=1000000, keep.data = TRUE)    



print("supersomOK")
#plot(Datasom, type="counts", main="Counts")
#print(temp)
#plot(Datasom, type="quality", main="Quality")

#plot(Datasom, type="mapping", main="All")

#plot(Datasom, type="changes", main="Changes")


#print.kohonen(Datasom)
#summary.kohonen(Datasom)


Sys.time()

#map_result<-map(Datasom,inData)
write.table(Datasom[["unit.classif"]], file="/home/iitm/Documents/SOM_multivariate_loikith/500mb_only/map_result.txt")
write.table(Datasom[["distances"]], file="/home/iitm/Documents/SOM_multivariate_loikith/500mb_only/SOM_dist.txt")



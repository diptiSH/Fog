library(ncdf4)
require(kohonen)
library(data.table)
Sys.time()


Sys.time()


ncin <- nc_open("/iitm2/cccr-res/ramesh/Fog-files/dipti/review/SOM/data/ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc")
print("testIN")
# NOTE how not specifying varid reads the "only" var in the file
dat1 <- ncvar_get( ncin,"z" )
#str(dat1)
z500<-aperm(dat1,c(3,1,2))
#str(z500)
dim(z500)<- c(2356,2257)
#print("testdata")est


dat1 <- ncvar_get( ncin,"t" )
t500<-aperm(dat1,c(3,1,2))
dim(t500)<- c(2356,2257)

dat1 <- ncvar_get( ncin,"u" )
u500<-aperm(dat1,c(3,1,2))
dim(u500)<- c(2356,2257)

dat1 <- ncvar_get( ncin,"v" )
v500<-aperm(dat1,c(3,1,2))
dim(v500)<- c(2356,2257)

nc_close(ncin)

ncin <- nc_open("/iitm2/cccr-res/ramesh/Fog-files/dipti/review/SOM/data/ERADAILY-1.5deg-200hPa-Dec-Jan-1979-2016.nc")
print("testIN")
# NOTE how not specifying varid reads the "only" var in the file
dat1 <- ncvar_get( ncin,"z" )
#str(dat1)
z200<-aperm(dat1,c(3,1,2))
#str(z200)
dim(z200)<- c(2356,2257)
#print("testdata")est


dat1 <- ncvar_get( ncin,"t" )
t200<-aperm(dat1,c(3,1,2))
dim(t200)<- c(2356,2257)

dat1 <- ncvar_get( ncin,"u" )
u200<-aperm(dat1,c(3,1,2))
dim(u200)<- c(2356,2257)

dat1 <- ncvar_get( ncin,"v" )
v200<-aperm(dat1,c(3,1,2))
dim(v200)<- c(2356,2257)

nc_close(ncin)

ncin <- nc_open("/iitm2/cccr-res/ramesh/Fog-files/dipti/review/SOM/data/ERADAILY-1.5deg-850hPa-Dec-Jan-1979-2016.nc")
print("testIN")
# NOTE how not specifying varid reads the "only" var in the file
dat1 <- ncvar_get( ncin,"z" )
#str(dat1)
z850<-aperm(dat1,c(3,1,2))
#str(z850)
dim(z850)<- c(2356,2257)
#print("testdata")est


dat1 <- ncvar_get( ncin,"t" )
t850<-aperm(dat1,c(3,1,2))
dim(t850)<- c(2356,2257)

dat1 <- ncvar_get( ncin,"u" )
u850<-aperm(dat1,c(3,1,2))
dim(u850)<- c(2356,2257)

dat1 <- ncvar_get( ncin,"v" )
v850<-aperm(dat1,c(3,1,2))
dim(v850)<- c(2356,2257)

nc_close(ncin)









inData<-list(t850,z850,u850,v850,t500,z500,u500,v500,t200,z200,u200,v200)
#inData<-list(temp850,z850,u850,v850,temp700,z700,u700,v700,temp500,z500,u500,v500,temp300,z300,u300,v300,temp200,z200,u200,v200)
#inData<-list(temp850,z850,temp850,z850,temp700,z700,temp500,z500,temp300,z300,temp200,z200)
print("testinDataOk")

typeof(inData)
object.size(inData)   

Datasom <- supersom(inData,somgrid(10,10,"rectangular"),rlen=100000, keep.data = TRUE)    



print("supersomOK")
plot(Datasom, type="counts", main="Counts")
#print(temp)
plot(Datasom, type="quality", main="Quality")

plot(Datasom, type="mapping", main="All")

plot(Datasom, type="changes", main="Changes")


#print.kohonen(Datasom)
#summary.kohonen(Datasom)


Sys.time()

#map_result<-map(Datasom,inData)
write.table(Datasom[["unit.classif"]], file="/iitm2/cccr-res/ramesh/Fog-files/dipti/review/SOM/map_result.txt")
write.table(Datasom[["distances"]], file="/iitm2/cccr-res/ramesh/Fog-files/dipti/review/SOM/map_distances.txt")

object.size(inData)



#str(inData)
#typeof(inData)
#summary(inData)

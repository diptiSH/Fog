library(ncdf4)
require(kohonen)
library(data.table)
Sys.time()

fnames<-c("1980-12-25.nc" , "1980-12-26.nc" , "1980-12-29.nc" , "1996-01-02.nc" , "1996-01-11.nc" , "1997-12-14.nc" , "1997-12-19.nc" , "1997-12-20.nc" , "1997-12-27.nc" , "1997-12-28.nc" , "1998-12-19.nc" , "1998-12-23.nc" , "1998-12-24.nc" , "1999-01-14.nc" , "1999-12-26.nc" , "1999-12-31.nc" , "2001-01-03.nc" , "2003-01-02.nc" , "2003-01-16.nc" , "2003-01-19.nc" , "2003-12-21.nc" , "2003-12-22.nc" , "2003-12-23.nc" , "2003-12-24.nc" , "2004-01-01.nc" , "2004-01-02.nc" , "2004-01-03.nc" , "2004-01-05.nc" , "2004-01-06.nc" , "2004-01-07.nc" , "2004-01-19.nc" , "2004-01-20.nc" , "2004-12-22.nc" , "2004-12-23.nc" , "2004-12-24.nc" , "2004-12-25.nc" , "2009-01-09.nc" , "2009-01-10.nc" , "2009-01-11.nc" , "2009-01-12.nc" , "2009-01-13.nc" , "2009-12-31.nc" , "2010-01-03.nc" , "2010-01-07.nc" , "2010-01-08.nc" , "2010-01-09.nc" , "2010-01-13.nc" , "2010-01-14.nc" , "2010-01-15.nc" , "2010-01-16.nc" , "2010-01-18.nc" , "2010-01-19.nc" , "2010-01-23.nc" , "2010-01-24.nc" , "2011-01-07.nc" , "2011-01-09.nc" , "2012-01-03.nc" , "2012-01-04.nc" , "2012-01-05.nc" , "2012-01-06.nc" , "2012-01-08.nc" , "2012-12-16.nc" , "2012-12-27.nc" , "2012-12-28.nc" , "2013-01-04.nc" , "2013-01-05.nc" , "2013-01-06.nc" , "2013-01-07.nc" , "2013-12-17.nc" , "2013-12-21.nc" , "2013-12-22.nc" , "2013-12-23.nc" , "2013-12-24.nc" , "2014-01-01.nc" , "2014-01-05.nc" , "2014-01-06.nc" , "2014-01-07.nc" , "2014-01-10.nc" , "2014-01-11.nc" , "2014-01-15.nc" , "2014-01-16.nc" , "2014-01-17.nc" , "2014-01-19.nc" , "2014-01-20.nc" , "2014-01-25.nc" , "2014-01-26.nc" , "2014-01-31.nc" , "2014-12-15.nc" , "2014-12-21.nc" , "2014-12-24.nc" , "2014-12-25.nc" , "2014-12-31.nc" , "2015-01-02.nc" , "2015-01-03.nc" , "2015-01-04.nc" , "2015-01-07.nc" , "2015-01-09.nc" , "2015-01-13.nc" , "2015-01-16.nc" , "2015-01-24.nc" , "2015-01-25.nc" , "2015-01-26.nc")

#fnames<-c("19801225_flt.nc","19801226_flt.nc","19801229_flt.nc","19960102_flt.nc","19960111_flt.nc","19971214_flt.nc","19971219_flt.nc","19971220_flt.nc","19971227_flt.nc","19971228_flt.nc","19981219_flt.nc","19981223_flt.nc","19981224_flt.nc","19990114_flt.nc","19991226_flt.nc","19991231_flt.nc","20010103_flt.nc","20030102_flt.nc","20030116_flt.nc","20030119_flt.nc","20031221_flt.nc","20031222_flt.nc","20031223_flt.nc","20031224_flt.nc","20040101_flt.nc","20040102_flt.nc","20040103_flt.nc","20040105_flt.nc","20040106_flt.nc","20040107_flt.nc","20040119_flt.nc","20040120_flt.nc","20041222_flt.nc","20041223_flt.nc","20041224_flt.nc","20041225_flt.nc","20090109_flt.nc","20090110_flt.nc","20090111_flt.nc","20090112_flt.nc","20090113_flt.nc","20091231_flt.nc","20100103_flt.nc","20100107_flt.nc","20100108_flt.nc","20100109_flt.nc","20100113_flt.nc","20100114_flt.nc","20100115_flt.nc","20100116_flt.nc","20100118_flt.nc","20100119_flt.nc","20100123_flt.nc","20100124_flt.nc","20110107_flt.nc","20110109_flt.nc","20120103_flt.nc","20120104_flt.nc","20120105_flt.nc","20120106_flt.nc","20120108_flt.nc","20121216_flt.nc","20121227_flt.nc","20121228_flt.nc","20130104_flt.nc","20130105_flt.nc","20130106_flt.nc","20130107_flt.nc","20131217_flt.nc","20131221_flt.nc","20131222_flt.nc","20131223_flt.nc","20131224_flt.nc","20140101_flt.nc","20140105_flt.nc","20140106_flt.nc","20140107_flt.nc","20140110_flt.nc","20140111_flt.nc","20140115_flt.nc","20140116_flt.nc","20140117_flt.nc","20140119_flt.nc","20140120_flt.nc","20140125_flt.nc","20140126_flt.nc","20140131_flt.nc","20141215_flt.nc","20141221_flt.nc","20141224_flt.nc","20141225_flt.nc","20141231_flt.nc","20150102_flt.nc","20150103_flt.nc","20150104_flt.nc","20150107_flt.nc","20150109_flt.nc","20150113_flt.nc","20150116_flt.nc","20150124_flt.nc","20150125_flt.nc","20150126_flt.nc","20151223_flt.nc"
#)

Sys.time()



iter=102

temp850=matrix(NA, nrow=iter, ncol=14640)
#temp700=matrix(NA, nrow=iter, ncol=14640)
temp500=matrix(NA, nrow=iter, ncol=14640)
temp300=matrix(NA, nrow=iter, ncol=14640)
temp200=matrix(NA, nrow=iter, ncol=14640)
u850=matrix(NA, nrow=iter, ncol=14640)
#u700=matrix(NA, nrow=iter, ncol=14640)
u500=matrix(NA, nrow=iter, ncol=14640)
u300=matrix(NA, nrow=iter, ncol=14640)
u200=matrix(NA, nrow=iter, ncol=14640)
v850=matrix(NA, nrow=iter, ncol=14640)
#v700=matrix(NA, nrow=iter, ncol=14640)
v500=matrix(NA, nrow=iter, ncol=14640)
v300=matrix(NA, nrow=iter, ncol=14640)
v200=matrix(NA, nrow=iter, ncol=14640)
z850=matrix(NA, nrow=iter, ncol=14640)
#z700=matrix(NA, nrow=iter, ncol=14640)
z500=matrix(NA, nrow=iter, ncol=14640)
z300=matrix(NA, nrow=iter, ncol=14640)
z200=matrix(NA, nrow=iter, ncol=14640)


for(i in 1:iter) #files
{
  dirname="/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/200/"
ncname <-fnames[i]
ncfname <- paste(dirname,ncname, sep="")
#clearprint(ncfname)
ncin <- nc_open(ncfname)
#print(ncin)
temp200[i,]=ncvar_get(ncin,"t")
u200[i,]=ncvar_get(ncin,"u")
v200[i,]=ncvar_get(ncin,"v")
z200[i,]=ncvar_get(ncin,"z")

Sys.time()
nc_close(ncin)


dirname="/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/300/"
ncname <-fnames[i]
ncfname <- paste(dirname,ncname, sep="")
#clearprint(ncfname)
ncin <- nc_open(ncfname)
#print(ncin)
temp300[i,]=ncvar_get(ncin,"t")
u300[i,]=ncvar_get(ncin,"u")
v300[i,]=ncvar_get(ncin,"v")
z300[i,]=ncvar_get(ncin,"z")

Sys.time()
nc_close(ncin)

dirname="/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/500/"
ncname <-fnames[i]
ncfname <- paste(dirname,ncname, sep="")
#clearprint(ncfname)
ncin <- nc_open(ncfname)
#print(ncin)
temp500[i,]=ncvar_get(ncin,"t")
u500[i,]=ncvar_get(ncin,"u")
v500[i,]=ncvar_get(ncin,"v")
z500[i,]=ncvar_get(ncin,"z")

Sys.time()
nc_close(ncin)


dirname="/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/850/"
ncname <-fnames[i]
ncfname <- paste(dirname,ncname, sep="")
#clearprint(ncfname)
ncin <- nc_open(ncfname)
#print(ncin)
temp850[i,]=ncvar_get(ncin,"t")
u850[i,]=ncvar_get(ncin,"u")
v850[i,]=ncvar_get(ncin,"v")
z850[i,]=ncvar_get(ncin,"z")

Sys.time()
nc_close(ncin)



print(i)


str(temp850)




#summary(temp)
#typeof(temp)
#str(temp)
#dim(temp)


}



str(temp850)
str(u850)

str(temp850)

Sys.time()
inData<-list(temp850,z850,u850,v850,temp500,z500,u500,v500,temp300,z300,u300,v300,temp200,z200,u200,v200)
#inData<-list(temp850,z850,u850,v850,temp700,z700,u700,v700,temp500,z500,u500,v500,temp300,z300,u300,v300,temp200,z200,u200,v200)
#inData<-list(temp850,z850,temp850,z850,temp700,z700,temp500,z500,temp300,z300,temp200,z200)
print("testinDataOk")

typeof(inData)
   

Datasom <- supersom(inData,somgrid(1,2,"rectangular"),rlen=100000, keep.data = TRUE)    



print("supersomOK")
plot(Datasom, type="counts", main="Counts")
#print(temp)
plot(Datasom, type="quality", main="Quality")

plot(Datasom, type="mapping", main="All")

plot(Datasom, type="changes", main="Changes")


print.kohonen(Datasom)
summary.kohonen(Datasom)


Sys.time()

#map_result<-map(Datasom,inData)
write.table(Datasom[["unit.classif"]], file="/home/dipti/Documents/SOM/fogDays2/ERA1.5_NH/map_result.txt")

object.size(inData)





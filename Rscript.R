require(kohonen)
#require(resample)

geop200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/Geop200.txt",
                       fill = TRUE , header = FALSE)  
geop500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/Geop500.txt",
                       fill = TRUE , header = FALSE)                                 
geop850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/Geop850.txt",
                       fill = TRUE , header = FALSE)  


geop200=data.matrix(geop200) 
geop500=data.matrix(geop500)
geop850=data.matrix(geop850)




u200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/U200.txt",
                    fill = TRUE , header = FALSE) 
u500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/U500.txt",
                    fill = TRUE , header = FALSE)                                  
u850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/U850.txt",
                    fill = TRUE , header = FALSE)    

u200=data.matrix(u200)   
u500=data.matrix(u500)
u850=data.matrix(u850)



v200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/V200.txt",
                    fill = TRUE , header = FALSE) 
v500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/V500.txt",
                    fill = TRUE , header = FALSE)                  
v850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/V850.txt",
                    fill = TRUE , header = FALSE)                  


v200=data.matrix(v200)
v500=data.matrix(v500)
v850=data.matrix(v850)

Temp200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/Temp200.txt",
                       fill = TRUE , header = FALSE) 
Temp500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/Temp500.txt",
                       fill = TRUE , header = FALSE)                  
Temp850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/Temp850.txt",
                       fill = TRUE , header = FALSE)                  

Temp200=data.matrix(Temp200)   
Temp500=data.matrix(Temp500)
Temp850=data.matrix(Temp850)

inData = list(geop200, geop500, geop850,u200, u500,u850,v200,v500, v850,Temp200,Temp500,Temp850)

typeof(inData)

Sys.time()


Datasom <- supersom(inData,somgrid(1,2,"rectangular"), rlen=100000, keep.data = TRUE) 

Sys.time()

summary(Datasom[["codes"]])


for(i in 1:12)
{
  fname=paste("som",as.character(i),".txt")
  write.table(Datasom[["codes"]][i], file=fname)
}

plot(Datasom, type="counts")
plot(Datasom, type="quality")
plot(Datasom, type="changes")

#map_result<-map(Datasom,inData)
write.table(Datasom[["unit.classif"]], file="map_result.txt")

Mapgeop200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapGeop200.txt",
                          fill = TRUE , header = FALSE)  
Mapgeop500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapGeop500.txt",
                          fill = TRUE , header = FALSE)                                 
Mapgeop850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapGeop850.txt",
                          fill = TRUE , header = FALSE)  


Mapgeop200=data.matrix(Mapgeop200) 
Mapgeop500=data.matrix(Mapgeop500)
Mapgeop850=data.matrix(Mapgeop850)




Mapu200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapU200.txt",
                       fill = TRUE , header = FALSE) 
Mapu500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapU500.txt",
                       fill = TRUE , header = FALSE)                                  
Mapu850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapU850.txt",
                       fill = TRUE , header = FALSE)    

Mapu200=data.matrix(Mapu200)   
Mapu500=data.matrix(Mapu500)
Mapu850=data.matrix(Mapu850)



Mapv200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapV200.txt",
                       fill = TRUE , header = FALSE) 
Mapv500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapV500.txt",
                       fill = TRUE , header = FALSE)                  
Mapv850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapV850.txt",
                       fill = TRUE , header = FALSE)                  


Mapv200=data.matrix(Mapv200)
Mapv500=data.matrix(Mapv500)
Mapv850=data.matrix(Mapv850)

MapTemp200 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapTemp200.txt",
                          fill = TRUE , header = FALSE) 
MapTemp500 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapTemp500.txt",
                          fill = TRUE , header = FALSE)                  
MapTemp850 <- read.table ("/home/dipti/Documents/SOM/fogDays2/ERA75/DataIn/MapTemp850.txt",
                          fill = TRUE , header = FALSE)                  

MapTemp200=data.matrix(MapTemp200)   
MapTemp500=data.matrix(MapTemp500)
MapTemp850=data.matrix(MapTemp850)

MapinData = list(Mapgeop200, Mapgeop500, Mapgeop850,Mapu200, Mapu500,Mapu850,Mapv200,Mapv500, Mapv850,MapTemp200,MapTemp500,MapTemp850)

typeof(MapinData)

mapping_result<-map(Datasom,MapinData)

write.table(mapping_result[["unit.classif"]], file="mapping_result.txt")
 write.table(mapping_result[["distances"]], file="Dist_mapping_result.txt")
                 
 ageop200 <- read.table ("2016Geop200.txt",fill = TRUE , header = FALSE)  
 ageop500 <- read.table ("2016Geop500.txt",
                        fill = TRUE , header = FALSE)                                 
 ageop850 <- read.table ("2016Geop850.txt",
                        fill = TRUE , header = FALSE)  
 
 
 ageop200=data.matrix(ageop200) 
 ageop500=data.matrix(ageop500)
 ageop850=data.matrix(ageop850)
 
 
 
 
 au200 <- read.table ("2016U200.txt",
                     fill = TRUE , header = FALSE) 
 au500 <- read.table ("2016U500.txt",
                     fill = TRUE , header = FALSE)                                  
 au850 <- read.table ("2016U850.txt",
                     fill = TRUE , header = FALSE)    
 
 au200=data.matrix(au200)   
 au500=data.matrix(au500)
 au850=data.matrix(au850)
 
 
 
 av200 <- read.table ("2016V200.txt",
                     fill = TRUE , header = FALSE) 
 av500 <- read.table ("2016V500.txt",
                     fill = TRUE , header = FALSE)                  
 av850 <- read.table ("2016V850.txt",
                     fill = TRUE , header = FALSE)                  
 
 
 av200=data.matrix(av200)
 av500=data.matrix(av500)
 av850=data.matrix(av850)
 
 aTemp200 <- read.table ("2016Temp200.txt",
                        fill = TRUE , header = FALSE) 
 aTemp500 <- read.table ("2016Temp500.txt",
                        fill = TRUE , header = FALSE)                  
 aTemp850 <- read.table ("2016Temp850.txt",
                        fill = TRUE , header = FALSE)                  
 
 aTemp200=data.matrix(aTemp200)   
 aTemp500=data.matrix(aTemp500)
 aTemp850=data.matrix(aTemp850)
 
 inData2016 = list(ageop200, ageop500, ageop850,au200, au500,au850,av200,av500, av850,aTemp200,aTemp500,aTemp850)

 mapping_result2016<-map(Datasom,inData2016)
 
 write.table(mapping_result2016[["unit.classif"]], file="mapping_result2016.txt")
 write.table(mapping_result2016[["distances"]], file="Dist_mapping_result2016.txt")
 

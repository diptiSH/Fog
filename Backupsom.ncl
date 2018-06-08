begin
;********** input Data should be two dimensional and time should be first dimension

in1=(/1,0,0,0/)
in2=(/0,1,0,0/)
in3=(/3,3,0,0/)
in4=(/0,4,4,0/)
in5=(/0,0,0,1/)

inFile=addfile("/home/iitm/Documents/Data/SOM_ERA_500_input/ERAANOM-1.5deg-500hPa-Dec-Jan-1979-2016_30-120E15-60N.nc","r")
z_old=inFile->z(0:61,:,:)
printVarSummary(z_old)

z=reshape(z_old,(/62,1891/))
printVarSummary(z)
;exit


nodeL=3
nodeW=3
nodes=nodeL*nodeW
iterations=10000
nodeArray=(/nodeL,nodeW/)
in_nRadius=max(nodeArray)/1.5
timConstant=iterations/log(in_nRadius)
in_lRate=0.1
inputVectors=z;(/in1,in2,in3,in4,in5/)

printVarSummary(inputVectors)
 

inputSize=dimsizes(inputVectors)
;print(inputSize(0))



;initialize node vectors
nodVects=new((/nodeL,nodeW,inputSize(1)/),double)
;printVarSummary(nodVects)
;print(nodVects)
;do k=0,nodes-1
;nodVects(k,:)=rand()
;end do
initiVects=random_uniform(0,1,(/nodes,inputSize(1)/)) 
nodVects=reshape(initiVects,(/nodeL,nodeW,inputSize(1)/))
;print(nodVects)
mapping=new((/inputSize(0),2/),integer)
nodeNums=new(inputSize(0),integer)

;**************Loop for iterations
do iter=0,iterations-1
  ;******************Loop for each input vector
  do input=0,inputSize(0)-1
     ; print(inputVectors(input,:))
      ; ***************************Find bmu
          dist=todouble(0.0)
         ; printVarSummary(dist)
          minDist=todouble(0.0)
          distInd=(/0,0/)
       do l=0,nodeL-1
         do w=0,nodeW-1
          dist=dim_rmsd(nodVects(l,w,:),inputVectors(input,:))
          
         ; print(dist)
          if(l.eq.0 .and. w.eq.0)then
           minDist=dist
           distInd=(/0,0/)
           ;print("first if")
          ; print(minDist)
          else
          if(dist.lt.minDist) then
                 minDist=dist
                 distInd=(/l,w/)
                 ;print("second if")
              end if
          end if
        end do  
          ;***************** Output
        if(iter.eq.iterations-1)then
           mapping(input,:)=distInd
           nodeNums(input)=distInd(0)*nodeW+distInd(1)
        end if  
       end do
       ;print(minDist)
       ;print(distInd)

       ;******************************************* update BMU and neighbourhood
       
       nRadius=in_nRadius*exp(-(iter/timConstant))
       lRate=in_lRate*exp(-(todouble(iter)/iterations))
      
    
       do l=0,nodeL-1
         do w=0,nodeW-1
           dFun=todouble(0.0)
          BMU_dist=todouble(0.0)
          BMU_dist=dim_rmsd(nodVects(l,w,:),nodVects(distInd(0),distInd(1),:))
          if(BMU_dist.lt.nRadius) then
          dFun=exp(-((BMU_dist*BMU_dist)/(nRadius*nRadius)))
          nodVects(l,w,:)=nodVects(l,w,:)+dFun*lRate*(inputVectors(input,:)- nodVects(l,w,:))
          end if
         end do
       end do
  end do
  print(iter)
       print(nRadius)
       print(lRate)

end do
;print(mapping)
;nodeNums=new(nodeL*nodeW,integer)
;k=0
;do i=0,nodeL-1
;  do j=0,nodeW-1
 ;   nodeNums(k)=i*nodeW+j
 ;   k=k+1
 ; end do
;end do

asciiwrite("map.txt",mapping)
asciiwrite("nodenums.txt",nodeNums)

end

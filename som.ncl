begin
;********** input Data should be two dimensional and time should be first dimension


inFile=addfile("/home/iitm/Documents/Data/SOM_ERA_500_input/ERAANOM-1.5deg-500hPa-Dec-Jan-1979-2016_30-120E15-60N.nc","r")
z_old=inFile->z(:,:,:)
printVarSummary(z_old)
ntime=dimsizes(z_old&time)
nlat=dimsizes(z_old&latitude)
nlon=dimsizes(z_old&longitude)
;printVarSummary(z_old)

;print(nlat)
;print(nlon)

z=reshape(z_old,(/ntime,nlat*nlon/))
printVarSummary(z)

nodeL=2
nodeW=2
nodes=nodeL*nodeW
iterations=10
nodeArray=(/nodeL,nodeW/)
in_nRadius=max(nodeArray)/1.5
timConstant=iterations/log(in_nRadius)
in_lRate=0.1
inputVectors=z

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

qerror=new(iterations,double)
qerror=todouble(0.0)

;**************Loop for iterations
do iter=0,iterations-1
   
  ;******************Loop for each input vector
  do input=0,inputSize(0)-1
     ; print(inputVectors(input,:))
      ; ***************************Find bmu
          dist=todouble(0.0)
         ; printVarSummary(dist)
          minDistn=todouble(0.0)
          distInd=(/0,0/)
       do l=0,nodeL-1
         do w=0,nodeW-1
          dist=dim_rmsd(nodVects(l,w,:),inputVectors(input,:))
          
         ; print(dist)
          if(l.eq.0 .and. w.eq.0)then
           minDistn=dist
           distInd=(/0,0/)
           ;print("first if")
          ; print(minDistn)
          else
          if(dist.lt.minDistn) then
                 minDistn=dist
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
    ;;;;;;;;;;; error for vector assignment    
           qerror(iter)=qerror(iter)+( dim_rmsd(nodVects(distInd(0),distInd(1),:),inputVectors(input,:)))     

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
  ;print(iter)
   ;    print(nRadius)
    ;   print(lRate)

end do



;asciiwrite("map.txt",mapping)
asciiwrite("nodenums.txt",nodeNums)


;;;;;;;;;;;;;;;;;;;;; plot no of iterations vs quantization error 

  wks   = gsn_open_wks ("png","qerror")               ; send graphics to PNG file

 res                  = True                     ; plot mods desired
 res@tiMainString     = "no of iterations vs quantization error "          ; add title
 
 yiter=ispan(1,iterations,1)

 plot  = gsn_csm_xy (wks,yiter,qerror,res) ; create plot


;;;;;;;;;;;;;; plot nodes/patterns

 nodVects_end=reshape(nodVects,(/nodeL,nodeW,nlat,nlon/))
 ;printVarSummary( nodVects_end)

wks=gsn_open_wks ("png","cluster patterns")
plots=new(nodes,graphic)

do iter=0,nodes-1

 w=mod(iter,nodeW)
 l=toint(iter/nodeW)
 ;print(iter)
 ;print(w)
 ;print(l)
 copy_VarMeta(z_old(0,:,:),nodVects_end(l,w,:,:))
 ;printVarSummary(nodVects_end(l,w,:,:))

 res                  = True                     ; plot mods desired
 res@tiMainString     = "Pattern "+iter          ; add title
 res@gsnDraw             = False            ; don't draw
  res@gsnFrame            = False            ; don't advance frame
 
  res@cnFillOn        = True                    ; turn on color 
 res@cnFillPalette   = "BlueRed"           ; set color map
 res@lbLabelBarOn    = False                 ; will draw a panel label bar instead
 res@gsnAddCyclic = False
  res@mpMinLatF              = 15.0              ; map area
  res@mpMaxLatF              = 60.0                ; latitudes
  res@mpMinLonF              = 30.0              ; and
  res@mpMaxLonF              = 120.0               ; longitudes
  res@cnLevelSelectionMode = "ManualLevels"     ; set manual contour levels
  res@cnMinLevelValF       = -2000.0                ; set min contour level
  res@cnMaxLevelValF       =  2000.0                ; set max contour level
  res@cnLevelSpacingF      =  200               ; set contour spacing
 plots(iter) = gsn_csm_contour_map(wks,nodVects_end(l,w,:,:), res)
end do

;************************************************
; create panel
;************************************************
  resP                  = True                   ; modify the panel plot
  resP@gsnFrame         = False                  ; don't advance panel plot
  resP@gsnPanelLabelBar = True                   ; add common colorbar
  resP@gsnPanelMainString = "Cluster Patterns"     ; set main title
 ; resP@gsnPanelBottom   = 0.05                   ; add space at bottom
 ; resP@gsnPanelFigureStrings= (/"a)","b)","c)"/) ; add strings to panel
  resP@amJust   = "TopLeft"
  gsn_panel(wks,plots,(/nodeL,nodeW/),resP)               ; now draw as one plot

frame(wks)

;;;;;;;;;;;;;;;;; plot lowest correlation and highest correlation days 

nodVects_singleInd=reshape(nodVects,(/nodeL*nodeW,inputSize(1)/))
maxCorr=new(nodes,"double")
minCorr=new(nodes,"double")
maxDist=new(nodes,"double")
minDist=new(nodes,"double")
avgCorr=new(nodes,"double")
avgDist=new(nodes,"double")
numb_days=new(nodes,"integer")

maxCorrVect=new((/nodes,nlat,nlon/),"double")
minCorrVect=new((/nodes,nlat,nlon/),"double")
maxDistVect=new((/nodes,nlat,nlon/),"double")
minDistVect=new((/nodes,nlat,nlon/),"double")

 do n=0,nodes-1 
 ;;;;;;;;;;;;count number of vectors associated with each node
     numb=0 
    do input=0,inputSize(0)-1
      if(nodeNums(input).eq.n) then
      numb=numb+1    
      end if 
    end do
    numb_days(n)=numb
;;;;;;;;;;;;Find out max and min corr and dist vals
     cor_val=new(numb,"double")
     dist_val=new(numb,"double")
     cor_val_ind=new(numb,"integer")
     dist_val_ind=new(numb,"integer")
     index=0
    do input=0,inputSize(0)-1
      if(nodeNums(input).eq.n) then
      cor_val(index)=esccr(nodVects_singleInd(nodeNums(input),:),inputVectors(input,:),0)
      dist_val(index)=dim_rmsd(nodVects_singleInd(nodeNums(input),:),inputVectors(input,:))
      cor_val_ind(index)=input
      dist_val_ind(index)=input
       index=index+1
      end if 
       
     end do

maxCorr(n)=max(cor_val)
minCorr(n)=min(cor_val)
maxDist(n)=max(dist_val)
minDist(n)=min(dist_val)
avgDist(n)=avg(dist_val)
avgCorr(n)=avg(cor_val)
  
maxCorrVect(n,:,:)=z_old(cor_val_ind(maxind(cor_val)),:,:)
minCorrVect(n,:,:)=z_old(cor_val_ind(minind(cor_val)),:,:)
maxDistVect(n,:,:)=z_old(cor_val_ind(maxind(dist_val)),:,:)
minDistVect(n,:,:)=z_old(cor_val_ind(minind(dist_val)),:,:)

    delete(cor_val)
     delete(dist_val)
     delete(cor_val_ind)
     delete(dist_val_ind)

 end do




;;;;;;;;;;;;;; plot maxDist minDist and maxCor and minCor plots

do n=0,nodes-1 

w=mod(n,nodeW)
 l=toint(n/nodeW)
 ;print(iter)
 ;print(w)
 ;print(l)
 copy_VarMeta(z_old(0,:,:),nodVects_end(l,w,:,:))

wks=gsn_open_wks ("png","max_min_cor_dist_plots"+n)
plots2=new(5,graphic)



 res                  = True                     ; plot mods desired
 res@gsnDraw             = False            ; don't draw
  res@gsnFrame            = False            ; don't advance frame
 
  res@cnFillOn        = True                    ; turn on color 
 res@cnFillPalette   = "BlueRed"           ; set color map
 res@lbLabelBarOn    = False                 ; will draw a panel label bar instead
 res@gsnAddCyclic = False
  res@mpMinLatF              = 15.0              ; map area
  res@mpMaxLatF              = 60.0                ; latitudes
  res@mpMinLonF              = 30.0              ; and
  res@mpMaxLonF              = 120.0               ; longitudes
  res@cnLevelSelectionMode = "ManualLevels"     ; set manual contour levels
  res@cnMinLevelValF       = -2000.0                ; set min contour level
  res@cnMaxLevelValF       =  2000.0                ; set max contour level
  res@cnLevelSpacingF      =  200               ; set contour spacing
 
 res@tiMainString     = "maxCorr"          ; add title
  res@gsnCenterString = maxCorr(n)
 plots2(0) = gsn_csm_contour_map(wks,maxCorrVect(n,:,:), res)

 res@tiMainString     = "minCorr"          ; add title
  res@gsnCenterString = minCorr(n)
 plots2(1) = gsn_csm_contour_map(wks,minCorrVect(n,:,:), res)

res@tiMainString     = "maxDist"          ; add title
  res@gsnCenterString = maxDist(n)
 plots2(2) = gsn_csm_contour_map(wks,maxDistVect(n,:,:), res)

 res@tiMainString     = "minDist"          ; add title
  res@gsnCenterString = minDist(n)
 plots2(3) = gsn_csm_contour_map(wks,minDistVect(n,:,:), res)

  res@tiMainString     = "node"          ; add title
  res@gsnCenterString =  numb_days(n)
  res@gsnLeftString = avgDist(n)
  res@gsnRightString= avgCorr(n)
 plots2(4) = gsn_csm_contour_map(wks,nodVects_end(l,w,:,:), res)


;************************************************
; create panel
;************************************************
  resP                  = True                   ; modify the panel plot
  resP@gsnFrame         = False                  ; don't advance panel plot
  resP@gsnPanelLabelBar = True                   ; add common colorbar
  resP@gsnPanelMainString = "max min corr and dist plots"     ; set main title
 ; resP@gsnPanelBottom   = 0.05                   ; add space at bottom
 ; resP@gsnPanelFigureStrings= (/"a)","b)","c)"/) ; add strings to panel
  resP@amJust   = "TopLeft"
  gsn_panel(wks,plots2,(/3,2/),resP)               ; now draw as one plot

frame(wks)

delete(wks)
delete(plots2)

end do




end

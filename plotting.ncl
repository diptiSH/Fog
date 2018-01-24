begin

year=2013
mon=1
do i=4,9
day=i

slpfile=addfile("/home/user/Documents/Data/ERA-1.5/Daily_anomalies/ERAANOM-1.5deg-SLP-Dec-Jan-1979-2016.nc","r")
 time = slpfile->time
 printVarSummary(time)
 print(time@units)
 t1= doubletoint(cd_inv_calendar(year,mon,day,12,00,00,time@units,0))
 printVarSummary(t1)
 print(t1)
slptest=slpfile->msl({t1},:,:)
slp=slptest/100.0
  copy_VarMeta(slptest,slp)
delete(slpfile)
mb500file=addfile("/home/user/Documents/Data/ERA-1.5/Daily_anomalies/ERAANOM-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")
t1= doubletoint(cd_inv_calendar(year,mon,day,00,00,00,time@units,0))
 ztest=mb500file->z({t1},:,:)
  z=ztest/9.8
  copy_VarMeta(ztest,z)
delete(mb500file)

mb850file=addfile("/home/user/Documents/Data/ERA-1.5/ERADAILY-1.5deg-850hPa-Dec-Jan-1979-2016.nc","r")

  u=mb850file->u({t1},:,:)
  v=mb850file->v({t1},:,:)
delete(mb850file)

wks = gsn_open_wks("png",year+"_"+mon+"_"+day)         ; send graphics to PNG file
  
  res = True  
  res@mpFillOn = False
  res@mpMaxLatF = 90.                         ; specify the plot domain
  res@mpMinLatF = 0.                         ;                         
  res@mpMinLonF = -100                      ;
  res@mpMaxLonF = 180                        ;
  res@mpCenterLonF = 80
  res@mpOutlineOn = True	                    ; turn the map outline on
  res@gsnFrame     =  False                   ; do not advance the frame
  
  res@cnLevelSelectionMode = "ExplicitLevels" ; use explicit levels
  res@cnLevels = (/-300,-150,-100,-50,-30,-10,-5,5,10,30,50,100,150,300/)             ; set the contour levels
  res@cnLineLabelsOn = False                  ; do not use line labels
  res@cnFillOn        = True                  ; color fill
  res@cnLinesOn       = False                 ; do not draw contour lines
  res@cnFillPalette   = "BlueDarkRed18"
  res@tiMainString = "Inversion and 500hPa Geopotential height anomaly "            ; set the main title
  res@gsnLeftString = ""                      ; do not draw the left sub-title (otherwise automatically set to temp@long_name)
  res@gsnRightString = ""  
  res@gsnPolar   = "NH"                    ; do not draw the right sub-title (otherwise automatically set to temp@units)

  sres = res
  sres@cnLevelSelectionMode = "ManualLevels" ; use explicit levels
 sres@cnMinLevelValF  = -40			; set the minimum contour level
 sres@cnMaxLevelValF  = 40			; set the maximum contour level
 sres@cnLevelSpacingF = 5
  sres@cnFillOn = False                       ; do not color fill
  sres@cnMonoLineThickness =True
  sres@cnLineThicknessF = 3.0
  ;sres@cnMonoLineDashPattern  =True
  ;sres@cnLineDashPattern = 2
  sres@cnMonoLineColor = True
  sres@cnLineColor = "Black"
  sres@cnLinesOn = True                       ; turn the contour lines on
  sres@cnLineLabelsOn = True                  ; turn the line labels on
  sres@tiMainString = ""                      ; do not draw a main title
  delete(sres@cnLevels)                       ; needed as the size of the cnLevels attribute is about to change (next line)
 sres@gsLineDashPattern  = 4 
 sres@gsnContourNegLineDashPattern = 2
  ;sres@cnLevels = (/0.01,0.05/)              ; set a different set of contour levels
  ;sres@cnInfoLabelOrthogonalPosF = 0.4        ; push the InfoLabel down below the label bar
  sres@gsnPolar   = "NH" 
  ;prob=prob
 ;copy_VarMeta(xAve,anomGeo(0,:,:))
 ;copy_VarMeta(xAve,prob)
;printVarSummary(xAve)
  vres=res
  vres@vcRefMagnitudeF       = 20.0              ; vec magnitude
  vres@vcRefLengthF          = 0.04              ; size of ref vector
  vres@vcLineArrowColor      = "black"           ; white vectors
  vres@vcMinDistanceF        = 0.02              ; thins arrows near pole  
  vres@vcGlyphStyle          = "CurlyVector"     ; turns on curley vectors

  vres@vcRefAnnoArrowLineColor   = "black"       ; black ref vector
  vres@vcRefAnnoArrowUseVecColor = False

  
  plot = gsn_csm_contour_map_polar(wks,z,res)    ; create and draw the temperature plot
  plot2 = gsn_csm_contour_map_polar(wks,slp,sres)  ; create and draw the U-wind plot on top of the temperature plot
 plot3 = gsn_csm_vector_map_polar(wks,u,v,vres)  ; create and draw the U-wind plot on top of the temperature plot
  frame(wks)                                  ; advance the frame
end do
end

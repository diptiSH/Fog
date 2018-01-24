begin
levs=(/"500hPa","700hPa","850hPa"/)
low_vals=(/-40,-28,-24/)
high_vals=(/-5.0,12,24/)
int_vals=(/2.5,4,4/)

Glow_vals=(/5100,2640,1150/)
Ghigh_vals=(/5800,3190,1580/)
Gint_vals=(/40,20,20/)


do l=0,2 

invFile=addfile("/home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files/"+levs(l)+"/Comp_ERADAILY-1.5deg_1.5_"+levs(l)+".nc","r")

testanomGeo=invFile->t
anomGeo=testanomGeo-273.1
 copy_VarMeta(testanomGeo,anomGeo)
printVarSummary(anomGeo)

  testprob = invFile ->z
  prob=testprob/9.8
  copy_VarMeta(testprob,prob)

u=invFile->u
v=invFile->v
  
;printVarSummary(u)
;printVarSummary(anomGeo)

wks = gsn_open_wks("png","Temp_z"+levs(l))         ; send graphics to PNG file
  ;gsn_reverse_colormap(wks)
  res = True  
  res@mpFillOn = False
  res@mpMaxLatF = 90.                         ; specify the plot domain
  res@mpMinLatF = 0.                         ;                         
  res@mpMinLonF = 0                      ;
  res@mpMaxLonF = 180                        ;
  res@mpCenterLonF = 80
  res@mpOutlineOn = True	                    ; turn the map outline on
  res@gsnFrame     =  False                   ; do not advance the frame
  
  res@cnLevelSelectionMode = "ManualLevels" ; use explicit levels
  res@cnMinLevelValF  = low_vals(l)			; set the minimum contour level
  res@cnMaxLevelValF  = high_vals(l)			; set the maximum contour level
  res@cnLevelSpacingF = int_vals(l)			; set the interval between contours
 ; res@cnLineLabelsOn = True                  ; do not use line labels
  res@cnFillOn        = True                  ; color fill
  res@cnLinesOn       = False                 ; do not draw contour lines
  res@cnFillPalette   = "cmp_haxby";"MPL_Blues";"MPL_PuBuGn";"GMT_topo";"MPL_pink";"MPL_YlGn";"amwg256";"MPL_autumn";"WhiteBlue";"MPL_summer"
 ; res@cnMonoLineDashPattern  =True
  ;res@gsLineDashPattern  = 2 
  res@tiMainString = "Composite Wind, Temperature and Geopotential height at " +levs(l)            ; set the main title
  res@gsnLeftString = ""                      ; do not draw the left sub-title (otherwise automatically set to temp@long_name)
  res@gsnRightString = ""  
  ;res@gsnPolar   = "NH"                    ; do not draw the right sub-title (otherwise automatically set to temp@units)

  sres = res
sres@cnLevelSelectionMode = "ManualLevels" ; use explicit levels
  sres@cnMinLevelValF  = Glow_vals(l)			; set the minimum contour level
  sres@cnMaxLevelValF  = Ghigh_vals(l)			; set the maximum contour level
  sres@cnLevelSpacingF = Gint_vals(l)			; set the interval between contours
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
 
 ;sres@gsLineDashPattern  = 4 
 ;sres@gsnContourNegLineDashPattern = 2
  ;sres@cnLevels = (/0.01,0.05/)              ; set a different set of contour levels
  ;sres@cnInfoLabelOrthogonalPosF = 0.4        ; push the InfoLabel down below the label bar
 ; sres@gsnPolar   = "NH" 
  ;prob=prob
 ;copy_VarMeta(xAve,anomGeo(0,:,:))
 ;copy_VarMeta(xAve,prob)
;printVarSummary(xAve)
printVarSummary(prob)

  vres=res
 vres@stArrowLengthF     = 0.008                ; default is dynamic
  vres@stLengthCheckCount = 5                    ; default is 35
  vres@stArrowStride      = 1
  vres@stLineStartStride  = 1                    ; default is 2
  vres@stMinArrowSpacingF = 0.03                 ; default is 0.0             
  vres@stStepSizeF        = 0.001                ; default is dynamic

  vres@stMinDistanceF     = 0.03                 ; distance between lines
  vres@stMinLineSpacingF  = 0.005                

 

  
 
  plot = gsn_csm_contour_map(wks,anomGeo(0,:,:),res)    ; create and draw the temperature plot
  plot2 = gsn_csm_contour_map(wks,prob(0,:,:),sres)  ; create and draw the U-wind plot on top of the temperature plot
  plot3=gsn_csm_streamline_map(wks,u(0,:,:),v(0,:,:),vres)
  frame(wks)                                  ; advance the frame
end do
end

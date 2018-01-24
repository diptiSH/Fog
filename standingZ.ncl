begin

levs=(/"500hPa","700hPa","850hPa","950hPa"/)
low_vals=(/-240,-175,-180,-200/)
high_vals=(/240,175,180,200/)
int_vals=(/40,25,20,25/)



do l=0,3 


geopFile=addfile("/home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files/"+levs(l)+"/Comp_ERADAILY-1.5deg_1.5_"+levs(l)+".nc","r")


  testz = geopFile ->z
  z=testz/9.8

  copy_VarMeta(testz,z)
    zonalAvgRmZ=dim_rmvmean_n_Wrap(z,2)  
    printVarSummary(z)
    printVarSummary(zonalAvgRmZ)

wks = gsn_open_wks("png","Standing_z_"+levs(l))         ; send graphics to PNG file
  
  sres = True  
  ;res@mpMaxLatF = 90.                         ; specify the plot domain
  ;res@mpMinLatF = 0.                         ;                         
  ;res@mpMinLonF = -100                      ;
  ;res@mpMaxLonF = 180                        ;
  sres@mpCenterLonF = 80
  sres@mpOutlineOn = True	                    ; turn the map outline on
  sres@gsnFrame     =  False                   ; do not advance the frame
  
   sres@cnLevelSelectionMode = "ManualLevels" ; use explicit levels
 sres@cnMinLevelValF  = low_vals(l)			; set the minimum contour level
 sres@cnMaxLevelValF  = high_vals(l)			; set the maximum contour level
 sres@cnLevelSpacingF = int_vals(l)			; set the interval between contours
  ;sres@cnLineLabelsOn = False                  ; do not use line labels
  sres@tiMainString = "Zonal mean removed Geopotential height "+levs(l)            ; set the main title
  sres@gsnLeftString = ""                      ; do not draw the left sub-title (otherwise automatically set to temp@long_name)
  sres@gsnRightString = ""  
  sres@cnFillOn = False                       ; do not color fill
  sres@cnMonoLineThickness =True
  sres@cnLineThicknessF = 3.0
  ;sres@cnMonoLineDashPattern  =True
  ;sres@cnLineDashPattern = 2
  sres@cnMonoLineColor = True
  sres@cnLineColor = "Black"
  sres@cnLinesOn = True                       ; turn the contour lines on
  sres@cnLineLabelsOn = True                  ; turn the line labels on
  sres@gsLineDashPattern  = 4 
  sres@gsnContourNegLineDashPattern = 2
  ;sres@cnLevels = (/0.01,0.05/)              ; set a different set of contour levels
  ;sres@cnInfoLabelOrthogonalPosF = 0.4        ; push the InfoLabel down below the label bar
  sres@gsnPolar   = "NH" 
  ;prob=prob
 ;copy_VarMeta(xAve,anomGeo(0,:,:))
 ;copy_VarMeta(xAve,prob)
;printVarSummary(xAve)


  plot2 = gsn_csm_contour_map_polar(wks,zonalAvgRmZ(0,:,:),sres)  ; create and draw the U-wind plot on top of the temperature plot
  frame(wks)                                  ; advance the frame
end do
end

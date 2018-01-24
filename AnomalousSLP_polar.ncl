begin
levs=(/"SLP"/)

do l=0,0 

invFile=addfile("/home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files/"+levs(l)+"/Anom_ERADAILY-1.5deg_1.5_"+levs(l)+".nc","r")

testanomGeo=invFile->msl
anomGeo=testanomGeo/100.0
 copy_VarMeta(testanomGeo,anomGeo)
printVarSummary(anomGeo)

in_omegaFile=addfile("/home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files/700hPa/Anom_ERADAILY-1.5deg_1.5_700hPa.nc","r")
w=in_omegaFile->w

wks = gsn_open_wks("png","SLP"+levs(l))         ; send graphics to PNG file
  
  res = True  
  res@mpFillOn = False
 ; res@mpMaxLatF = 90.                         ; specify the plot domain
 ; res@mpMinLatF = 0.                         ;                         
 ; res@mpMinLonF = -100                      ;
 ; res@mpMaxLonF = 180                        ;
  res@mpCenterLonF = 80
  res@mpOutlineOn = True	                    ; turn the map outline on
  res@gsnFrame     =  False                   ; do not advance the frame
  
  res@cnLevelSelectionMode = "ExplicitLevels" ; use explicit levels
  res@cnLevels = (/-0.04,-0.03,-0.02,-0.01,0,0.01,0.02,0.03,0.04/)             ; set the contour levels
 ; res@cnLineLabelsOn = True                  ; do not use line labels
  res@cnFillOn        = True                  ; color fill
  res@cnLinesOn       = False                 ; do not draw contour lines
  res@cnFillPalette   = "amwg256";"MPL_autumn";"WhiteBlue";"MPL_summer"
 ; res@cnMonoLineDashPattern  =True
  ;res@gsLineDashPattern  = 2 
  res@tiMainString = "Anomaly 700hPa Omega" +levs(l)            ; set the main title
  res@gsnLeftString = ""                      ; do not draw the left sub-title (otherwise automatically set to temp@long_name)
  res@gsnRightString = ""  
  res@gsnPolar   = "NH"                    ; do not draw the right sub-title (otherwise automatically set to temp@units)
  
 
  sres = res
  delete(sres@cnLevels)
  sres@cnLevelSelectionMode = "ExplicitLevels" ; use explicit levels
  sres@cnLevels = (/-3.5,-3,-2.5,-2,-1.5,-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5/)             ; set the contour levels032,1036/)             ; set the contour levels
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
  ;delete(sres@cnLevels)                       ; needed as the size of the cnLevels attribute is about to change (next line)
 sres@gsLineDashPattern  = 4 
 sres@gsnContourNegLineDashPattern = 2
  ;sres@cnLevels = (/0.01,0.05/)              ; set a different set of contour levels
  ;sres@cnInfoLabelOrthogonalPosF = 0.4        ; push the InfoLabel down below the label bar


  plot = gsn_csm_contour_map_polar(wks,w(0,:,:),res)    ; create and draw the temperature plot
  plot2 = gsn_csm_contour_map_polar(wks,anomGeo(0,:,:),sres)  ; create and draw the U-wind plot on top of the temperature plot  

  frame(wks)                                  ; advance the frame
end do
end

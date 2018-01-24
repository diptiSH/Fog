begin

datesData=readAsciiTable("TwoSigDates",3,"integer",0)
;print(datesData)

do d=0,6

year=datesData(d,0)
mon=datesData(d,1)
day=datesData(d,2)


levs=(/"SLP"/)

do l=0,0 

invFile=addfile("/home/user/Documents/Data/ERA-1.5/ERADAILY-1.5deg-"+levs(l)+"-Dec-Jan-1979-2016.nc","r")
time = invFile->time
printVarSummary(time)
t1= doubletoint(cd_inv_calendar(year,mon,day,12,00,00,time@units,0))
 printVarSummary(t1)
 print(t1)


testanomGeo=invFile->msl({t1},:,:)
anomGeo=testanomGeo/100.0
 copy_VarMeta(testanomGeo,anomGeo)
;printVarSummary(anomGeo)

in_omegaFile=addfile("/home/user/Documents/Data/ERA-1.5/ERADAILY-1.5deg-700hPa-Dec-Jan-1979-2016.nc","r")
w=in_omegaFile->w({t1},:,:)
;time1=in_omegaFile->time
;printVarSummary(time1)


wks = gsn_open_wks("png",year+"_"+mon+"_"+day+"SLP")         ; send graphics to PNG file
  
  res = True  
  res@mpFillOn = False
  res@mpMaxLatF = 90.                         ; specify the plot domain
  res@mpMinLatF = 0.                         ;                         
  res@mpMinLonF = 0                      ;
  res@mpMaxLonF = 180                        ;
  res@mpCenterLonF = 80
  res@mpOutlineOn = True	                    ; turn the map outline on
  res@gsnFrame     =  False                   ; do not advance the frame
  
  res@cnLevelSelectionMode = "ExplicitLevels" ; use explicit levels
  res@cnLevels = (/-.125,-0.1,-0.075,-0.05,-0.025,0,0.025,.05,.075,.1,.125/)             ; set the contour levels
 ; res@cnLineLabelsOn = True                  ; do not use line labels
  res@cnFillOn        = True                  ; color fill
  res@cnLinesOn       = False                 ; do not draw contour lines
  res@cnFillPalette   = "amwg256";"MPL_autumn";"WhiteBlue";"MPL_summer"
 ; res@cnMonoLineDashPattern  =True
  ;res@gsLineDashPattern  = 2 
  res@tiMainString = "Composite 700hPa Omega" +levs(l)            ; set the main title
  res@gsnLeftString = ""                      ; do not draw the left sub-title (otherwise automatically set to temp@long_name)
  res@gsnRightString = ""  
  ;res@gsnPolar   = "NH"                    ; do not draw the right sub-title (otherwise automatically set to temp@units)
  
 
  sres = res
 sres@cnLevelSelectionMode = "ExplicitLevels" ; use explicit levels
 sres@cnLevels = (/996,1000,1004,1008,1012,1016,1020,1024,1028,1032,1036/)             ; set the contour levels
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
 ;sres@gsLineDashPattern  = 4 
 ;sres@gsnContourNegLineDashPattern = 2
  ;sres@cnLevels = (/0.01,0.05/)              ; set a different set of contour levels
  ;sres@cnInfoLabelOrthogonalPosF = 0.4        ; push the InfoLabel down below the label bar


  plot = gsn_csm_contour_map(wks,w(:,:),res)    ; create and draw the temperature plot
  plot2 = gsn_csm_contour_map(wks,anomGeo(:,:),sres)  ; create and draw the U-wind plot on top of the temperature plot  

  frame(wks)                                  ; advance the frame
end do

end do
end

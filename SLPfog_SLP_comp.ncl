;GeoComp


begin

; ================================>  ; PARAMETERS
  Slat           = 0                     ; Lat_lon values
  Nlat           = 55
  Wlon           = 30
  Elon           = 120
  nlev           = 3
 
   

; ================================>   ;read data for composite

do l=0,1
numb=l+1

wks1 = gsn_open_wks("eps" ,"SLP_SOM"+numb)                ; open a ps file

 gsn_define_colormap(wks1,"MPL_YlGnBu")       ; choose colormap


;==============================================
; create plot
;=============================================
;************************************************
; resource list for first data array
;************************************************

 hres                      = True
  ;hres@gsnDraw              = False              ; don't draw
  ;hres@gsnFrame             = False              ; don't advance frame
  hres@cnLineLabelsOn       = True
  hres@cnLineLabelFontHeightF = 0.006
 hres@cnLineColor             = "black"
 hres@cnSmoothingOn = True 
 hres@cnSmoothingTensionF = 0.001
 ; hres@gsnContourPosLineDashPattern = 2
;hres@gsnContourNegLineDashPattern = 2
  hres@gsnMaximize = True 
 hres@cnLineThicknessF             = 0.08
  hres@gsnRightString = "SOM"+numb
  hres@gsnLeftString = " "
  hres@mpFillOn              = False              ; turn off map fill
 ;hres@cnLinesOn              = False 
hres@cnFillOn              = False 
 hres@mpOutlineOn           = True               ; turn on map outlines
 ;hres@mpOutlineBoundarySets = "National" 
hres@mpGeophysicalLineColor = "gray" 
 hres@mpGeophysicalLineThicknessF  = 4.5
hres@cnLevelSelectionMode = "ManualLevels"
hres@cnMinLevelValF       = 1008
hres@cnMaxLevelValF       = 1050
hres@cnLevelSpacingF      = 3
 hres@cnInfoLabelSide= "Bottom" 
 hres@gsnAddCyclic          = False    ; data already has cyclic point
 hres@mpMinLonF            =  Wlon            ; select a subregion
  hres@mpMaxLonF            =  Elon
  hres@mpMinLatF            =  Slat
  hres@mpMaxLatF            =  Nlat
;hres@cnLineLabelsOn  = False                   ; tuen off line labels
 

  fname="SOM"+numb+".nc"

d=addfile(fname,"r")
  slp = d->GeoComp
  slp = smth9_Wrap(slp,0.5, 0.25, False)

  plot = gsn_csm_contour_map(wks1,slp, hres)


end do


       





end



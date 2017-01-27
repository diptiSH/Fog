begin






pmsl9=new((/9,135,241/),float)


do i=0,8

j=i-4

fname="/home/dipti/Documents/pressure_tendency/2SOM1/comp/comp_"+j+".nc"



d=addfile(fname,"r")

pmsl=d->msl(:,::-1,:)

pmsl=pmsl/100.0

printVarSummary(pmsl)



pmsl9(i,:,:)=pmsl

end do

printVarSummary(pmsl9)

do i=0,7
j=i-4
nextDay=j+1
sameDay=j
 wks1 = gsn_open_wks("eps" ,"2SOM1pres_tend_day_"+nextDay)                ; open a ps file
gsn_define_colormap(wks1,"ncl_default")       ; choose colormap

; plot=new(8,graphic)

;************************************************
; resource list for second data array
;************************************************
  res2                      = True
  res2@gsnAddCyclic        = False
 ;res2@gsnDraw              = False              ; don't draw
 ; res2@gsnFrame             = False              ; don't advance frame
  res2@cnLineLabelsOn       = False
  res2@cnFillOn        = True                    ; turn on color
  res2@cnLineLabelFontHeightF = 0.006
 ;res2@cnLineColor             = "black"
 res2@cnLineThicknessF             = 0.0002
 res2@gsnLeftString = ""
 res2@gsnRightString = ""
 res2@cnLevelSelectionMode = "ManualLevels"
 res2@cnMinLevelValF       = -2
 res2@cnMaxLevelValF       = 2
 res2@cnLevelSpacingF      = 0.4
 res2@cnInfoLabelSide= "Top" 
 res2@gsnMaximize = True
  res2@mpMinLonF            =  30           ; select a subregion
  res2@mpMaxLonF            =  150
  res2@mpMinLatF            =  0
  res2@mpMaxLatF            =  70
 res2@cnInfoLabelString=" Pressure Tendency Pa/day $CMN$ to $CMX$ by $CIU$ (Red)"



pmsl_diff=pmsl9(i+1,:,:)
pmsl_diff=pmsl9(i+1,:,:)-pmsl9(i,:,:)
print(j+1)
print(j)
printVarSummary(pmsl9)
printVarSummary(pmsl_diff)
plot=gsn_csm_contour_map(wks1,pmsl_diff,res2)

end do


;************************************************
; create panel
;************************************************
  resP                     = True                ; modify the panel plot
                                                 ; new resource added in NCL V6.4.0
  resP@gsnPanelMainString = "Fog Composite"
  resP@gsnPanelRowSpec = True                       ; use this for NCL V6.3.0 and earlier
  ;resP@txString           = "Fog Composite At "+levelNames(j)+" hPa"

  ;resP@gsnPanelLabelBar    = True                ; add common colorbar
  resP@lbLabelFontHeightF  = 0.007               ; make labels smaller
  resP@gsnMaximize    = True                ; maximize plots
  gsn_panel(wks1,plot,(/4,1,4/),resP)               ; now draw as one plot
  
  
     


end

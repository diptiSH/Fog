begin
low_vals=-40
high_vals=-5
int_vals=2.5

Glow_vals=8500
Ghigh_vals=5900
Gint_vals=100


;#######################do loop for days##############
do n=0,14
;Addfile
fname="/home/user/Documents/work/me10Criterion/OneSigma_anom/sequence/850hPa/Anom"+n+"ERA_1.5deg_850hPa.nc"
f=addfile(fname,"r")

;read variables
testz=f->z
z=testz/9.8
copy_VarMeta(testz,z)


temp=f->t
temp=temp-273.1


u=f->u
v=f->v
;printVarSummary(temp)

;print(fname)

day=n-7

wks = gsn_open_wks("eps","WindOneSigma_Anom_850hPa_"+day)         ; send graphics to eps file

res = True  
;res@mpFillOn = False
res@mpCenterLonF = 80
;res@mpOutlineOn = True	                    ; turn the map outline on
res@gsnFrame     =  False                   ; do not advance the frame
res@cnLevelSelectionMode = "ManualLevels" ; use explicit levels
res@cnMinLevelValF  = low_vals			; set the minimum contour level
res@cnMaxLevelValF  = high_vals			; set the maximum contour level
res@cnLevelSpacingF = int_vals			; set the interval between contours
res@cnFillOn        = True                  ; color fill
res@cnLinesOn       = False                 ; do not draw contour lines
res@cnFillPalette   = "cmp_haxby";"MPL
res@tiMainString = "Anomaly  Wind at 850hPa "+day            ; set the main title
res@gsnLeftString = ""                      ; do not draw the left sub-title (otherwise automatically set to temp@long_name)
res@gsnRightString = ""  
res@gsnPolar   = "NH"                    ; do not draw the right sub-title (otherwise automatically set to temp@units)

  sres = res
  sres@cnLevelSelectionMode = "ManualLevels" ; use explicit levels
  sres@cnMinLevelValF  = Glow_vals			; set the minimum contour level
  sres@cnMaxLevelValF  = Ghigh_vals			; set the maximum contour level
  sres@cnLevelSpacingF = Gint_vals			; set the interval between contours
  sres@cnFillOn = False                       ; do not color fill
  sres@cnMonoLineThickness =True
  sres@cnLineThicknessF = 1
  sres@cnMonoLineDashPattern  =True
  sres@cnLineDashPattern = 1
  sres@cnMonoLineColor = True
  sres@cnLineColor = "Black"
  sres@cnLinesOn = True                       ; turn the contour lines on
  sres@cnLineLabelsOn = True                  ; turn the line labels on
  sres@tiMainString = ""                      ; do not draw a main title
  sres@cnLineLabelInterval=1
  sres@gsnContourNegLineDashPattern = 2

  vres=res
  vres@stArrowLengthF     = 0.008                ; default is dynamic
  vres@stLengthCheckCount = 5                    ; default is 35
  vres@stArrowStride      = 1
  vres@stLineStartStride  = 1                    ; default is 2
  vres@stMinArrowSpacingF = 0.03                 ; default is 0.0             
  vres@stStepSizeF        = 0.001                ; default is dynamic
  vres@stMinDistanceF     = 0.03                 ; distance between lines
  vres@stMinLineSpacingF  = 0.005   




 ; plot = gsn_csm_contour_map_polar(wks,temp(0,:,:),res)    ; create and draw the temperature plot
 ; plot2 = gsn_csm_contour_map_polar(wks,z(0,:,:),sres)  
  plot3=gsn_csm_streamline_map_polar(wks,u(0,:,:),v(0,:,:),vres) ;; create and draw the wind plot on top of the temperature and z  plot
  frame(wks)                                  ; advance the frame             

end do

end

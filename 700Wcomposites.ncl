begin
low_vals=-0.5
high_vals=0.5
int_vals=0.1

Glow_vals=5000
Ghigh_vals=5900
Gint_vals=100


;#######################do loop for days##############
do n=0,14
;Addfile
fname="/home/user/Documents/work/me10Criterion/OneSigma_anom/sequence/700hPa/Comp"+n+"ERA_1.5deg_700hPa.nc"
f=addfile(fname,"r")

;read variables
testz=f->w
z=testz;/100.0
copy_VarMeta(testz,z)

printVarSummary(z)

;print(fname)

day=n-7

wks = gsn_open_wks("eps","OneSigma_Comp_700hPa_"+day)         ; send graphics to eps file

res = True  
res@mpFillOn = False
res@mpCenterLonF = 80
;res@mpOutlineOn = True	                    ; turn the map outline on
res@gsnFrame     =  False                   ; do not advance the frame
res@cnLevelSelectionMode = "ManualLevels" ; use explicit levels
res@cnMinLevelValF  = low_vals			; set the minimum contour level
res@cnMaxLevelValF  = high_vals			; set the maximum contour level
res@cnLevelSpacingF = int_vals			; set the interval between contours
res@cnFillOn        = True                  ; color fill
res@cnLinesOn       = False                 ; do not draw contour lines
;res@cnFillPalette   = "cmp_haxby";"MPL
res@tiMainString = "Composite  Omega at 700hPa "+day            ; set the main title
res@gsnLeftString = ""                      ; do not draw the left sub-title (otherwise automatically set to temp@long_name)
res@gsnRightString = ""  
res@gsnPolar   = "NH"                    ; do not draw the right sub-title (otherwise automatically set to temp@units)

  
  plot = gsn_csm_contour_map_polar(wks,z(0,:,:),res)    ; create and draw the temperature plot
   frame(wks)                                  ; advance the frame             

end do

end

begin
f=addfile("/home/iitm/fog-files-d/Fog/AnomERA3D-00UTC-1.5deg_Fog.nc","r")
f_elev=addfile("/media/Seagate Backup Plus Drive/2018/fog-files-D/DATA/ERA-1.5deg-elevation.nc","r")

z=f_elev->z(:,{15:45},{80})
printVarSummary(z)
S_pr=z
S_pr=1013.25-(z/(9.0))

printVarSummary(S_pr)



w=f->w(:,{1000:150},{15:45},{80})
w_m=w
w_m=w*10.0

levs=w&level


printVarSummary(w)

wks   = gsn_open_wks ("png", "elevh_lat" )          ; send graphics to PNG file

 res                      = True                 ; plot mods desired
res@gsnFrame              = False           ; don't advance frame yet
res@gsnDraw            = False  
; res@cnLevelSelectionMode = "ManualLevels"       ; manually select levels
; res@cnLevelSpacingF      = 0.1                  ; contour spacing
; res@cnMinLevelValF       = -0.6                 ; min level
; res@cnMaxLevelValF       =  0.6                ; max level
 res@cnLineLabelsOn       = True                 ; turn on line labels
; res@cnFillOn             = True                 ; turn on color fill
; res@cnFillPalette        = "BlWhRe"             ; choose colormap
 res@gsnContourZeroLineThicknessF = 2. 
  res@gsnContourNegLineDashPattern = 1
res@gsnRightString = "microbar/s"

  plot  = gsn_csm_pres_hgt(wks, w_m(0,:,:), res )   ; place holder


xp=new(24,typeof(S_pr&latitude))
yp=new(24,typeof(S_pr))

xp(0)=S_pr&latitude(0)
yp(0)=1000
do i=0,20
 xp(i+1)=S_pr&latitude(i)
 yp(i+1)=S_pr(0,i)
end do
xp(22)=S_pr&latitude(20)
yp(22)=1000

xp(23)=S_pr&latitude(0)
yp(23)=1000

gsres                   = True                        ; poly res
 gsres@gsFillColor       = "SlateBlue"                 ; color chosen
 dummy = gsn_add_polygon (wks,plot,xp,yp,gsres)
 
  draw(plot) 
 frame(wks) 

end

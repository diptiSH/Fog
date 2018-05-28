begin
f=addfile("/home/iitm/fog-files-d/AO_EU_analysis/AO_neg_EU_pos/Anom7ERA3D-00UTC-1.5deg_Fog.nc","r")

w=f->w(:,{1000:150},{15:45},{80})
w_m=w
w_m=w*10.0

printVarSummary(w)

wks   = gsn_open_wks ("eps", "AO_neg_EU_pos_h_lat" )          ; send graphics to PNG file

  res                      = True                 ; plot mods desired

  res@cnLevelSelectionMode = "ManualLevels"       ; manually select levels
  res@cnLevelSpacingF      = 0.1                  ; contour spacing
  res@cnMinLevelValF       = -0.6                 ; min level
  res@cnMaxLevelValF       =  0.6                ; max level
  res@cnLineLabelsOn       = True                 ; turn on line labels
  res@cnFillOn             = True                 ; turn on color fill
  res@cnFillPalette        = "BlWhRe"             ; choose colormap
 
  res@gsnRightString = "microbar/s"

 plot  = gsn_csm_pres_hgt(wks, w_m(0,:,:), res )   ; place holder

end

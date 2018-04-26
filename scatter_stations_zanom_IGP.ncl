begin

;*********************500hPa file
fInv=addfile("/home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files/500hPa/ERAANOM-1.5deg_1.5_500hPa.nc","r")
t_old=fInv->z
printVarSummary(t_old)
t=t_old(:,{25:40},{60:90})
printVarSummary(t)
inv=t/9.81

copy_VarMeta(inv,t)
printVarSummary(inv)
delete(fInv)

dailyAnom=dim_avg_n_Wrap(inv,(/1,2/))

printVarSummary(dailyAnom)


noStations=asciiread("fog_stations",105,"integer") 

;;;;;;;;plots

wks = gsn_open_wks("png" ,"AnomAA500hPazIGPV_VS_foggyStations")

 
 res = True
 ;res@tiMainString     = no_of_days+" Fog Days  00Z for "+ext(p)          ; add title
 res@xyMarkLineModes   = "Markers"                ; choose which have markers
 res@xyMarkers         =  16                      ; choose type of marker  
 res@xyMarkerColor     = "red"                    ; Marker color
 res@xyMarkerSizeF     = 0.003                     ; Marker size (default 0.01)
 res@gsnYRefLine           = 9.0             ; create a reference line  
 res@gsnXRefLine           = 0.0             ; create a reference line  
  ;res@trYMinF  = -1                  ; min value on y-axis
  ;res@trYMaxF  =  1                 ; max value on y-axis.0
  ;res@trXMinF  = -9                   ; min value on X-axis
  ;res@trXMaxF  =  9                   ; max value on X-axis
  ;res@tiXAxisString = "Standard Normal Anomaly of Area Averaged 500 Geopotential Height (25:40N, 60-90E)"  ; axis string
  res@tiXAxisString = " Anomaly of Area Averaged 500 z(25:40N, 60-90E)"  ; axis string
  res@tiYAxisString = "All Stations"  ; axis string
 polyres                  = True
  polyres@gsLineThicknessF = 3.0

res                  = True    
;printVarSummary(AllnoStations)
;plot = gsn_csm_xy(wks,dailyStdNAnom(0:2138),noStations(0:2138),res)
plot = gsn_csm_xy(wks,dailyAnom(0:104),noStations(0:104),res)
;dailyAnom




end

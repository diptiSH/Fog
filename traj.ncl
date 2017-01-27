;
; These files are loaded by default in NCL V6.2.0 and newer
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "./shapefile_utils.ncl"
begin


sname = "india_st.shp"
print_shapefile_info(sname)
plot_shapefile(sname)

;Dir="/home/dipti/Documents/som-trajectors/PLots/Delhi/Indata/"

  fils = systemfunc ("ls *.csv") ; file paths
 
   print(fils)

 colors= (/"red","cadet blue","green","deeppink4","dark green","black","blue4","orange","blue violet"/) ; line color
stationNames=(/"Amritsar","Hissar","New Delhi","Lucknow","Patna","Jaipur","Gwalior","Allahabad","Gaya"/)
 c=0  


days=dimsizes(fils)    ;consider days as stations


 wks = gsn_open_wks("eps","Trajectory")               ; send graphics to PNG file
   res            = True                          ; map resources
   res@gsnDraw    = False                         ; don't draw
   res@gsnFrame   = False                         ; don't advance frame
   ;res@vpWidthF   = 0.80                          ; make map bigger
   ;res@vpHeightF  = 0.80
   res@mpMaxLatF  = 45                    ; select subregion
   res@mpMinLatF  = 15
   res@mpMinLonF  = 60
   res@mpMaxLonF  = 100
   res@mpFillOn              = False              ; turn off map fill
   res@mpOutlineOn           = False              ; turn on map outlines
   res@gsLineDashPattern = 0                      ; dashed lines
   res@tiMainString    = "Trajectory"; title
   ;res@gsnCenterString = "markers every 4th time step"   ; center string
  
   res@mpDataBaseVersion     = "MediumRes"               ; better map outlines
   res@pmTickMarkDisplayMode = "Always"                  ; better map tickmarks

   map = gsn_csm_map_ce(wks,res)                         ; create map
  
   ;*********************************************
; some plot parameters
;*********************************************
   pres                  = True               ; polyline resources
   pres@gsLineThicknessF = 2.0                ; line thickness
  

   mres  = True                               ; marker resources
   first = True                               ; start of traj resources
;********************************
                                        ; counter variable
                ; loop through chosen traj
      



 ;     Add markers to the trajectories.
   mres                = True         ; marker resources for best track
   mres@gsMarkerIndex  = 16           ; marker style (filled circle)
   mres@gsMarkerSizeF  = 2.0          ; marker size
   mres@gsMarkerColor  = "black"      ; maker color
 ;   initiate line and marker arrays 
  line=new(days,graphic) 
  markers=new(days,graphic)


 do i = 0,days-1 

;---Read in file as array of strings so we can parse each line
  data = readAsciiTable(fils(i),2,"float",0)


     ; print(ypt)
      pres@gsLineColor = colors(c)            ; line color for this traj
      pres@gsLineDashPattern  = 0
      c=c+1                                   ; advance counter
       
  delim = " "

;---Read fields
  lon = data(:,0);tofloat(str_get_field(lines,1,delim))
  lat  = data(:,1)  ;tofloat(str_get_field(lines,2,delim))
     
;print(lat)

 line(i) = gsn_add_polyline(wks,map,lon,lat,pres)      ; draw the traj

   ;markers(i) = gsn_add_polymarker(wks,map,lon,lat,mres)
 ; printVarSummary(line)
  printVarSummary(markers)

; delete(lines)
 delete(lon)
 delete(lat)            
end do 

;***********************************************
; legend resources
;***********************************************
  lgres                    = True
  lgres@lgLineColors     = colors
  lgres@lgLineThicknessF   = 4;pres@gsLineThicknessF  ; legend line thickness = contour line thickness
 ; lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = .04            ; set the legend label font thickness
  lgres@vpWidthF           = 0.2        ; width of legend (NDC)
  lgres@vpHeightF          = 0.1           ; height of legend (NDC)
  lgres@lgPerimColor       = "orange"       ; draw the box perimeter in orange
  ;lgres@lgPerimThicknessF  = 5.0            ; thicken the box perimeter
  lgres@lgOrientation = "horizontal"
  lgres@lgLabelAngleF = 275.
  lgres@lgPerimOn              = False               ; turn off box
  lgres@lgDashIndexes      = (/0,0,0,0,0,0,0,0,0/)              ; dash indexes
  lbid = gsn_create_legend(wks,9,stationNames,lgres)         ; create legend
  amres = True
  amres@amParallelPosF   = 0.35		    ; move legend to the right
  amres@amOrthogonalPosF = 0.75           ; move the legend down
 ; annoid1 = gsn_add_annotation(map,lbid,amres)   ; add legend to plot
   ;gsn_legend_ndc(wks,9,stationNames,0.4,0.15,lgres)
 maximize_output(wks,res)  ; calls draw and frame for you 
   lnres                  = True
  lnres@gsLineThicknessF = 1.0
     lnres@gsLineColor      = "Black"
   ;  ind_adm1 = gsn_add_shapefile_polylines(wks,plot(0),"IND_adm/IND_adm1.shp",lnres)
     ind_adm2 = gsn_add_shapefile_polylines(wks,map,"india_st.shp",lnres)

  draw(map)                                           
   frame(wks) 
end

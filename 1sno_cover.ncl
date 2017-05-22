begin


  nrows = 720
  ncols = 720


   fils = systemfunc ("ls /home/dipti/Documents/data/Snow/2010/ *.bin") ; file paths
   
   print(fils) 
  
  dir="/home/dipti/Documents/data/Snow/2010/"

do i=1,5
  fname=dir+fils(i)

 print(fname)

 data    = fbindirread (fname,0, (/nrows,ncols/),"byte")
lat  =  fbindirread ("/home/dipti/Documents/data/Snow/gridloc.EASE2_N25km/EASE2_N25km.lats.720x720x1.double",0, (/nrows,ncols/),"double")

lon =  fbindirread ("/home/dipti/Documents/data/Snow/gridloc.EASE2_N25km/EASE2_N25km.lons.720x720x1.double",0, (/nrows,ncols/),"double")

strs = str_split(fils(i), ".")

print(strs)

wks = gsn_open_wks("eps",strs(2))
gsn_define_colormap(wks,"default")

res = True
res@cnFillOn = True
res@cnLinesOn = False
res@cnLineLabelsOn = False
res@cnFillMode = "rasterfill"
res@cnMissingValFillColor = "gray"   ; "gray"
res@gsnAddCyclic=False

res@cnLevelSelectionMode = "explicitlevels"
res@cnLevels = (/-.9, 0.1,1.1,4.5,5.1/)
res@cnFillColors =  (/"white", "gray", "pink","white","pink","white" /)
;res@lbLabelAlignment = "boxcenters"
;res@lbLabelStrings = (/ "rest", "land", "snow_land","Sea_ice","snow_q","rest" /)
;res@cnExplicitLabelBarLabelsOn = True
;res@cnLabelBarEndStyle = "excludeouterboxes"
;res@lbAutoManage = False
;res@lbLabelFontHeightF = 0.02


plot = gsn_csm_contour(wks,data,res)


res@trGridType = "triangularmesh"
res@tfDoNDCOverlay = False
res@sfXArray = lon
res@sfYArray = lat
;res@gsnMaximize = True 
;res@gsnPolar             = "NH"               ; specify the hemisphere
  res@mpMinLatF            = 10                 ; specify min lat
  res@mpMinLonF            = 0                 ; specify min lat
res@mpMaxLonF            = 180                 ; specify min lat
  res@mpMaxLatF            =80                ; specify min lat
plot =gsn_csm_contour_map (wks,data,res)

end do

end


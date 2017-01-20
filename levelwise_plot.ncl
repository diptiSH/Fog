load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin


     Slat           = 0                     ; Lat_lon values
  Nlat           = 55
  Wlon           = 30
  Elon           = 120
  nlat           = 74                        ; # no of latitudes
  nlon           = 121                        ; # no of longitudes
  levelNames     = (/200,500,850/)      ; levels
  lowValTemp     =(/-66,-40,-5/)
  highValTemp     =(/-45,-5,30/)
  intValTemp     =(/2.5,2.5,3/)
   lowValWind     =(/5,2,1/)
  highValWind     =(/70,30,16/)
  intValWind     =(/5,2,1/)
  lowValgeo     =(/10000,5000,1000/)
  highValgeo     = (/13000,6500,2500/)
  intValgeo     =(/120,60,30/)
  no_som         = 2
  ;refMag         = (/50,40,30,20,10,5/)
  

data=new((/12,no_som+1 ,nlat*nlon+1/),"float") ;input data*no of soms*datapoints

geop=new((/no_som,6,nlat,nlon/),"float")
Uwind=new((/no_som,6,nlat,nlon/),"float")
Vwind=new((/no_som,6,nlat,nlon/),"float")
tempL=new((/no_som,6,nlat,nlon/),"float")


lat_points=(/ 54.75, 54, \
    53.25, 52.5, 51.75, 51, 50.25, 49.5, 48.75, 48, 47.25, 46.5, 45.75, 45, \
    44.25, 43.5, 42.75, 42, 41.25, 40.5, 39.75, 39, 38.25, 37.5, 36.75, 36, \
    35.25, 34.5, 33.75, 33, 32.25, 31.5, 30.75, 30, 29.25, 28.5, 27.75, 27, \
    26.25, 25.5, 24.75, 24, 23.25, 22.5, 21.75, 21, 20.25, 19.5, 18.75, 18, \
    17.25, 16.5, 15.75, 15, 14.25, 13.5, 12.75, 12, 11.25, 10.5, 9.75, 9, \
    8.25, 7.5, 6.75, 6, 5.25, 4.5, 3.75, 3, 2.25, 1.5, 0.75, 0/)
  lat_points = lat_points(::-1)
lon_points=(/30, 30.75, 31.5, 32.25, 33, 33.75, 34.5, 35.25, 36, \
    36.75, 37.5, 38.25, 39, 39.75, 40.5, 41.25, 42, 42.75, 43.5, 44.25, 45, \
    45.75, 46.5, 47.25, 48, 48.75, 49.5, 50.25, 51, 51.75, 52.5, 53.25, 54, \
    54.75, 55.5, 56.25, 57, 57.75, 58.5, 59.25, 60, 60.75, 61.5, 62.25, 63, \
    63.75, 64.5, 65.25, 66, 66.75, 67.5, 68.25, 69, 69.75, 70.5, 71.25, 72, \
    72.75, 73.5, 74.25, 75, 75.75, 76.5, 77.25, 78, 78.75, 79.5, 80.25, 81, \
    81.75, 82.5, 83.25, 84, 84.75, 85.5, 86.25, 87, 87.75, 88.5, 89.25, 90, \
    90.75, 91.5, 92.25, 93, 93.75, 94.5, 95.25, 96, 96.75, 97.5, 98.25, 99, \
    99.75, 100.5, 101.25, 102, 102.75, 103.5, 104.25, 105, 105.75, 106.5, \
    107.25, 108, 108.75, 109.5, 110.25, 111, 111.75, 112.5, 113.25, 114, \
    114.75, 115.5, 116.25, 117, 117.75, 118.5, 119.25, 120/)
lat_points@units="degrees_north"
lon_points@units="degrees_east"

geop!2 = "lat"
geop!3 = "lon"
Uwind!2 = "lat"
Uwind!3 = "lon"
Vwind!2 = "lat"
Vwind!3 = "lon"
tempL!2 = "lat"
tempL!3 = "lon"

geop&lat=lat_points
geop&lon=lon_points

Uwind&lat=lat_points
Uwind&lon=lon_points

Vwind&lat=lat_points
Vwind&lon=lon_points

tempL&lat=lat_points
tempL&lon=lon_points



do i=1,12

data(i-1,:,:)=asciiread ("som "+i+" .txt",(/no_som+1,nlat*nlon+1/), "float")

end do

do i=1,no_som  ;soms
      do j=0,2  ; levels
   
   geop(i-1,j,:,:)= reshape(data (j,i,1:nlat*nlon),(/nlat,nlon/))
   Uwind(i-1,j,:,:)=reshape(data(j+3,i,1:nlat*nlon),(/nlat,nlon/))
   Vwind(i-1,j,:,:)=reshape(data(j+6,i,1:nlat*nlon),(/nlat,nlon/))
    tempL(i-1,j,:,:)=reshape(data(j+9,i,1:nlat*nlon),(/nlat,nlon/))
  ; print(geop(i-1,j,:,:))
    
   end do
end do

LONG=fspan(30,120,72)
 LATI=fspan(0,55,44)

UwindO=area_hi2lores_Wrap (lon_points,lat_points,Uwind,True,1,LONG,LATI,False)
VwindO=area_hi2lores_Wrap (lon_points,lat_points,Vwind,True,1,LONG,LATI,False)

tempL = tempL -273
geop=geop/9.81

do i=0,2




do j=0,no_som-1
numb=j+1

wks = gsn_open_wks("eps" ,"level_"+levelNames(i)+numb+"hPa")                ; open a ps file

gsn_define_colormap(wks,"GMT_gebco")       ; choose colormap



plot=new((/3,no_som/),graphic)



;==============================================
; create plot
;=============================================
;************************************************
; resource list for first data array
;************************************************
  hres                      = True
  hres@gsnDraw              = False              ; don't draw
  hres@gsnFrame             = False              ; don't advance frame
  hres@cnLineLabelsOn       = True
  hres@cnLineLabelFontHeightF = 0.006
 hres@cnLineColor             = "black"
 
  ;hres@gsnMaximize = True 
 hres@cnLineThicknessF             = 0.08
  hres@gsnRightString = " ";+levelNames(i)
  hres@mpFillOn              = False              ; turn off map fill
 hres@mpOutlineOn           = True               ; turn on map outlines
 ;hres@mpOutlineBoundarySets = "National" 
hres@mpGeophysicalLineColor = "gray" 
 hres@mpGeophysicalLineThicknessF  = 4.5
 hres@cnInfoLabelSide= "Bottom" 
 hres@gsnAddCyclic          = False    ; data already has cyclic point
 hres@cnInfoLabelString="Temperature (C)$CMN$ to $CMX$ by $CIU$ "
  hres@mpMinLonF            =  Wlon            ; select a subregion
  hres@mpMaxLonF            =  Elon
  hres@mpMinLatF            =  Slat
  hres@mpMaxLatF            =  Nlat
  hres@cnLevelSelectionMode = "ManualLevels"
  hres@cnMinLevelValF       = lowValTemp(i)
  hres@cnMaxLevelValF       = highValTemp(i)
  hres@cnLevelSpacingF      = intValTemp(i)
  hres@lbLabelBarOn        = False            ; turn off individual cb's
  
;************************************************
; resource list for third data array
;************************************************
  res3                      = True
  res3@gsnDraw              = False              ; don't draw
  res3@gsnFrame             = False              ; don't advance frame
  ;res3@vcRefAnnoOn          =False
 res3@gsnLeftString = "SOM "+numb
 res3@gsnRightString = ""
 ;res3@vcGlyphStyle="FillArrow" 
 ; res3@stLevelPalette        = "GMT_drywet"
 res3@stLevelPalette        = "nrl_sirkes_nowhite"
  res3@stLineColor           ="skyblue"
   res3@gsnMaximize = True 
 ; res3@vcRefMagnitudeF = refMag(i)
res3@stMonoLineColor       = False
  res3@stLevelSelectionMode  = "ManualLevels"
  
  
  
  res3@stMinLevelValF        =lowValWind(i)
  res3@stMaxLevelValF        =highValWind(i)
  res3@stLevelSpacingF       = intValWind(i)



 res2                      = True
  res2@gsnDraw              = False              ; don't draw
  res2@gsnFrame             = False              ; don't advance frame
  res2@cnLineLabelsOn       = True
  res2@cnLineLabelFontHeightF = 0.006
 res2@cnLineColor             = "black"
res2@gsnContourPosLineDashPattern = 2
 res2@gsnContourNegLineDashPattern = 2
 res2@cnLineThicknessF             = 0.06
 res2@gsnLeftString = ""
 res2@gsnRightString = ""
  res2@cnInfoLabelSide= "Top" 
 res2@cnInfoLabelString=" Geopotential Height (m) (Dash) $CMN$ to $CMX$ by $CIU$"

 
  res2@cnLevelSelectionMode = "ManualLevels"
  res2@cnMinLevelValF       = lowValgeo(i)
  res2@cnMaxLevelValF       = highValgeo(i)
  res2@cnLevelSpacingF      = intValgeo(i)

if (i.eq.5) then
 
fname="SOM"+numb+".nc"

d=addfile(fname,"r")
  slp = d->GeoComp
  slp = smth9_Wrap(slp,0.5, 0.25, False)
   hres@cnSmoothingOn = True 
 hres@cnSmoothingTensionF = 0.001
  ;hres@gsnContourPosLineDashPattern = 2
 ;hres@gsnContourNegLineDashPattern = 2
 hres@cnInfoLabelString="SLP (hPa)$CMN$ to $CMX$ by $CIU$ "
plot(0,j)    = gsn_csm_contour_map(wks,slp,hres)

 plot(1,j)    = gsn_csm_streamline(wks,UwindO(j,i,:,:),VwindO(j,i,:,:),res3)

overlay(plot(0,j),plot(1,j)) 
 draw(plot(0,j)) 

else
 plot(0,j)    = gsn_csm_contour_map(wks,tempL(j,i,:,:),hres)

 plot(1,j)    = gsn_csm_streamline(wks,UwindO(j,i,:,:),VwindO(j,i,:,:),res3)

;if(j.eq.no_som-1) then
;res2@cnInfoLabelOn          =True
;end if

  plot(2,j)    = gsn_csm_contour(wks,geop(j,i,:,:),res2)
  
 overlay(plot(0,j),plot(1,j)) 
 overlay(plot(0,j),plot(2,j)) 
draw(plot(0,j)) 

end if


 
end do






end do
     
  
end 

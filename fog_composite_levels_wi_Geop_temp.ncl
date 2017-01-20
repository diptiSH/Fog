; ==============================================================
; fog_composite.ncl
;
;   - Reading given ascii file for fog dates for which fog was present over more than 10 stations
;   - Based on year open respective data files and get data of geopotential, temperature and wind
;   - make composite
;   - plot
;   - levels 850,700,500 and 200
;   - cases 1.before 96, 2. after 96, 3.difference before - after 4. difference after - before 5. total

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

; ================================>  ; PARAMETERS
  dataDir        = "/home/dipti/Documents/data/"      ; Documents dir
  ncol           = 3                           ; # columns (year, month, day)
  nrow           = 207                          ; # events  
  nsta           = ncol                        ; # stations ( or grid points)
  nlat           = 73                          ; # no of latitudes
  nlon           = 144                         ; # no of longitudes
  ntim_before    = 1800                         ; # no of events
  ntim_after     = 1800                         ; # no of events
  ntim_combine   = 3600                         ; # no of events   
  levelNames     = (/850,700,500,200/)      ; levels
  levels         = (/2,3,5,9/) 
  monData        =(/1,2,12/)
  days           = (/31,28,31/)

do j=0,3
; ================================>   ;read data for composite

GeoVal=new((/ntim_combine,nlat,nlon/),float,-9.96921e+36)
tempVal=new((/ntim_combine,nlat,nlon/),float,-9.96921e+36)
uVal=new((/ntim_combine,nlat,nlon/),float,-9.96921e+36)
vVal=new((/ntim_combine,nlat,nlon/),float,-9.96921e+36)

do i=1976,2015
 do m=0,2
year=i
mon=monData(m)
  do k=1,days(m)
day=k
; =========================================geopotential
dir=dataDir+"geopotential_level/"
fname=dir+"hgt."+year+".nc"
;print(fname)

d=addfile(fname,"r")

time_unit=d->time@units

tim_ind=doubletoint (cd_inv_calendar(year,mon,day,0,0,0,time_unit,0))


GeoVal(i,:,:)=d->hgt({tim_ind},levels(j),:,:)
;print(GeoVal(i,:,:))
;printVarSummary(GeoVal)
delete(d)


; =========================================air_temp
dir=dataDir+"air_temp_ncep_level/"
fname=dir+"air."+year+".nc"
;print(fname)

d=addfile(fname,"r")

time_unit=d->time@units

tim_ind=doubletoint (cd_inv_calendar(year,mon,day,0,0,0,time_unit,0))


tempVal(i,:,:)=d->air({tim_ind},levels(j),:,:)
;printVarSummary(tempVal)
delete(d)

; =========================================uwind
dir=dataDir+"u_wind/"
fname=dir+"uwnd."+year+".nc"
;print(fname)

d=addfile(fname,"r")

time_unit=d->time@units
lev=d->level(2)
tim_ind=doubletoint (cd_inv_calendar(year,mon,day,0,0,0,time_unit,0))


uVal(i,:,:)=d->uwnd({tim_ind},levels(j),:,:)
;printVarSummary(uVal)
delete(d)

; =========================================vwind
dir=dataDir+"v_wind/"
fname=dir+"vwnd."+year+".nc"
;print(fname)

d=addfile(fname,"r")

time_unit=d->time@units

tim_ind=doubletoint (cd_inv_calendar(year,mon,day,0,0,0,time_unit,0))


vVal(i,:,:)=d->vwnd({tim_ind},levels(j),:,:)
;printVarSummary(vVal)
delete(d)


end do

end do

end do
; ==========================================; create composite
GeoComp= dim_avg_n_Wrap(GeoVal, 0)
;print(GeoComp)
TempComp= dim_avg_n_Wrap(tempVal, 0)
;print(TempComp)
UComp= dim_avg_n_Wrap(uVal, 0)
;print(UComp)
VComp= dim_avg_n_Wrap(vVal, 0)
;print(VComp)

GeoComp_before= dim_avg_n_Wrap(GeoVal(0:ntim_before-1,:,:), 0)
print(GeoComp_before)
TempComp_before= dim_avg_n_Wrap(tempVal(0:ntim_before-1,:,:), 0)
UComp_before= dim_avg_n_Wrap(uVal(0:ntim_before-1,:,:), 0)
VComp_before= dim_avg_n_Wrap(vVal(0:ntim_before-1,:,:), 0)

GeoComp_after= dim_avg_n_Wrap(GeoVal(1801: ntim_combine-1,:,:), 0)
TempComp_after= dim_avg_n_Wrap(tempVal(1801:ntim_combine-1,:,:), 0)
UComp_after= dim_avg_n_Wrap(uVal(1801:ntim_combine-1,:,:), 0)
VComp_after= dim_avg_n_Wrap(vVal(1801:ntim_combine-1,:,:), 0)

;===============; just initialize and later get correct values
GeoComp_beforeAfter= GeoComp
TempComp_beforeAfter= TempComp
UComp_beforeAfter= UComp
VComp_beforeAfter= VComp

GeoComp_afterbefore= GeoComp
TempComp_afterbefore= TempComp
UComp_afterbefore= UComp
VComp_afterbefore= VComp


; =========================================== ; plot composite

;***********************************
;Plot data
;************************************

 wks = gsn_open_wks("pdf" ,"AfterandBefore_"+levelNames(j))                ; open a ps file
 wks1 = gsn_open_wks("pdf" ,"1975-2015_"+levelNames(j))                ; open a ps file
 wks2 = gsn_open_wks("pdf" ,"Diff_"+levelNames(j))                ; open a ps file
 ;wks3 = gsn_open_wks("pdf" ,"After-Before_"+levelNames(j))                ; open a ps file
 ;wks4 = gsn_open_wks("pdf" ,"1997-2015_"+levelNames(j))                ; open a ps file
 gsn_define_colormap(wks,"MPL_summer")       ; choose colormap
 gsn_define_colormap(wks1,"MPL_summer")       ; choose colormap
 gsn_define_colormap(wks2,"precip_diff_12lev")       ; choose colormap
; gsn_define_colormap(wks3,"GMT_seis")       ; choose colormap
 ;gsn_define_colormap(wks4,"MPL_summer")       ; choose colormap

;==============================================
; create plot
;=============================================
;************************************************
; resource list for first data array
;************************************************
  hres                          = True
  hres@gsnDraw              = False              ; don't draw
  hres@gsnFrame             = False              ; don't advance frame
  hres@cnFillOn            = True            ; turn on color
  hres@gsnSpreadColors     = True            ; spread out color table
  hres@cnLinesOn             = False    ; turn of contour lines
  hres@gsnAddCyclic          = False    ; data already has cyclic point
  hres@gsnRightString = ""
  ;hres@cnLevelSelectionMode = "ManualLevels"
  ;hres@cnMinLevelValF       = 1160
  ;hres@cnMaxLevelValF       = 1560
  ;hres@cnLevelSpacingF      = 40
  

;************************************************
; resource list for second data array
;************************************************
  res2                      = True
  res2@gsnDraw              = False              ; don't draw
  res2@gsnFrame             = False              ; don't advance frame
  res2@cnLineLabelsOn       = True
  res2@cnLineLabelFontHeightF = 0.006
 res2@cnLineColor             = "Red"
 res2@cnLineThicknessF             = 0.02
 res2@gsnLeftString = ""
 res2@gsnRightString = ""
 ;res2@cnLevelSelectionMode = "ManualLevels"
 ;res2@cnMinLevelValF       = 244
 ;res2@cnMaxLevelValF       = 296
 ;res2@cnLevelSpacingF      = 4
 res2@cnInfoLabelSide= "Top" 
 res2@cnInfoLabelString=" Geopotential Height $CMN$ to $CMX$ by $CIU$ (Red)"


;************************************************
; resource list for third data array
;************************************************
  res3                      = True
  res3@gsnDraw              = False              ; don't draw
  res3@gsnFrame             = False              ; don't advance frame
 res3@gsnLeftString = ""
 res3@gsnRightString = ""
 res3@vcGlyphStyle="FillArrow"
 res3@vcRefMagnitudeF = 20
   
  hres@lbLabelBarOn     = True
  hres@gsnLeftString = "1975-2015"
  res2@cnInfoLabelOn       = True           ; turn on cn info label
  plot    = gsn_csm_contour_map(wks1,TempComp,hres)
  plot1    = gsn_csm_contour(wks1,GeoComp,res2)
  plot2    = gsn_csm_vector(wks1,UComp,VComp,res3)
  overlay(plot,plot1) 
  overlay(plot,plot2)

    draw(plot)

  
  hres@gsnLeftString = "1975-1996"
  hres@lbLabelBarOn     = False
  res2@cnInfoLabelOn       = True           ; turn on cn info label
  res3@vcRefAnnoOn        = False  
  plot_before    = gsn_csm_contour_map(wks,TempComp_before,hres)
  plot1_before    = gsn_csm_contour(wks,GeoComp_before,res2)
  plot2_before    = gsn_csm_vector(wks,UComp_before,VComp_before,res3)
  overlay(plot_before,plot1_before) 
  overlay(plot_before,plot2_before)
 
       ;draw(plot_before)
 
  hres@gsnLeftString = "1997-2015"
  res2@cnInfoLabelOn       = False           ; turn off cn info label
  res3@vcRefAnnoOn        = True  
  plot_after    = gsn_csm_contour_map(wks,TempComp_after,hres)
  plot1_after    = gsn_csm_contour(wks,GeoComp_after,res2)
  plot2_after    = gsn_csm_vector(wks,UComp_after,VComp_after,res3)
  overlay(plot_after,plot1_after) 
  overlay(plot_after,plot2_after)
     
       ;draw(plot_after)

  hres@gsnLeftString = "Before-After 1996"
  hres@lbLabelBarOn     = False
  res2@cnInfoLabelOn       = True           ; turn on cn info label
  res3@vcRefAnnoOn        = False  
  res2@gsnContourNegLineDashPattern  = 2
  ;hres@gsnMaximize          = True
  TempComp_beforeAfter = TempComp_before - TempComp_after
  GeoComp_beforeAfter = GeoComp_before - GeoComp_after
  UComp_beforeAfter = UComp_before - UComp_after
  VComp_beforeAfter = VComp_before - VComp_after
  res2@cnInfoLabelString=" Geopotential Height $CMN$ to $CMX$ by $CIU$ (Red)"
  beforeAfter    = gsn_csm_contour_map(wks2,TempComp_beforeAfter,hres)
  beforeAfter1    = gsn_csm_contour(wks2,GeoComp_beforeAfter,res2)
  beforeAfter2    = gsn_csm_vector(wks2,UComp_beforeAfter,VComp_beforeAfter,res3)
  overlay(beforeAfter,beforeAfter1) 
  overlay(beforeAfter,beforeAfter2)
     
      ;draw(beforeAfter)  
  res2@cnInfoLabelOn       = False           ; turn off cn info label
  hres@gsnLeftString = "After-Before 1996"
  res3@vcRefAnnoOn        = True
  TempComp_afterbefore = TempComp_after - TempComp_before
  GeoComp_afterbefore = GeoComp_after - GeoComp_before
  UComp_afterbefore = UComp_after - UComp_before
  VComp_afterbefore = VComp_after - VComp_before
  res2@cnInfoLabelString=" Geopotential Height $CMN$ to $CMX$ by $CIU$ (Red)"
  afterBefore    = gsn_csm_contour_map(wks2,TempComp_afterbefore,hres)
  afterBefore1    = gsn_csm_contour(wks2,GeoComp_afterbefore,res2)
  afterBefore2    = gsn_csm_vector(wks2,UComp_afterbefore,VComp_afterbefore,res3)
  overlay(afterBefore,afterBefore1) 
  overlay(afterBefore,afterBefore2)
  
     ;draw(afterBefore)

;************************************************
; create panel
;************************************************
  resP                     = True                ; modify the panel plot
                                                 ; new resource added in NCL V6.4.0
  resP@gsnPanelMainString = "Fog Composite"
  resP@gsnPanelRowSpec = True                       ; use this for NCL V6.3.0 and earlier
  resP@txString           = "Fog Composite At "+levelNames(j)+" hPa"

  resP@gsnPanelLabelBar    = True                ; add common colorbar
  resP@lbLabelFontHeightF  = 0.007               ; make labels smaller
  resP@gsnMaximize    = True                ; maximize plots
  gsn_panel(wks2,(/beforeAfter,afterBefore/),(/1,1/),resP)               ; now draw as one plot
  gsn_panel(wks,(/plot_before,plot_after/),(/1,1/),resP)               ; now draw as one plot
  
     
end do    

end



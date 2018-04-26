begin

;****************Add files

Ifile=addfile("/home/user/Documents/Data/ERA-1.5/ERADAILY-1.5deg-500-700-850-925-950-1000hPa-Dec-Jan-1979-2016.nc","r")
;file700=addfile("/home/user/Documents/Data/ERA-1.5/ERADAILY-1.5deg-700hPa-Dec-Jan-1979-2016.nc","r")


;u=Ifile->u

;printVarSummary(u)

;exit

;********************Add Variables

u1000=Ifile->u(:,{1000},{20:35},{70:95})
v1000=Ifile->v(:,{1000},{20:35},{70:95})

u700=Ifile->u(:,{700},{20:35},{70:95})
v700=Ifile->v(:,{700},{20:35},{70:95})

printVarSummary(u1000)
printVarSummary(u700)

delete(Ifile)
;delete(file700)

;*********************Calculate wind speed at lowest level

speed1000=sqrt((u1000)^2+(u1000)^2)

;********************Shear Calculations

ushear=u700-u1000
vshear=v700-v1000

shearSpeed=sqrt((ushear)^2+(vshear)^2)


;********************** Copy variable metadata
copy_VarMeta(u1000,shearSpeed)
copy_VarMeta(u1000,speed1000)

printVarSummary(shearSpeed)
printVarSummary(speed1000)

;*********************Elevation file
fmask=addfile("/home/user/Documents/Data/mask/ERA-1.5deg-elevation.nc","r")
data=fmask->z
elev=data(:,{20:35},{70:95})
printVarSummary(elev)
delete(fmask)

;************************* mask region more than 500 m height
maskVar=where(elev.lt.500,1,0)
copy_VarMeta(elev,maskVar)
printVarSummary(maskVar)

;********************** avg values for region less than 500 m

maskVar_conf=conform(shearSpeed,maskVar(0,:,:),(/1,2/))
printVarSummary(maskVar_conf)

masked_shearSpeed= mask(shearSpeed,(maskVar_conf.lt.1),False)
masked_speed1000= mask(speed1000,(maskVar_conf.lt.1),False)

printVarSummary(masked_speed1000)

;*************************Area Averaged value calculation
AAvg_speed1000=dim_avg_n_Wrap(masked_speed1000,(/1,2/))
AAvg_shearSpeed=dim_avg_n_Wrap(masked_shearSpeed,(/1,2/))

printVarSummary(AAvg_shearSpeed)





fogdata   = asciiread ("/home/user/Documents/work/AO_analysis/fog_stations",2139, "integer")
sheardata   = AAvg_shearSpeed(0:2138)
lowWinddata   = AAvg_speed1000(0:2138)

;0=Black
;1-5 = Green
; 6-10 = Blue
;11-15 = Brown
;16-23=red

col=new(2139,"string")
mark=new(2139,"integer")
do i=0,2138

if(fogdata(i).lt.1)then
col(i)="Black"
mark(i)=4     
 else if(fogdata(i).gt.0  .and. fogdata(i).lt.6)then
        col(i)="White"
        mark(i)=6
        else if(fogdata(i).gt.5  .and. fogdata(i).lt.11)then
              col(i)="White"
              mark(i)=8
              else if(fogdata(i).gt.10  .and. fogdata(i).lt.16)then
              col(i)="Brown"
                  mark(i)=2
                   else
              col(i)="Red"
              mark(i)=5
                   end if
             end if
      end if
end if


end do


print(fogdata)

;open png file

wks = gsn_open_wks("eps","Shear_vs_lowWind_noStations_20:35N70:95E")


;some plot resources

res = True
;res@gsnMaximize=True
res@gsnDraw  = False
res@gsnFrame  = False

;marker resources

res@xyMarkLineMode="Markers"
;res@xyMarkerThicknessF=2.5
res@xyMarkerSizeF=0.004
res@xyMonoMarkerColor=False
res@xyMarkerColors=col
res@xyMarkers=mark



;res@gsnRefLine=0.0


print(col)
;Title res

res@tiXAxisString="Wind Shear between 1000hPa and 700hPa"
res@tiYAxisString="Wind speed at level 1000hPa"


plot=gsn_csm_xy(wks,transpose((/sheardata,sheardata/)),transpose((/lowWinddata,lowWinddata/)),res)

;line resources
polyres=True
polyres@gsnLineThicknessF=3.0

gsn_polyline(wks,plot,(/-8.0,6.0/),(/0.0,0.0/),polyres)
gsn_polyline(wks,plot,(/0.0,0.0/),(/-2.0,3.0/),polyres)

 gsres               = True

colors=(/"black","green","blue","brown","red"/)
;colors=(/"black","black","black","black","black"/)
markers=(/4,6,8,2,5/)
labels=(/"=0","1-5","6-10","11-15",">15"/)
txres               = True
  txres@txFontHeightF = 0.02

 xleg = (/0.07,0.07,0.32,0.32,0.57,0.57/)   ; Location of
  xtxt = (/0.16,0.16,0.41,0.41,0.66,0.66/)   ; legend markers
  yleg = (/0.08,0.05,0.08,0.05,0.08,0.05/)   ; and text
  ytxt = (/0.08,0.05,0.08,0.05,0.08,0.05/)  ; strings.

do i=0,4
;
; Add marker and text for the legend.
      gsres@gsMarkerColor      = colors(i)
      gsres@gsMarkerIndex   = markers(i)
      gsres@gsMarkerSizeF          =  0.004
      gsn_polymarker_ndc(wks,          xleg(i),yleg(i),gsres)
      gsn_text_ndc      (wks,labels(i),xtxt(i),ytxt(i),txres)

end do



draw(plot)
frame(wks)

end


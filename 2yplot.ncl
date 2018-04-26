begin

fogdata   = asciiread ("fog_stations",105, "integer")
AOdata   = asciiread ("AO",105, "float")
EUdata   = asciiread ("EU",105, "float")

;0=Black
;1-5 = Green
; 6-10 = Blue
;11-15 = Brown
;16-23=red

col=new(105,"string")
mark=new(105,"integer")
do i=0,104

if(fogdata(i).lt.1)then
col(i)="Black"
mark(i)=4     
 else if(fogdata(i).gt.0  .and. fogdata(i).lt.6)then
        col(i)="Green"
        mark(i)=6
        else if(fogdata(i).gt.5  .and. fogdata(i).lt.10)then
              col(i)="Blue"
              mark(i)=8
              else if(fogdata(i).ge.10  .and. fogdata(i).lt.21)then
              col(i)="Blue"
                  mark(i)=4
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

wks = gsn_open_wks("eps","AO_vs_EU_noStations")


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

res@tiXAxisString="AO index"
res@tiYAxisString="EU index"


plot=gsn_csm_xy(wks,transpose((/AOdata,AOdata/)),transpose((/EUdata,EUdata/)),res)

;line resources
polyres=True
polyres@gsnLineThicknessF=3.0

gsn_polyline(wks,plot,(/-8.0,6.0/),(/0.0,0.0/),polyres)
gsn_polyline(wks,plot,(/0.0,0.0/),(/-2.0,3.0/),polyres)

 gsres               = True

colors=(/"blue","red"/)
;colors=(/"black","black","black","black","black"/)
markers=(/4,5/)
labels=(/"10-20",">20"/)
txres               = True
  txres@txFontHeightF = 0.02

 xleg = (/0.07,0.07,0.32,0.32,0.57,0.57/)   ; Location of
  xtxt = (/0.16,0.16,0.41,0.41,0.66,0.66/)   ; legend markers
  yleg = (/0.08,0.05,0.08,0.05,0.08,0.05/)   ; and text
  ytxt = (/0.08,0.05,0.08,0.05,0.08,0.05/)  ; strings.

do i=0,1
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


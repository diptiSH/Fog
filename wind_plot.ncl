begin

ymin = 1.            ; min height to be plotted
  ymax = 1000.            ; max height to be plotted

f=addfile("/home/iitm/fog-files-d/Fog/AnomERA3D-00UTC-1.5deg_Fog.nc","r")

u=f->u(:,:,{15:35},{80})


printVarSummary(u)

ntimes=dimsizes(u(:,0,0))

print(ntimes)



v=f->v(:,:,{15:35},{80})


printVarSummary(v)


u_mean=dim_avg_n_Wrap(u,2)

printVarSummary(u_mean)

v_mean=dim_avg_n_Wrap(v,2)

printVarSummary(v_mean)


wspd=u_mean

wspd=(/sqrt(u_mean^2+v_mean^2)/)

wks = gsn_open_wks("png","barb")     ; send graphics to PNG file
  gsn_define_colormap(wks,"WhBlGrYeRe")


res = True
        res@gsnDraw = False
        res@gsnFrame = False
        res@vpWidthF = 0.8
        res@vpHeightF = 0.5
        res@vpXF = 0.1
        res@vpYF = 0.9
        res@trYMinF = ymin
        res@trYMaxF = ymax
        res@tiMainString = "Wind Profile"
        xc = (/-0.5,ntimes-0.5,ntimes-0.5,-0.5,-0.5/)
        yc = (/ymin,ymin,ymax,ymax,ymin/)
     
        plot = gsn_csm_xy(wks,xc,yc,res)                          ; draw blank xy plot by outlining min/max of X/Y axes
        contours = ispan(5,65,5)*1.                               ; set contours used to define barb color 
        colors = (/20,30,40,45,50,55,60,65,70,75,80,85,90,95/)    ; set colors



     wmsetp ("wdf", 1)                 ; meteorological dir
     wmsetp("wbs",0.025)
     wmsetp ("blw",2.0)    ; increase line thickness of wind barbs
     do hh = 0,dimsizes(wspd(0,:))-1
        wmsetp("col", GetFillColorIndex(contours,colors,wspd(0,hh)))   ; assign barb color based on wind speed value 
        ;if (z(hh).lt.ymax.and.z(hh).ge.ymin) then
           wmbarb(wks, 1.,tofloat(hh), tofloat(u_mean(0,hh)),tofloat( v_mean(0,hh)))                   ; draw wind barb
        ;end if
     end do

  
  draw(plot)                        ; draw the plot
  frame(wks)                        ; advance the frame

end


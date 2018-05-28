begin

ymin = 1.            ; min height to be plotted
  ymax = 1000.            ; max height to be plotted

f=addfile("/home/iitm/fog-files-d/NoFog/AnomERA3D-00UTC-1.5deg_NoFog.nc","r")

u=f->u(:,:,{15:45},{80})


printVarSummary(u)

ntimes=dimsizes(u(:,0,0))

print(ntimes)



v=f->v(:,:,{15:45},{80})


printVarSummary(v)







wspd=u

wspd=(/sqrt(u^2+v^2)/)

printVarSummary(wspd)

	
;===========================================================
  wks = gsn_open_wks("eps","NoFogAnomwind_profilebarb")    ; send graphics to PNG file
  gsn_define_colormap(wks,"WhBlGrYeRe")

  res                = True                    
  res@gsnDraw        = False          ; do not draw
  res@gsnFrame       = False          ; do not advance the frame
  res@tiMainString   = "Wind Profile" ; add title
  res@vcGlyphStyle   = "WindBarb";"LineArrow";"FillArrow"; "WindBarb"     ; select wind barbs 
  res@vcRefLengthF   = 0.045          ; define length of vec ref
  res@vcRefAnnoOn    =  False        ; turn off ref wind barb
  res@trYReverse     = True           ; reverse the Y-axis
  res@vcMonoWindBarbColor     = False            ; color barbs by scalar
  res@lbOrientation           = "vertical"       ; vertical labelbar
  res@vcLevelSelectionMode    = "ExplicitLevels" ; will explicitly set the levels
  res@vcWindBarbLineThicknessF= 1.5              ; set the wind barb thickness
  res@vcLevels                = (/0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5/);ispan(1,10,1)    ; set the levels 
  res@vcLevelColors           = (/20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95/)   ; set the colors associated with the wind speed
  
  res@vcMapDirection = False			; needed to disassociate the map from the vectors
  res@gsnAddCyclic = False              ; data is not cyclic
  res@gsnLeftString = ""
 ; plot = gsn_csm_vector_scalar(wks,u_mean(level|:,time|0:10),v_mean(level|:,time|0:10),wspd(level|:,time|0:10),res)
plot = gsn_csm_vector_scalar(wks,u(level|:,latitude|:,time|0),v(level|:,latitude|:,time|0),wspd(level|:,latitude|:,time|0),res)

  getvalues plot                        ; get the X/Y axis min/max for use in the loglin plot
    "trXMinF"    : trxmin
    "trXMaxF"    : trxmax
    "trYMinF"    : trymin
    "trYMaxF"    : trymax
  end getvalues

  loglin = create "logling" logLinPlotClass wks     ; draw a loglin plot, with expanded X/Y axis
    "trXMinF"        : trxmin-1
    "trXMaxF"        : trxmax+1
    "trYMinF"        : trymin-40
    "trYMaxF"        : trymax+50
    "trYReverse"     : True
    "vpXF"           : .15            ; set the X-axis NDC starting point
    "vpYF"           : .8             ; set the Y-axis NDC starting point
    "vpWidthF"       : .7             ; set the width of the plot in NDC units
    "vpHeightF"      : .45            ; set the height of the plot in NDC units
  end create
  overlay(loglin,plot)              ; overlay plot with the loglin plot
  ;  pres = True
 ; maximize_output(wks,pres)
draw(loglin)                      ; draw the plot
  frame(wks)                        ; advance the frame

end


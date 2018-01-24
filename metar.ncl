begin

fileName="AMRITSAR.txt"
;---Read in file as array of strings so we can parse each line
  lines = asciiread(fileName,-1,"string")

;print(lines)

  delim = ","

printVarSummary(lines)

 StationNames  =           str_get_field(lines,1,delim)
 years         =  tointeger(str_get_field(lines,3,delim))
 months        =  tointeger(str_get_field(lines,4,delim))
 dates         =  tointeger(str_get_field(lines,5,delim))
 hrs           =  tointeger(str_get_field(lines,6,delim))
 wind          =  tofloat(str_get_field(lines,8,delim))
 visibilities  =  tointeger(str_get_field(lines,10,delim))
  temp         =  tofloat(str_get_field(lines,25,delim))
  ;wTemp         =  tofloat(str_get_field(lines,26,delim))
 dtemp       =  tofloat(str_get_field(lines,27,delim))

printVarSummary(years)
print(years(0))




 Temp        =  new((/17,2,31,8/),"float")
 Dtemp         =  new((/17,2,31,8/),"float")
 Rh           =  new((/17,2,31,8/),"float")
 Wind           =  new((/17,2,31,8/),"float")
 Visibilities  =  new((/17,2,31,8/),"integer")
ys  =  new((/17,2,31,8/),"integer")
ms  =  new((/17,2,31,8/),"integer")
ds  =  new((/17,2,31,8/),"integer")
hs  =  new((/17,2,31,8/),"integer")

cnt=0
monthlycount=new((/17,2/),"integer")
monthlycount=0
 alcnt=0
do yr=2001,2017
   print(yr)
    do mn=1,2
       if (mn.eq.2) then
          mon=12
       else
          mon=1
       end if
           dailycount=0
           do date=1,31
              do hr1=0,7
                    hr=hr1*3
                do i=0,dimsizes(lines)-1
                      ;print(years(i))
                      ;print(months(i))
                      ;print(dates(i))
                
                     if(years(i).eq.yr .and. months(i).eq.mon .and. dates(i).eq.date .and. hrs(i).eq.hr) then
                       ;  print(cnt)
                       ; if(.not.ismissing(temp(i)) .and. .not.ismissing(dtemp(i)) .and. .not.ismissing(wind(i)) .and. .not.ismissing(visibilities(i)) .and. .not.ismissing(precip(i)))
                    ; if(.not.ismissing(temp(i)) .and. .not.ismissing(dtemp(i)) .and. .not.ismissing(wind(i)) .and. .not.ismissing(visibilities(i)))
                      if(.not.ismissing(visibilities(i)))
                        if(.not.ismissing(temp(i))) then
                       Temp(yr-2001,mn-1,date-1,hr1)=temp(i)
                       end if
                       
                       if(.not.ismissing(dtemp(i))) then
                       Dtemp(yr-2001,mn-1,date-1,hr1)=dtemp(i)
                       end if
                  
                      ; if(.not.ismissing(temp(i)) .and. .not.ismissing(dtemp(i))) then
                      ; Rh(yr-2001,mn-1,date-1,hr1)=
                      ; end if
                      
                       if(.not.ismissing(wind(i))) then
                       Wind(yr-2001,mn-1,date-1,hr1)=wind(i)
                       end if
                      
                      
                       if(.not.ismissing(visibilities(i))) then
                       Visibilities(yr-2001,mn-1,date-1,hr1)=visibilities(i)
   
                           cnt=cnt+1                                      
                         end if   
                        end if
                     end if
                       
                      ys(yr-2001,mn-1,date-1,hr1)=yr
                      ms(yr-2001,mn-1,date-1,hr1)=mn 
                      ds(yr-2001,mn-1,date-1,hr1)=date
                      hs(yr-2001,mn-1,date-1,hr1)=hr
                      alcnt=alcnt+1
                    end do
                 end do
;;;;;;;;;;;;;;;;;;;;;;;;;;; get daily count for non missing obs        ;;;;;;;;
                 dailycount=num(Visibilities(yr-2001,mn-1,date-1,:))
                 if(dailycount.gt.7) then
                   monthlycount(yr-2001,mn-1)=monthlycount(yr-2001,mn-1)+1
                end if
           end do
     end do
end do

print(cnt)
print(alcnt)
;print(monthlycount)

;asciiwrite("metarData.txt",monthlycount)


Otemp=ndtooned(Temp)       
 Odtemp=ndtooned(Dtemp)      
; Orh=ndtooned(Rh)         
 Owind=ndtooned(Wind)       
 Ovisibilities=ndtooned(Visibilities)
Oys=ndtooned(ys)  
Oms=ndtooned(ms) 
Ods=ndtooned(ds) 
Ohs=ndtooned(hs) 

;asciiwrite("testTemp.txt",Otemp)
;asciiwrite("testvis.txt",Ovisibilities)
;asciiwrite("testys.txt",ys)

cnt=0
do i=3,dimsizes(Otemp)-2  ;Starting at 3 so that last 3 obs are available and ending at second last to decide next obs also was fog

;chk for start of fog
 if(.not.ismissing(Ovisibilities(i)).and..not.ismissing(Ovisibilities(i-1)).and. .not.ismissing(Ovisibilities(i+1)))then
  if(Ovisibilities(i).lt.94 .and. Ovisibilities(i-1).ge.94 .and. Ovisibilities(i+1).lt.94 ) then
   cnt=cnt+1
  end if
 end if
end do



;get foggy events subsets

fogEvents=new(cnt,"string")
fogDuration=new(cnt,"integer")
fogEnd=new(cnt,"string")
fogDescription=new(cnt,"string")


cnt=0
do i=3,dimsizes(Otemp)-2  ;Starting at 3 so that last 3 obs are available and ending at second last to decide next obs also was fog
 coolingAtOnset="No"
 cooling6hto3h="No"
;chk for start of fog
 if(.not.ismissing(Ovisibilities(i)).and..not.ismissing(Ovisibilities(i-1)).and. .not.ismissing(Ovisibilities(i+1)))then

; fog event two consecutive events show visibility lt 1 km and pevious one was more than 1 km

  if(Ovisibilities(i).lt.94 .and. Ovisibilities(i-1).ge.94 .and. Ovisibilities(i+1).lt.94 ) then  
    fogEvents(cnt)=sprinti("%0.4i", Oys(i))+"-"+sprinti("%0.2i", Oms(i))+"-"+sprinti("%0.2i", Ods(i))+":"+sprinti("%0.4i", Ohs(i))

;;decide fog end
        dur=1
        j=i      
        
        do while(.not.ismissing(Ovisibilities(j+1)).and. Ovisibilities(j+1).lt.94)
         dur=dur+1
         fogEnd(cnt)=sprinti("%0.4i", Oys(j))+"-"+sprinti("%0.2i", Oms(j))+"-"+sprinti("%0.2i", Ods(j))+":"+sprinti("%0.4i", Ohs(j))
         j=j+1
        end do
        fogDuration(cnt)=dur

;;;;; decide cooling obs previous and 2nd last obs
          if(.not.ismissing(Otemp(i)).and..not.ismissing(Otemp(i-1)))then
              if(Otemp(i).lt.Otemp(i-1))then
               coolingAtOnset="yes"
              end if
             else
             coolingAtOnset="missingObs"
          end if
         
          if(.not.ismissing(Otemp(i-1)).and..not.ismissing(Otemp(i-2)))then
              if(Otemp(i-1).lt.Otemp(i-2))then
               cooling6hto3h="yes"
              end if
             else
             cooling6hto3h="missingObs"
          end if    

         fogDescription(cnt)=fogEvents(cnt)+","+fogEnd(cnt)+","+sprintf("%5.2f", Otemp(i))+","+sprintf("%5.2f", Odtemp(i))+","+sprintf("%5.2f", Owind(i))+","+coolingAtOnset+","+cooling6hto3h
         

   cnt=cnt+1
  end if
 end if
end do



;print(fogEvents)
;print(fogDuration)
;print(fogEnd)

asciiwrite("FogEvents.txt",fogDescription)
end

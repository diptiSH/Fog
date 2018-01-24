begin

fileName="DELHI.txt"
;---Read in file as array of strings so we can parse each line
  lines = asciiread(fileName,-1,"string")

cloudFile=addfile("/home/user/Documents/Data/ceres_cloud_data/Delhi_Dec_Jan_CERES_SYN1deg-1H_Terra-Aqua-MODIS_Ed4A_Subset_20001201-20170131.nc","r")
TcCover=cloudFile->cldarea_total_1h
TcBase=cloudFile->cldpress_base_total_1h
LcBase=cloudFile->cldpress_base_low_1h
LcCover=cloudFile->cldarea_low_1h
time=cloudFile->time

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
TcCover1  =  new((/17,2,31,8/),"float")
TcCover2  =  new((/17,2,31,8/),"float")
TcBase1  =  new((/17,2,31,8/),"float")
TcBase2  =  new((/17,2,31,8/),"float")
LcCover1  =  new((/17,2,31,8/),"float")
LcCover2  =  new((/17,2,31,8/),"float")
LcBase1  =  new((/17,2,31,8/),"float")
LcBase2  =  new((/17,2,31,8/),"float")



cnt=0
monthlycount=new((/17,2/),"integer")
monthlycount=0
 alcnt=0
do yr=2001,2017
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
                   if(years(i).eq.yr .and. months(i).eq.mon .and. dates(i).eq.date .and. hrs(i).eq.hr) then
                      if(.not.ismissing(visibilities(i)))
                       if(.not.ismissing(temp(i))) then
                       Temp(yr-2001,mn-1,date-1,hr1)=temp(i)
                       end if
                       
                       if(.not.ismissing(dtemp(i))) then
                       Dtemp(yr-2001,mn-1,date-1,hr1)=dtemp(i)
                       end if
                       
                       if(.not.ismissing(dtemp(i)) .and. .not.ismissing(temp(i))) then
                        Rh(yr-2001,mn-1,date-1,hr1)=100*(exp((17.625*dtemp(i))/(243.04+dtemp(i)))/exp((17.625*temp(i))/(243.04+temp(i))))
                       end if
                  
                       if(.not.ismissing(wind(i))) then
                       Wind(yr-2001,mn-1,date-1,hr1)=wind(i)
                       end if
                      
                      
                       if(.not.ismissing(visibilities(i))) then
                       Visibilities(yr-2001,mn-1,date-1,hr1)=visibilities(i)
                       cnt=cnt+1                                      
                       end if
                      end if
                   end if
                end do
                    if(yr.eq.2017 .and. mon.eq.12 ) then 
                    else                                
                            if(hr.eq.0)then
                              if(date.ne.1) then
                                 t1=(cd_inv_calendar(yr,mon,date-1,23,30,00,time@units,0))
                                 TcCover1(yr-2001,mn-1,date-1,hr1)  =  TcCover({t1},0,0)
                                 TcBase1(yr-2001,mn-1,date-1,hr1)  =  TcBase({t1},0,0)
                                 LcCover1(yr-2001,mn-1,date-1,hr1)  =  LcCover({t1},0,0)
                                 LcBase1(yr-2001,mn-1,date-1,hr1)  =  LcBase({t1},0,0)
                              else
                                 if(mon.eq.12)then
                                 else
                                   if(yr.ne.2001)then
                                    t1=(cd_inv_calendar(yr-1,12,31,23,30,00,time@units,0))
                                    TcCover1(yr-2001,mn-1,date-1,hr1)  =  TcCover({t1},0,0)
                                    TcBase1(yr-2001,mn-1,date-1,hr1)  =  TcBase({t1},0,0)
                                    LcCover1(yr-2001,mn-1,date-1,hr1)  =  LcCover({t1},0,0)
                                    LcBase1(yr-2001,mn-1,date-1,hr1)  =  LcBase({t1},0,0)
                                   end if
                                 end if
                              end if
                            else
                              t1=(cd_inv_calendar(yr,mon,date,hr-1,30,00,time@units,0))
                              TcCover1(yr-2001,mn-1,date-1,hr1)  =  TcCover({t1},0,0)
                              TcBase1(yr-2001,mn-1,date-1,hr1)  =  TcBase({t1},0,0)
                              LcCover1(yr-2001,mn-1,date-1,hr1)  =  LcCover({t1},0,0)
                              LcBase1(yr-2001,mn-1,date-1,hr1)  =  LcBase({t1},0,0)
                            end if
                              t2=(cd_inv_calendar(yr,mon,date,hr,30,00,time@units,0))
                              TcCover2(yr-2001,mn-1,date-1,hr1)  =  TcCover({t2},0,0)
                              TcBase2(yr-2001,mn-1,date-1,hr1)  =  TcBase({t2},0,0)
                              LcCover2(yr-2001,mn-1,date-1,hr1)  =  LcCover({t2},0,0)
                              LcBase2 (yr-2001,mn-1,date-1,hr1) =  TcBase({t2},0,0)
                    end if                             
                          ys(yr-2001,mn-1,date-1,hr1)=yr
                          ms(yr-2001,mn-1,date-1,hr1)=mn 
                          ds(yr-2001,mn-1,date-1,hr1)=date
                          hs(yr-2001,mn-1,date-1,hr1)=hr
          end do
      end do
 end do
end do


Otemp=ndtooned(Temp)       
Odtemp=ndtooned(Dtemp)      
Orh=ndtooned(Rh)         
Owind=ndtooned(Wind)       
Ovisibilities=ndtooned(Visibilities)
Oys=ndtooned(ys)  
Oms=ndtooned(ms) 
Ods=ndtooned(ds) 
Ohs=ndtooned(hs) 
OTcCover1  =  ndtooned(TcCover1)
OTcCover2  =  ndtooned(TcCover2)
OTcBase1  =  ndtooned(TcBase1)
OTcBase2  =  ndtooned(TcBase2)
OLcCover1  =  ndtooned(LcCover1)
OLcCover2  =  ndtooned(LcCover2)
OLcBase1  =  ndtooned(LcBase1)
OLcBase2  =  ndtooned(LcBase2)


;get foggy events subsets

fogStart=new(cnt,"string")
fogDuration=new(cnt,"integer")
fogEnd=new(cnt,"string")
fogDescription=new(cnt,"string")


cnt=0
do i=3,dimsizes(Ovisibilities)-2  ;Starting at 3 so that last 3 obs are available and ending at second last to decide next obs also was fog
 coolingAtOnset="No"
 cooling6hto3h="No"
 TcLowering="No"
 LcLowering="No"
 TcLowering1="No"
 LcLowering1="No"
 ;chk for start of fog
 if(.not.ismissing(Ovisibilities(i)).and..not.ismissing(Ovisibilities(i-1)).and. .not.ismissing(Ovisibilities(i+1)))then
 ; fog event two consecutive events show visibility lt 1 km and pevious one was more than 1 km
    if(Ovisibilities(i).lt.94 .and. Ovisibilities(i-1).ge.94 .and. Ovisibilities(i+1).lt.94 ) then  
       fogStart(cnt)=sprinti("%0.4i", Oys(i))+"-"+sprinti("%0.2i", Oms(i))+"-"+sprinti("%0.2i", Ods(i))+":"+sprinti("%0.4i", Ohs(i))
    
       ;;decide fog end
       dur=1
       j=i       
       do while(.not.ismissing(Ovisibilities(j+1)) .and. Ovisibilities(j+1).lt.94)
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


;;;;; decide cloud base lowering
       if(.not.ismissing(OTcBase1(i)).and..not.ismissing(OTcBase2(i)))then
          if(OTcBase1(i).lt.OTcBase2(i))then
             TcLowering="yes"
          end if
       else
          TcLowering="missingObs"
       end if
         
       if(.not.ismissing(OLcBase1(i)).and..not.ismissing(OLcBase2(i)))then
          if(OLcBase1(i).lt.OLcBase2(i))then
             LcLowering="yes"
          end if
        else
          LcLowering="missingObs"
        end if



;;;;; decide cloud base one obs before lowering
       if(.not.ismissing(OTcBase1(i-1)).and..not.ismissing(OTcBase2(i-1)))then
          if(OTcBase1(i-1).lt.OTcBase2(i-1))then
             TcLowering1="yes"
          end if
       else
          TcLowering1="missingObs"
       end if
         
       if(.not.ismissing(OLcBase1(i-1)).and..not.ismissing(OLcBase2(i-1)))then
          if(OLcBase1(i-1).lt.OLcBase2(i-1))then
             LcLowering1="yes"
          end if
        else
          LcLowering1="missingObs"
        end if


       fogDescription(cnt)=fogStart(cnt)+","+fogEnd(cnt)+","+fogDuration(cnt)+","+sprintf("%5.2f", Otemp(i))+","+sprintf("%5.2f", Odtemp(i))+","+sprintf("%5.2f", Owind(i))+","+coolingAtOnset+","+cooling6hto3h+","+sprintf("%5.2f", Orh(i))+","+sprintf("%5.2f", OTcCover1(i))+","+sprintf("%5.2f",OLcCover1(i))+","+sprintf("%5.2f",OTcBase1(i))+","+sprintf("%5.2f",OLcBase1(i))+","+sprintf("%5.2f", OTcCover1(i-1))+","+sprintf("%5.2f",OLcCover1(i-1))+","+sprintf("%5.2f",OTcBase1(i-1))+","+sprintf("%5.2f",OLcBase1(i-1))+","+TcLowering+","+LcLowering+","+TcLowering1+","+LcLowering1
        cnt=cnt+1
    end if
 end if
end do



;print(fogStart)
;print(fogDuration)
;print(fogEnd)

asciiwrite("FogEventsDelhi.txt",fogDescription)








   end

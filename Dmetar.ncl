begin

fileName="/home/user/Documents/Data/metar_hourly/delhi.txt"
;---Read in file as array of strings so we can parse each line
  lines = asciiread(fileName,-1,"string")
;print(lines)
  delim = ","
;printVarSummary(lines)
;print(lines)
 StationNames  =           str_get_field(lines,1,delim)
 dateTime         =  (str_get_field(lines,2,delim))
 temp        =  tofloat(str_get_field(lines,3,delim))
 dtemp         =  tofloat(str_get_field(lines,4,delim))
 rh           =  tofloat(str_get_field(lines,5,delim))
 wind           =  tofloat(str_get_field(lines,7,delim))
 widDirection = tointeger(str_get_field(lines,6,delim))
 visibilities  =  tofloat(str_get_field(lines,11,delim))
  precip         =  tofloat(str_get_field(lines,8,delim))
  wx         =  (str_get_field(lines,21,delim))
 ;print(dateTime)
delim="-"
years=tointeger(str_get_field(dateTime,1,delim))
months=tointeger(str_get_field(dateTime,2,delim))
dates=tointeger(str_get_field(dateTime,3,delim))
delim=" "
time=(str_get_field(dateTime,2,delim))
delim=":"
time1=tointeger(str_get_field(time,1,delim))
time2=tointeger(str_get_field(time,2,delim))
;print(temp)

printVarSummary(years)
print(years(0))


cnt=0
 
do yr=2001,2017
   print(yr)
    do mn=1,2
       if (mn.eq.2) then
          mon=12
       else
          mon=1
       end if
           do date=1,31
                do i=0,dimsizes(lines)-1
                      print(years(i))
                      print(months(i))
                      print(dates(i))
                      print(time(i))
                     if(years(i).eq.yr .and. months(i).eq.mon .and. dates(i).eq.date ) then
                       ;  print(cnt)
                         cnt=cnt+1
                     end if
                 end do
           end do
     end do
end do

print(cnt)

lines2=new(cnt,"string")


cnt=0
 
do yr=2001,2017
   print(yr)
    do mn=1,2
       if (mn.eq.2) then
          mon=12
       else
          mon=1
       end if
           do date=1,31
                do i=0,dimsizes(lines)-1
                      ;print(years(i))
                      ;print(months(i))
                      ;print(dates(i))
                     if(years(i).eq.yr .and. months(i).eq.mon .and. dates(i).eq.date ) then
                       ;  print(cnt)
                          lines2(cnt)=lines(i)
                         cnt=cnt+1
                     end if
                 end do
           end do
     end do
end do

asciiwrite("dec_Jan_delhi_metar.txt",lines2)

end

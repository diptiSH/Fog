begin

fileName="/home/user/Documents/Data/MetarData/463_12.csv"
;---Read in file as array of strings so we can parse each line
  lines = asciiread(fileName,-1,"string")
    lines = str_sub_str(lines,",,",",lines@_FillValue,")
     lines = str_sub_str(lines,",,",",lines@_FillValue,")
     lines = str_sub_str(lines,",,",",lines@_FillValue,")
      lines = str_sub_str(lines,",,",",lines@_FillValue,")
       lines = str_sub_str(lines,",,",",lines@_FillValue,")
        lines = str_sub_str(lines,",,",",lines@_FillValue,")

  delim = ","

printVarSummary(lines)

 StationNames  =           str_get_field(lines,1,delim)
 years         =  tointeger(str_get_field(lines,3,delim))
 months        =  tointeger(str_get_field(lines,4,delim))
 dates         =  tointeger(str_get_field(lines,5,delim))
 hrs           =  tointeger(str_get_field(lines,6,delim))
 visibilities  =  tointeger(str_get_field(lines,10,delim))
  dTemp         =  tofloat(str_get_field(lines,25,delim))
  wTemp         =  tofloat(str_get_field(lines,26,delim))
 dewTemp       =  tofloat(str_get_field(lines,27,delim))
  
 wmisNo=num(ismissing(wTemp))
 dmisNo=num(ismissing(dTemp))
 dewmisNo=num(ismissing(dewTemp))
 ;print(dewTemp)


numVaranasi=0
numLucknow=0
numDelhi=0
numPatna=0
numChandigarh=0
numAmritsar=0

print(dimsizes(years)-1)

do i=0,dimsizes(lines)-1

if(isStrSubset(StationNames(i),"AMRITSAR") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
numAmritsar=numAmritsar+1
end if

if(isStrSubset(StationNames(i),"VARANASI") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
numVaranasi=numVaranasi+1
end if

if(isStrSubset(StationNames(i),"LUCKNOW") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
numLucknow=numLucknow+1
end if

if(isStrSubset(StationNames(i),"DELHI") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
numDelhi=numDelhi+1
end if

if(isStrSubset(StationNames(i),"PATNA") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
numPatna=numPatna+1
end if

if(isStrSubset(StationNames(i),"CHANDIGARH") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
numChandigarh=numChandigarh+1
end if

end do


print(numAmritsar)
print(numPatna)
print(numChandigarh)
print(numVaranasi)
print(numLucknow)
print(numDelhi)

print(numAmritsar+numPatna+numChandigarh+numVaranasi+numLucknow+numDelhi)

amritsarLines=new(numAmritsar,"string")
patnaLines=new(numPatna,"string")
varanasiLines=new(numVaranasi,"string")
lucknowLines=new(numLucknow,"string")
chandigarhLines=new(numChandigarh,"string")
delhiLines=new(numDelhi,"string")

a=0
p=0
v=0
l=0
c=0
d=0

do i=0,dimsizes(lines)-1

if(isStrSubset(StationNames(i),"AMRITSAR") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
amritsarLines(a)=lines(i)
a=a+1
end if

if(isStrSubset(StationNames(i),"VARANASI") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
varanasiLines(v)=lines(i)
v=v+1
end if

if(isStrSubset(StationNames(i),"LUCKNOW") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
lucknowLines(l)=lines(i)
l=l+1
end if

if(isStrSubset(StationNames(i),"DELHI") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
delhiLines(d)=lines(i)
d=d+1
end if

if(isStrSubset(StationNames(i),"PATNA") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
patnaLines(p)=lines(i)
p=p+1
end if

if(isStrSubset(StationNames(i),"CHANDIGARH") .and. (months(i).eq.1 .or. months(i).eq.12 ))then
chandigarhLines(c)=lines(i)
c=c+1
end if

end do

asciiwrite("AMRITSAR.txt", amritsarLines)
asciiwrite("VARANASI.txt", varanasiLines)
asciiwrite("LUCKNOW.txt", lucknowLines)
asciiwrite("PATNA.txt", patnaLines)
asciiwrite("DELHI.txt", delhiLines)
asciiwrite("CHANDIGARH.txt", chandigarhLines)
end

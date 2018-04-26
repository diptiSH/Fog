begin

;*********************read dates
datesData=readAsciiTable("AO_neg_EU_pos",3,"integer",0)

printVarSummary(datesData)

;****************** Open standard normal anomaly SLP file
slpFile=addfile("/home/user/Documents/Data/ERA-1.5/Daily_std_normal_anomaly/STD_NORM_ERADAILY-1.5deg-SLP-Dec-Jan-1979-2016.nc","r")
time = slpFile->time
printVarSummary(time)

;*************** Read data from file

SLP=slpFile->msl



;printVarSummary(SLP)


SHI=new(dimsizes(datesData(:,0)),"double")

do d=0,dimsizes(datesData(:,0))-1

year=datesData(d,0)
mon=datesData(d,1)
day=datesData(d,2)

t1= doubletoint(cd_inv_calendar(year,mon,day,12,00,00,time@units,0))

siberianSLP=SLP({t1},{40:65},{80:120})
SHI(d)=avg(siberianSLP)

;printVarSummary(siberianSLP)

;print(SHI)

;print(year)

end do

asciiwrite("SHI.txt",SHI)

;print(dimsizes(datesData(:,0)))

end

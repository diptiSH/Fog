begin


infile1=addfile("STD145E40N_NORM_ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")
infile2=addfile("STD20E55N_NORM_ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")
infile3=addfile("STD75E55N_NORM_ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")



time = infile1->time
printVarSummary(time)

datesData=readAsciiTable("allDate",3,"integer",0)
;datesData=readAsciiTable("date",3,"integer",0)

print(datesData)

;EU=new(105,"double")
EU=new(2139,"double")

do d=0,2138

year=datesData(d,0)
mon=datesData(d,1)
day=datesData(d,2)


t1= doubletoint(cd_inv_calendar(year,mon,day,12,00,00,time@units,0))

z145E40N=infile1->z({t1},0,0)
z20E55N=infile2->z({t1},0,0)
z75E55N=infile3->z({t1},0,0)


EU(d)=-(1/4.0)*z20E55N+(1/2.0)*z75E55N-(1/4.0)*z145E40N

end do

print(EU)

;asciiwrite("OneSigma_eu.txt",EU)
asciiwrite("AllDays_eu.txt",EU)

end

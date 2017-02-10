#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-25
1980-12-26
1980-12-29
1996-01-02
1996-01-11
1997-12-14
1997-12-19
1997-12-20
1997-12-27
1997-12-28
1998-12-19
1998-12-23
1998-12-24
1999-01-14
1999-12-26
1999-12-31
2001-01-03
2003-01-02
2003-01-16
2003-01-19
2003-12-21
2003-12-22
2003-12-23
2003-12-24
2004-01-01
2004-01-02
2004-01-03
2004-01-05
2004-01-06
2004-01-07
2004-01-19
2004-01-20
2004-12-22
2004-12-23
2004-12-24
2004-12-25
2009-01-09
2009-01-10
2009-01-11
2009-01-12
2009-01-13
2009-12-31
2010-01-03
2010-01-07
2010-01-08
2010-01-09
2010-01-13
2010-01-14
2010-01-15
2010-01-16
2010-01-18
2010-01-19
2010-01-23
2010-01-24
2011-01-07
2011-01-09
2012-01-03
2012-01-04
2012-01-05
2012-01-06
2012-01-08
2012-12-16
2012-12-27
2012-12-28
2013-01-04
2013-01-05
2013-01-06
2013-01-07
2013-12-17
2013-12-21
2013-12-22
2013-12-23
2013-12-24
2014-01-01
2014-01-05
2014-01-06
2014-01-07
2014-01-10
2014-01-11
2014-01-15
2014-01-16
2014-01-17
2014-01-19
2014-01-20
2014-01-25
2014-01-26
2014-01-31
2014-12-15
2014-12-21
2014-12-24
2014-12-25
2014-12-31
2015-01-02
2015-01-03
2015-01-04
2015-01-07
2015-01-09
2015-01-13
2015-01-16
2015-01-24
2015-01-25
2015-01-26
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
  #      cdo -sellonlatbox,0,360,0,90 -selvar,z,u,v,t -seldate,$i ERADAILY-1.5deg-200hPa-Dec-Jan-1979-2016.nc "/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/200/""$i"".nc"
 #        cdo -sellonlatbox,0,360,0,90 -selvar,z,u,v,t -seldate,$i ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc "/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/500/""$i"".nc"
#cdo -sellonlatbox,0,360,0,90 -selvar,z,u,v,t -seldate,$i ERADAILY-1.5deg-300hPa-Dec-Jan-1979-2016.nc "/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/300/""$i"".nc"
#cdo -sellonlatbox,0,360,0,90 -selvar,z,u,v,t -seldate,$i ERADAILY-1.5deg-850hPa-Dec-Jan-1979-2016.nc "/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/850/""$i"".nc"
cdo -sellonlatbox,0,360,0,90 -selvar,z,u,v,t -seldate,$i ERADAILY-1.5deg-700hPa-Dec-Jan-1979-2016.nc "/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/700/""$i"".nc"
#cdo -sellonlatbox,0,360,0,90 -seldate,$i ERADAILY-1.5deg-SLP-Dec-Jan-1979-2016.nc "/home/dipti/Documents/data/ERA-1.5/Final_ERA_inPut/SLP/""$i"".nc"
       
          #echo item: $i
       done


   

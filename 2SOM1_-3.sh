#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-22
1980-12-23
1980-12-26
1995-12-30
1997-12-11
1997-12-16
1997-12-17
1997-12-24
1998-12-16
1998-12-20
1998-12-21
1999-01-11
2002-12-30
2003-01-13
2003-01-16
2003-12-18
2003-12-19
2004-01-17
2009-01-06
2009-01-07
2009-01-08
2009-01-09
2009-01-10
2009-12-31
2010-01-04
2010-01-10
2010-01-11
2010-01-12
2010-01-13
2011-12-31
2012-01-01
2013-12-14
2013-12-18
2013-12-19
2013-12-20
2013-12-21
2014-01-12
2014-01-13
2014-01-14
2014-01-16
2014-01-17
2014-01-22
2014-01-23
2014-12-18
2014-12-21
2014-12-22
2014-12-28
2014-12-30
2014-12-31
2015-01-04
2015-01-06
2015-01-10
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-3.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-3.nc comp_-3.nc`
`cdo sub comp_-3.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-3.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

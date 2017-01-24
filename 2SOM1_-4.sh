#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-21
1980-12-22
1980-12-25
1995-12-29
1997-12-10
1997-12-15
1997-12-16
1997-12-23
1998-12-15
1998-12-19
1998-12-20
1999-01-10
2002-12-29
2003-01-12
2003-01-15
2003-12-17
2003-12-18
2004-01-16
2009-01-05
2009-01-06
2009-01-07
2009-01-08
2009-01-09
2009-12-30
2010-01-03
2010-01-09
2010-01-10
2010-01-11
2010-01-12
2011-12-30
2011-12-31
2013-12-13
2013-12-17
2013-12-18
2013-12-19
2013-12-20
2014-01-11
2014-01-12
2014-01-13
2014-01-15
2014-01-16
2014-01-21
2014-01-22
2014-12-17
2014-12-20
2014-12-21
2014-12-27
2014-12-29
2014-12-30
2015-01-03
2015-01-05
2015-01-09
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-4.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-4.nc comp_-4.nc`
`cdo sub comp_-4.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-4.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

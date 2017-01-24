#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-19
1980-12-20
1980-12-23
1995-12-27
1997-12-08
1997-12-13
1997-12-14
1997-12-21
1998-12-13
1998-12-17
1998-12-18
1999-01-08
2002-12-27
2003-01-10
2003-01-13
2003-12-15
2003-12-16
2004-01-14
2009-01-03
2009-01-04
2009-01-05
2009-01-06
2009-01-07
2009-12-28
2010-01-01
2010-01-07
2010-01-08
2010-01-09
2010-01-10
2011-12-28
2011-12-29
2013-12-11
2013-12-15
2013-12-16
2013-12-17
2013-12-18
2014-01-09
2014-01-10
2014-01-11
2014-01-13
2014-01-14
2014-01-19
2014-01-20
2014-12-15
2014-12-18
2014-12-19
2014-12-25
2014-12-27
2014-12-28
2015-01-01
2015-01-03
2015-01-07
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-6.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-6.nc comp_-6.nc`
`cdo sub comp_-6.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-6.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

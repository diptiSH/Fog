#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-17
1998-01-03
2000-01-01
2000-01-06
2001-01-09
2003-12-29
2003-12-30
2004-01-07
2004-01-08
2004-01-09
2004-01-11
2004-01-12
2004-01-13
2004-01-25
2004-12-28
2004-12-29
2004-12-30
2004-12-31
2010-01-06
2010-01-14
2010-01-15
2010-01-24
2010-01-25
2010-01-29
2010-01-30
2011-01-13
2011-01-15
2012-01-11
2012-01-12
2012-01-14
2012-12-22
2013-01-02
2013-01-03
2013-01-10
2013-01-11
2013-01-12
2013-01-13
2014-01-07
2014-01-11
2014-01-12
2014-01-13
2014-01-16
2014-01-17
2014-02-06
2014-12-21
2015-01-10
2015-01-22
2015-01-30
2015-01-31
2015-02-01
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/6.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/6.nc comp_6.nc`
`cdo sub comp_6.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_6.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

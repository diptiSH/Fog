#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-16
1998-01-02
1999-12-31
2000-01-05
2001-01-08
2003-12-28
2003-12-29
2004-01-06
2004-01-07
2004-01-08
2004-01-10
2004-01-11
2004-01-12
2004-01-24
2004-12-27
2004-12-28
2004-12-29
2004-12-30
2010-01-05
2010-01-13
2010-01-14
2010-01-23
2010-01-24
2010-01-28
2010-01-29
2011-01-12
2011-01-14
2012-01-10
2012-01-11
2012-01-13
2012-12-21
2013-01-01
2013-01-02
2013-01-09
2013-01-10
2013-01-11
2013-01-12
2014-01-06
2014-01-10
2014-01-11
2014-01-12
2014-01-15
2014-01-16
2014-02-05
2014-12-20
2015-01-09
2015-01-21
2015-01-29
2015-01-30
2015-01-31

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/5.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/5.nc comp_5.nc`
`cdo sub comp_5.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_5.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

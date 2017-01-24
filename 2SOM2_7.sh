#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-18
1998-01-04
2000-01-02
2000-01-07
2001-01-10
2003-12-30
2003-12-31
2004-01-08
2004-01-09
2004-01-10
2004-01-12
2004-01-13
2004-01-14
2004-01-26
2004-12-29
2004-12-30
2004-12-31
2005-01-01
2010-01-07
2010-01-15
2010-01-16
2010-01-25
2010-01-26
2010-01-30
2010-01-31
2011-01-14
2011-01-16
2012-01-12
2012-01-13
2012-01-15
2012-12-23
2013-01-03
2013-01-04
2013-01-11
2013-01-12
2013-01-13
2013-01-14
2014-01-08
2014-01-12
2014-01-13
2014-01-14
2014-01-17
2014-01-18
2014-02-07
2014-12-22
2015-01-11
2015-01-23
2015-01-31
2015-02-01
2015-02-02
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/7.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/7.nc comp_7.nc`
`cdo sub comp_7.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_7.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

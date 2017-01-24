#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-20
1998-01-06
2000-01-04
2000-01-09
2001-01-12
2004-01-01
2004-01-02
2004-01-10
2004-01-11
2004-01-12
2004-01-14
2004-01-15
2004-01-16
2004-01-28
2004-12-31
2005-01-01
2005-01-02
2005-01-03
2010-01-09
2010-01-17
2010-01-18
2010-01-27
2010-01-28
2010-02-01
2010-02-02
2011-01-16
2011-01-18
2012-01-14
2012-01-15
2012-01-17
2012-12-25
2013-01-05
2013-01-06
2013-01-13
2013-01-14
2013-01-15
2013-01-16
2014-01-10
2014-01-14
2014-01-15
2014-01-16
2014-01-19
2014-01-20
2014-02-09
2014-12-24
2015-01-13
2015-01-25
2015-02-02
2015-02-03
2015-02-04
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/9.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/9.nc comp_9.nc`
`cdo sub comp_9.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_9.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

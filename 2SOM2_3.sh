#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-14
1997-12-31
1999-12-29
2000-01-03
2001-01-06
2003-12-26
2003-12-27
2004-01-04
2004-01-05
2004-01-06
2004-01-08
2004-01-09
2004-01-10
2004-01-22
2004-12-25
2004-12-26
2004-12-27
2004-12-28
2010-01-03
2010-01-11
2010-01-12
2010-01-21
2010-01-22
2010-01-26
2010-01-27
2011-01-10
2011-01-12
2012-01-08
2012-01-09
2012-01-11
2012-12-19
2012-12-30
2012-12-31
2013-01-07
2013-01-08
2013-01-09
2013-01-10
2014-01-04
2014-01-08
2014-01-09
2014-01-10
2014-01-13
2014-01-14
2014-02-03
2014-12-18
2015-01-07
2015-01-19
2015-01-27
2015-01-28
2015-01-29

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/3.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/3.nc comp_3.nc`
`cdo sub comp_3.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_3.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

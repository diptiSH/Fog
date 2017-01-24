#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-15
1998-01-01
1999-12-30
2000-01-04
2001-01-07
2003-12-27
2003-12-28
2004-01-05
2004-01-06
2004-01-07
2004-01-09
2004-01-10
2004-01-11
2004-01-23
2004-12-26
2004-12-27
2004-12-28
2004-12-29
2010-01-04
2010-01-12
2010-01-13
2010-01-22
2010-01-23
2010-01-27
2010-01-28
2011-01-11
2011-01-13
2012-01-09
2012-01-10
2012-01-12
2012-12-20
2012-12-31
2013-01-01
2013-01-08
2013-01-09
2013-01-10
2013-01-11
2014-01-05
2014-01-09
2014-01-10
2014-01-11
2014-01-14
2014-01-15
2014-02-04
2014-12-19
2015-01-08
2015-01-20
2015-01-28
2015-01-29
2015-01-30
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/4.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/4.nc comp_4.nc`
`cdo sub comp_4.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_4.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

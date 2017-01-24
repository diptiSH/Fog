#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-19
1998-01-05
2000-01-03
2000-01-08
2001-01-11
2003-12-31
2004-01-01
2004-01-09
2004-01-10
2004-01-11
2004-01-13
2004-01-14
2004-01-15
2004-01-27
2004-12-30
2004-12-31
2005-01-01
2005-01-02
2010-01-08
2010-01-16
2010-01-17
2010-01-26
2010-01-27
2010-01-31
2010-02-01
2011-01-15
2011-01-17
2012-01-13
2012-01-14
2012-01-16
2012-12-24
2013-01-04
2013-01-05
2013-01-12
2013-01-13
2013-01-14
2013-01-15
2014-01-09
2014-01-13
2014-01-14
2014-01-15
2014-01-18
2014-01-19
2014-02-08
2014-12-23
2015-01-12
2015-01-24
2015-02-01
2015-02-02
2015-02-03

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/8.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/8.nc comp_8.nc`
`cdo sub comp_8.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_8.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-04
1997-12-21
1999-12-19
1999-12-24
2000-12-27
2003-12-16
2003-12-17
2003-12-25
2003-12-26
2003-12-27
2003-12-29
2003-12-30
2003-12-31
2004-01-12
2004-12-15
2004-12-16
2004-12-17
2004-12-18
2009-12-24
2010-01-01
2010-01-02
2010-01-11
2010-01-12
2010-01-16
2010-01-17
2010-12-31
2011-01-02
2011-12-29
2011-12-30
2012-01-01
2012-12-09
2012-12-20
2012-12-21
2012-12-28
2012-12-29
2012-12-30
2012-12-31
2013-12-25
2013-12-29
2013-12-30
2013-12-31
2014-01-03
2014-01-04
2014-01-24
2014-12-08
2014-12-28
2015-01-09
2015-01-17
2015-01-18
2015-01-19

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-7.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-7.nc comp_-7.nc`
`cdo sub comp_-7.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-7.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

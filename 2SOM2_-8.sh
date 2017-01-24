#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-03
1997-12-20
1999-12-18
1999-12-23
2000-12-26
2003-12-15
2003-12-16
2003-12-24
2003-12-25
2003-12-26
2003-12-28
2003-12-29
2003-12-30
2004-01-11
2004-12-14
2004-12-15
2004-12-16
2004-12-17
2009-12-23
2009-12-31
2010-01-01
2010-01-10
2010-01-11
2010-01-15
2010-01-16
2010-12-30
2011-01-01
2011-12-28
2011-12-29
2011-12-31
2012-12-08
2012-12-19
2012-12-20
2012-12-27
2012-12-28
2012-12-29
2012-12-30
2013-12-24
2013-12-28
2013-12-29
2013-12-30
2014-01-02
2014-01-03
2014-01-23
2014-12-07
2014-12-27
2015-01-08
2015-01-16
2015-01-17
2015-01-18


)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-8.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-8.nc comp_-8.nc`
`cdo sub comp_-8.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-8.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

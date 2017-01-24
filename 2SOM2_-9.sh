#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-02
1997-12-19
1999-12-17
1999-12-22
2000-12-25
2003-12-14
2003-12-15
2003-12-23
2003-12-24
2003-12-25
2003-12-27
2003-12-28
2003-12-29
2004-01-10
2004-12-13
2004-12-14
2004-12-15
2004-12-16
2009-12-22
2009-12-30
2009-12-31
2010-01-09
2010-01-10
2010-01-14
2010-01-15
2010-12-29
2010-12-31
2011-12-27
2011-12-28
2011-12-30
2012-12-07
2012-12-18
2012-12-19
2012-12-26
2012-12-27
2012-12-28
2012-12-29
2013-12-23
2013-12-27
2013-12-28
2013-12-29
2014-01-01
2014-01-02
2014-01-22
2014-12-06
2014-12-26
2015-01-07
2015-01-15
2015-01-16
2015-01-17
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-9.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-9.nc comp_-9.nc`
`cdo sub comp_-9.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-9.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

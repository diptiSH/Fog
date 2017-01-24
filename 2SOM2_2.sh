#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-13
1997-12-30
1999-12-28
2000-01-02
2001-01-05
2003-12-25
2003-12-26
2004-01-03
2004-01-04
2004-01-05
2004-01-07
2004-01-08
2004-01-09
2004-01-21
2004-12-24
2004-12-25
2004-12-26
2004-12-27
2010-01-02
2010-01-10
2010-01-11
2010-01-20
2010-01-21
2010-01-25
2010-01-26
2011-01-09
2011-01-11
2012-01-07
2012-01-08
2012-01-10
2012-12-18
2012-12-29
2012-12-30
2013-01-06
2013-01-07
2013-01-08
2013-01-09
2014-01-03
2014-01-07
2014-01-08
2014-01-09
2014-01-12
2014-01-13
2014-02-02
2014-12-17
2015-01-06
2015-01-18
2015-01-26
2015-01-27
2015-01-28
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/2.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/2.nc comp_2.nc`
`cdo sub comp_2.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_2.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-12
1997-12-29
1999-12-27
2000-01-01
2001-01-04
2003-12-24
2003-12-25
2004-01-02
2004-01-03
2004-01-04
2004-01-06
2004-01-07
2004-01-08
2004-01-20
2004-12-23
2004-12-24
2004-12-25
2004-12-26
2010-01-01
2010-01-09
2010-01-10
2010-01-19
2010-01-20
2010-01-24
2010-01-25
2011-01-08
2011-01-10
2012-01-06
2012-01-07
2012-01-09
2012-12-17
2012-12-28
2012-12-29
2013-01-05
2013-01-06
2013-01-07
2013-01-08
2014-01-02
2014-01-06
2014-01-07
2014-01-08
2014-01-11
2014-01-12
2014-02-01
2014-12-16
2015-01-05
2015-01-17
2015-01-25
2015-01-26
2015-01-27
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/1.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/1.nc comp_1.nc`
`cdo sub comp_1.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_1.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

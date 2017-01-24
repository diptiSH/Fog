#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-05
1997-12-22
1999-12-20
1999-12-25
2000-12-28
2003-12-17
2003-12-18
2003-12-26
2003-12-27
2003-12-28
2003-12-30
2003-12-31
2004-01-01
2004-01-13
2004-12-16
2004-12-17
2004-12-18
2004-12-19
2009-12-25
2010-01-02
2010-01-03
2010-01-12
2010-01-13
2010-01-17
2010-01-18
2011-01-01
2011-01-03
2011-12-30
2011-12-31
2012-01-02
2012-12-10
2012-12-21
2012-12-22
2012-12-29
2012-12-30
2012-12-31
2013-01-01
2013-12-26
2013-12-30
2013-12-31
2014-01-01
2014-01-04
2014-01-05
2014-01-25
2014-12-09
2014-12-29
2015-01-10
2015-01-18
2015-01-19
2015-01-20

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-6.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-6.nc comp_-6.nc`
`cdo sub comp_-6.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-6.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

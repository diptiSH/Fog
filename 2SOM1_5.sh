#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-30
1980-12-31
1981-01-03
1996-01-07
1997-12-19
1997-12-24
1997-12-25
1998-01-01
1998-12-24
1998-12-28
1998-12-29
1999-01-19
2003-01-07
2003-01-21
2003-01-24
2003-12-26
2003-12-27
2004-01-25
2009-01-14
2009-01-15
2009-01-16
2009-01-17
2009-01-18
2010-01-08
2010-01-12
2010-01-18
2010-01-19
2010-01-20
2010-01-21
2012-01-08
2012-01-09
2013-12-22
2013-12-26
2013-12-27
2013-12-28
2013-12-29
2014-01-20
2014-01-21
2014-01-22
2014-01-24
2014-01-25
2014-01-30
2014-01-31
2014-12-26
2014-12-29
2014-12-30
2015-01-05
2015-01-07
2015-01-08
2015-01-12
2015-01-14
2015-01-18
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/5.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/5.nc comp_5.nc`
`cdo sub comp_5.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_5.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

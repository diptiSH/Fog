#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1981-01-03
1981-01-04
1981-01-07
1996-01-11
1997-12-23
1997-12-28
1997-12-29
1998-01-05
1998-12-28
1999-01-01
1999-01-02
1999-01-23
2003-01-11
2003-01-25
2003-01-28
2003-12-30
2003-12-31
2004-01-29
2009-01-18
2009-01-19
2009-01-20
2009-01-21
2009-01-22
2010-01-12
2010-01-16
2010-01-22
2010-01-23
2010-01-24
2010-01-25
2012-01-12
2012-01-13
2013-12-26
2013-12-30
2013-12-31
2014-01-01
2014-01-02
2014-01-24
2014-01-25
2014-01-26
2014-01-28
2014-01-29
2014-02-03
2014-02-04
2014-12-30
2015-01-02
2015-01-03
2015-01-09
2015-01-11
2015-01-12
2015-01-16
2015-01-18
2015-01-22
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/9.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/9.nc comp_9.nc`
`cdo sub comp_9.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_9.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

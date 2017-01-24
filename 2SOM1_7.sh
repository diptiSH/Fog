#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1981-01-01
1981-01-02
1981-01-05
1996-01-09
1997-12-21
1997-12-26
1997-12-27
1998-01-03
1998-12-26
1998-12-30
1998-12-31
1999-01-21
2003-01-09
2003-01-23
2003-01-26
2003-12-28
2003-12-29
2004-01-27
2009-01-16
2009-01-17
2009-01-18
2009-01-19
2009-01-20
2010-01-10
2010-01-14
2010-01-20
2010-01-21
2010-01-22
2010-01-23
2012-01-10
2012-01-11
2013-12-24
2013-12-28
2013-12-29
2013-12-30
2013-12-31
2014-01-22
2014-01-23
2014-01-24
2014-01-26
2014-01-27
2014-02-01
2014-02-02
2014-12-28
2014-12-31
2015-01-01
2015-01-07
2015-01-09
2015-01-10
2015-01-14
2015-01-16
2015-01-20

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/7.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/7.nc comp_7.nc`
`cdo sub comp_7.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_7.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

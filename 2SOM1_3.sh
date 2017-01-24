#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-28
1980-12-29
1981-01-01
1996-01-05
1997-12-17
1997-12-22
1997-12-23
1997-12-30
1998-12-22
1998-12-26
1998-12-27
1999-01-17
2003-01-05
2003-01-19
2003-01-22
2003-12-24
2003-12-25
2004-01-23
2009-01-12
2009-01-13
2009-01-14
2009-01-15
2009-01-16
2010-01-06
2010-01-10
2010-01-16
2010-01-17
2010-01-18
2010-01-19
2012-01-06
2012-01-07
2013-12-20
2013-12-24
2013-12-25
2013-12-26
2013-12-27
2014-01-18
2014-01-19
2014-01-20
2014-01-22
2014-01-23
2014-01-28
2014-01-29
2014-12-24
2014-12-27
2014-12-28
2015-01-03
2015-01-05
2015-01-06
2015-01-10
2015-01-12
2015-01-16

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/3.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/3.nc comp_3.nc`
`cdo sub comp_3.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_3.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

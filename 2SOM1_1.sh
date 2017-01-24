#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-26
1980-12-27
1980-12-30
1996-01-03
1997-12-15
1997-12-20
1997-12-21
1997-12-28
1998-12-20
1998-12-24
1998-12-25
1999-01-15
2003-01-03
2003-01-17
2003-01-20
2003-12-22
2003-12-23
2004-01-21
2009-01-10
2009-01-11
2009-01-12
2009-01-13
2009-01-14
2010-01-04
2010-01-08
2010-01-14
2010-01-15
2010-01-16
2010-01-17
2012-01-04
2012-01-05
2013-12-18
2013-12-22
2013-12-23
2013-12-24
2013-12-25
2014-01-16
2014-01-17
2014-01-18
2014-01-20
2014-01-21
2014-01-26
2014-01-27
2014-12-22
2014-12-25
2014-12-26
2015-01-01
2015-01-03
2015-01-04
2015-01-08
2015-01-10
2015-01-14
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/1.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/1.nc comp_1.nc`
`cdo sub comp_1.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_1.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

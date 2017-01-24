#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-29
1980-12-30
1981-01-02
1996-01-06
1997-12-18
1997-12-23
1997-12-24
1997-12-31
1998-12-23
1998-12-27
1998-12-28
1999-01-18
2003-01-06
2003-01-20
2003-01-23
2003-12-25
2003-12-26
2004-01-24
2009-01-13
2009-01-14
2009-01-15
2009-01-16
2009-01-17
2010-01-07
2010-01-11
2010-01-17
2010-01-18
2010-01-19
2010-01-20
2012-01-07
2012-01-08
2013-12-21
2013-12-25
2013-12-26
2013-12-27
2013-12-28
2014-01-19
2014-01-20
2014-01-21
2014-01-23
2014-01-24
2014-01-29
2014-01-30
2014-12-25
2014-12-28
2014-12-29
2015-01-04
2015-01-06
2015-01-07
2015-01-11
2015-01-13
2015-01-17
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/4.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/4.nc comp_4.nc`
`cdo sub comp_4.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_4.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

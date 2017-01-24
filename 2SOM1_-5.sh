#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-20
1980-12-21
1980-12-24
1995-12-28
1997-12-09
1997-12-14
1997-12-15
1997-12-22
1998-12-14
1998-12-18
1998-12-19
1999-01-09
2002-12-28
2003-01-11
2003-01-14
2003-12-16
2003-12-17
2004-01-15
2009-01-04
2009-01-05
2009-01-06
2009-01-07
2009-01-08
2009-12-29
2010-01-02
2010-01-08
2010-01-09
2010-01-10
2010-01-11
2011-12-29
2011-12-30
2013-12-12
2013-12-16
2013-12-17
2013-12-18
2013-12-19
2014-01-10
2014-01-11
2014-01-12
2014-01-14
2014-01-15
2014-01-20
2014-01-21
2014-12-16
2014-12-19
2014-12-20
2014-12-26
2014-12-28
2014-12-29
2015-01-02
2015-01-04
2015-01-08
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-5.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-5.nc comp_-5.nc`
`cdo sub comp_-5.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-5.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

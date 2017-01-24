#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-17
1980-12-18
1980-12-21
1995-12-25
1997-12-06
1997-12-11
1997-12-12
1997-12-19
1998-12-11
1998-12-15
1998-12-16
1999-01-06
2002-12-25
2003-01-08
2003-01-11
2003-12-13
2003-12-14
2004-01-12
2009-01-01
2009-01-02
2009-01-03
2009-01-04
2009-01-05
2009-12-26
2009-12-30
2010-01-05
2010-01-06
2010-01-07
2010-01-08
2011-12-26
2011-12-27
2013-12-09
2013-12-13
2013-12-14
2013-12-15
2013-12-16
2014-01-07
2014-01-08
2014-01-09
2014-01-11
2014-01-12
2014-01-17
2014-01-18
2014-12-13
2014-12-16
2014-12-17
2014-12-23
2014-12-25
2014-12-26
2014-12-30
2015-01-01
2015-01-05

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-8.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-8.nc comp_-8.nc`
`cdo sub comp_-8.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-8.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

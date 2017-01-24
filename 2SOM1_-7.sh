#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-18
1980-12-19
1980-12-22
1995-12-26
1997-12-07
1997-12-12
1997-12-13
1997-12-20
1998-12-12
1998-12-16
1998-12-17
1999-01-07
2002-12-26
2003-01-09
2003-01-12
2003-12-14
2003-12-15
2004-01-13
2009-01-02
2009-01-03
2009-01-04
2009-01-05
2009-01-06
2009-12-27
2009-12-31
2010-01-06
2010-01-07
2010-01-08
2010-01-09
2011-12-27
2011-12-28
2013-12-10
2013-12-14
2013-12-15
2013-12-16
2013-12-17
2014-01-08
2014-01-09
2014-01-10
2014-01-12
2014-01-13
2014-01-18
2014-01-19
2014-12-14
2014-12-17
2014-12-18
2014-12-24
2014-12-26
2014-12-27
2014-12-31
2015-01-02
2015-01-06

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-7.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-7.nc comp_-7.nc`
`cdo sub comp_-7.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-7.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

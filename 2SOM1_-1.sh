#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-24
1980-12-25
1980-12-28
1996-01-01
1997-12-13
1997-12-18
1997-12-19
1997-12-26
1998-12-18
1998-12-22
1998-12-23
1999-01-13
2003-01-01
2003-01-15
2003-01-18
2003-12-20
2003-12-21
2004-01-19
2009-01-08
2009-01-09
2009-01-10
2009-01-11
2009-01-12
2010-01-02
2010-01-06
2010-01-12
2010-01-13
2010-01-14
2010-01-15
2012-01-02
2012-01-03
2013-12-16
2013-12-20
2013-12-21
2013-12-22
2013-12-23
2014-01-14
2014-01-15
2014-01-16
2014-01-18
2014-01-19
2014-01-24
2014-01-25
2014-12-20
2014-12-23
2014-12-24
2014-12-30
2015-01-01
2015-01-02
2015-01-06
2015-01-08
2015-01-12

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-1.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-1.nc comp_-1.nc`
`cdo sub comp_-1.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-1.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

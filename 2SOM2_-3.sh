#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-08
1997-12-25
1999-12-23
1999-12-28
2000-12-31
2003-12-20
2003-12-21
2003-12-29
2003-12-30
2003-12-31
2004-01-02
2004-01-03
2004-01-04
2004-01-16
2004-12-19
2004-12-20
2004-12-21
2004-12-22
2009-12-28
2010-01-05
2010-01-06
2010-01-15
2010-01-16
2010-01-20
2010-01-21
2011-01-04
2011-01-06
2012-01-02
2012-01-03
2012-01-05
2012-12-13
2012-12-24
2012-12-25
2013-01-01
2013-01-02
2013-01-03
2013-01-04
2013-12-29
2014-01-02
2014-01-03
2014-01-04
2014-01-07
2014-01-08
2014-01-28
2014-12-12
2015-01-01
2015-01-13
2015-01-21
2015-01-22
2015-01-23

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-3.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-3.nc comp_-3.nc`
`cdo sub comp_-3.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-3.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

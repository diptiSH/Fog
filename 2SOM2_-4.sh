#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-07
1997-12-24
1999-12-22
1999-12-27
2000-12-30
2003-12-19
2003-12-20
2003-12-28
2003-12-29
2003-12-30
2004-01-01
2004-01-02
2004-01-03
2004-01-15
2004-12-18
2004-12-19
2004-12-20
2004-12-21
2009-12-27
2010-01-04
2010-01-05
2010-01-14
2010-01-15
2010-01-19
2010-01-20
2011-01-03
2011-01-05
2012-01-01
2012-01-02
2012-01-04
2012-12-12
2012-12-23
2012-12-24
2012-12-31
2013-01-01
2013-01-02
2013-01-03
2013-12-28
2014-01-01
2014-01-02
2014-01-03
2014-01-06
2014-01-07
2014-01-27
2014-12-11
2014-12-31
2015-01-12
2015-01-20
2015-01-21
2015-01-22

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-4.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-4.nc comp_-4.nc`
`cdo sub comp_-4.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-4.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

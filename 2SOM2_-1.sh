#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-10
1997-12-27
1999-12-25
1999-12-30
2001-01-02
2003-12-22
2003-12-23
2003-12-31
2004-01-01
2004-01-02
2004-01-04
2004-01-05
2004-01-06
2004-01-18
2004-12-21
2004-12-22
2004-12-23
2004-12-24
2009-12-30
2010-01-07
2010-01-08
2010-01-17
2010-01-18
2010-01-22
2010-01-23
2011-01-06
2011-01-08
2012-01-04
2012-01-05
2012-01-07
2012-12-15
2012-12-26
2012-12-27
2013-01-03
2013-01-04
2013-01-05
2013-01-06
2013-12-31
2014-01-04
2014-01-05
2014-01-06
2014-01-09
2014-01-10
2014-01-30
2014-12-14
2015-01-03
2015-01-15
2015-01-23
2015-01-24
2015-01-25
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-1.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-1.nc comp_-1.nc`
`cdo sub comp_-1.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-1.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

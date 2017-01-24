#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-09
1997-12-26
1999-12-24
1999-12-29
2001-01-01
2003-12-21
2003-12-22
2003-12-30
2003-12-31
2004-01-01
2004-01-03
2004-01-04
2004-01-05
2004-01-17
2004-12-20
2004-12-21
2004-12-22
2004-12-23
2009-12-29
2010-01-06
2010-01-07
2010-01-16
2010-01-17
2010-01-21
2010-01-22
2011-01-05
2011-01-07
2012-01-03
2012-01-04
2012-01-06
2012-12-14
2012-12-25
2012-12-26
2013-01-02
2013-01-03
2013-01-04
2013-01-05
2013-12-30
2014-01-03
2014-01-04
2014-01-05
2014-01-08
2014-01-09
2014-01-29
2014-12-13
2015-01-02
2015-01-14
2015-01-22
2015-01-23
2015-01-24
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-2.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-2.nc comp_-2.nc`
`cdo sub comp_-2.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-2.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

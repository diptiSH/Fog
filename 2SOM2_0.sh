#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-11
1997-12-28
1999-12-26
1999-12-31
2001-01-03
2003-12-23
2003-12-24
2004-01-01
2004-01-02
2004-01-03
2004-01-05
2004-01-06
2004-01-07
2004-01-19
2004-12-22
2004-12-23
2004-12-24
2004-12-25
2009-12-31
2010-01-08
2010-01-09
2010-01-18
2010-01-19
2010-01-23
2010-01-24
2011-01-07
2011-01-09
2012-01-05
2012-01-06
2012-01-08
2012-12-16
2012-12-27
2012-12-28
2013-01-04
2013-01-05
2013-01-06
2013-01-07
2014-01-01
2014-01-05
2014-01-06
2014-01-07
2014-01-10
2014-01-11
2014-01-31
2014-12-15
2015-01-04
2015-01-16
2015-01-24
2015-01-25
2015-01-26
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/0.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/0.nc comp_0.nc`
`cdo sub comp_0.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_0.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

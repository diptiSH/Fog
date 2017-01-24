#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1996-01-06
1997-12-23
1999-12-21
1999-12-26
2000-12-29
2003-12-18
2003-12-19
2003-12-27
2003-12-28
2003-12-29
2003-12-31
2004-01-01
2004-01-02
2004-01-14
2004-12-17
2004-12-18
2004-12-19
2004-12-20
2009-12-26
2010-01-03
2010-01-04
2010-01-13
2010-01-14
2010-01-18
2010-01-19
2011-01-02
2011-01-04
2011-12-31
2012-01-01
2012-01-03
2012-12-11
2012-12-22
2012-12-23
2012-12-30
2012-12-31
2013-01-01
2013-01-02
2013-12-27
2013-12-31
2014-01-01
2014-01-02
2014-01-05
2014-01-06
2014-01-26
2014-12-10
2014-12-30
2015-01-11
2015-01-19
2015-01-20
2015-01-21

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM2/-5.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM2/-5.nc comp_-5.nc`
`cdo sub comp_-5.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-5.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

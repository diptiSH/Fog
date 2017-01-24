#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-27
1980-12-28
1980-12-31
1996-01-04
1997-12-16
1997-12-21
1997-12-22
1997-12-29
1998-12-21
1998-12-25
1998-12-26
1999-01-16
2003-01-04
2003-01-18
2003-01-21
2003-12-23
2003-12-24
2004-01-22
2009-01-11
2009-01-12
2009-01-13
2009-01-14
2009-01-15
2010-01-05
2010-01-09
2010-01-15
2010-01-16
2010-01-17
2010-01-18
2012-01-05
2012-01-06
2013-12-19
2013-12-23
2013-12-24
2013-12-25
2013-12-26
2014-01-17
2014-01-18
2014-01-19
2014-01-21
2014-01-22
2014-01-27
2014-01-28
2014-12-23
2014-12-26
2014-12-27
2015-01-02
2015-01-04
2015-01-05
2015-01-09
2015-01-11
2015-01-15

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/2.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/2.nc comp_2.nc`
`cdo sub comp_2.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_2.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

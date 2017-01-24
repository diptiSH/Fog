#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-31
1981-01-01
1981-01-04
1996-01-08
1997-12-20
1997-12-25
1997-12-26
1998-01-02
1998-12-25
1998-12-29
1998-12-30
1999-01-20
2003-01-08
2003-01-22
2003-01-25
2003-12-27
2003-12-28
2004-01-26
2009-01-15
2009-01-16
2009-01-17
2009-01-18
2009-01-19
2010-01-09
2010-01-13
2010-01-19
2010-01-20
2010-01-21
2010-01-22
2012-01-09
2012-01-10
2013-12-23
2013-12-27
2013-12-28
2013-12-29
2013-12-30
2014-01-21
2014-01-22
2014-01-23
2014-01-25
2014-01-26
2014-01-31
2014-02-01
2014-12-27
2014-12-30
2014-12-31
2015-01-06
2015-01-08
2015-01-09
2015-01-13
2015-01-15
2015-01-19

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/6.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/6.nc comp_6.nc`
`cdo sub comp_6.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_6.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

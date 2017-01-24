#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-23
1980-12-24
1980-12-27
1995-12-31
1997-12-12
1997-12-17
1997-12-18
1997-12-25
1998-12-17
1998-12-21
1998-12-22
1999-01-12
2002-12-31
2003-01-14
2003-01-17
2003-12-19
2003-12-20
2004-01-18
2009-01-07
2009-01-08
2009-01-09
2009-01-10
2009-01-11
2010-01-01
2010-01-05
2010-01-11
2010-01-12
2010-01-13
2010-01-14
2012-01-01
2012-01-02
2013-12-15
2013-12-19
2013-12-20
2013-12-21
2013-12-22
2014-01-13
2014-01-14
2014-01-15
2014-01-17
2014-01-18
2014-01-23
2014-01-24
2014-12-19
2014-12-22
2014-12-23
2014-12-29
2014-12-31
2015-01-01
2015-01-05
2015-01-07
2015-01-11
	
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-2.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-2.nc comp_-2.nc`
`cdo sub comp_-2.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-2.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

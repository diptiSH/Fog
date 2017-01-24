#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-16
1980-12-17
1980-12-20
1995-12-24
1997-12-05
1997-12-10
1997-12-11
1997-12-18
1998-12-10
1998-12-14
1998-12-15
1999-01-05
2002-12-24
2003-01-07
2003-01-10
2003-12-12
2003-12-13
2004-01-11
2008-12-31
2009-01-01
2009-01-02
2009-01-03
2009-01-04
2009-12-25
2009-12-29
2010-01-04
2010-01-05
2010-01-06
2010-01-07
2011-12-25
2011-12-26
2013-12-08
2013-12-12
2013-12-13
2013-12-14
2013-12-15
2014-01-06
2014-01-07
2014-01-08
2014-01-10
2014-01-11
2014-01-16
2014-01-17
2014-12-12
2014-12-15
2014-12-16
2014-12-22
2014-12-24
2014-12-25
2014-12-29
2014-12-31
2015-01-04
)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/-9.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/-9.nc comp_-9.nc`
`cdo sub comp_-9.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc anom_-9.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

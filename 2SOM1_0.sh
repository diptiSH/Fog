#!/bin/bash
 # this is my first shell script.JGRJJD
        dates=(1980-12-25
1980-12-26
1980-12-29
1996-01-02
1997-12-14
1997-12-19
1997-12-20
1997-12-27
1998-12-19
1998-12-23
1998-12-24
1999-01-14
2003-01-02
2003-01-16
2003-01-19
2003-12-21
2003-12-22
2004-01-20
2009-01-09
2009-01-10
2009-01-11
2009-01-12
2009-01-13
2010-01-03
2010-01-07
2010-01-13
2010-01-14
2010-01-15
2010-01-16
2012-01-03
2012-01-04
2013-12-17
2013-12-21
2013-12-22
2013-12-23
2013-12-24
2014-01-15
2014-01-16
2014-01-17
2014-01-19
2014-01-20
2014-01-25
2014-01-26
2014-12-21
2014-12-24
2014-12-25
2014-12-31
2015-01-02
2015-01-03
2015-01-07
2015-01-09
2015-01-13

)
        #echo ${dates[*]}
       for i in "${dates[@]}"
       do
        echo $i
        cdo seldate,$i Daily_ERA_DJ_1979-2015_snow_evaporation.nc "/home/dipti/Documents/data/sno_evaporation/day_""$i""_snow.nc"
       
          #echo item: $i
       done
`cdo mergetime day_*.nc /home/dipti/Documents/data/sno_evaporation/2SOM1/0.nc`
`cdo timmean /home/dipti/Documents/data/sno_evaporation/2SOM1/0.nc comp_0.nc`
`cdo sub comp_0.nc clim_ERA_DJ_1979-2015_snow_evaporation.nc 0.nc`

    for i in "${dates[@]}"
       do
        echo $i
                rm "day_""$i""_snow.nc"
       
          #echo item: $i
      done

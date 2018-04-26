#!/bin/bash

 dates0=(1981-12-28
1982-12-04
1983-11-27
1983-11-30
1984-11-27
1985-01-08
1985-12-19
1986-12-26
1987-11-28
1987-11-29
1988-01-12
1988-01-19
1988-01-24
1989-11-29
1994-12-04
1994-12-05
1996-12-02
2000-11-25
2009-11-30
)




ndays=( 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14)
 for j in "${ndays[@]}"
     do
         echo $j
        for i in "${dates0[@]}"
       do
            useDate=`date --date=$i'+'$j' day' +'%Y-%m-%d'`
            #echo $useDate
              # echo $i
            cdo   -seldate,$useDate /home/user/Documents/Data/ERA-1.5/ERADAILY-1.5deg-AllLevels-Dec-Jan-1979-2016.nc ""$useDate"".nc
                
          #echo item: $i
       done

        k=`expr $j - 7`
        echo $k

        cdo mergetime *.nc  /home/user/Documents/work/All_levels/Nofog/Both_neg/""$k""ERA-1.5deg_AllLevels.nc
      # /home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files  
    cdo timmean  /home/user/Documents/work/All_levels/Nofog/Both_neg/""$k""ERA-1.5deg_AllLevels.nc  /home/user/Documents/work/All_levels/Nofog/Both_neg/Comp""$k""ERA_1.5deg_AllLevels.nc

        rm /home/user/Documents/work/All_levels/Nofog/Both_neg/""$k""ERA-1.5deg_AllLevels.nc


  for i in "${dates0[@]}"
       do
            useDate=`date --date=$i'+'$j' day' +'%Y-%m-%d'`
            #echo $useDate
             #  echo $i
            rm ""$useDate"".nc
                
          #echo item: $i
       done

   for i in "${dates0[@]}"
           do
            useDate=`date --date=$i'+'$j' day' +'%Y-%m-%d'`
            #echo $useDate
             #  echo $i
            cdo   -seldate,$useDate /home/user/Documents/Data/ERA-1.5/Daily_anomalies/ERAANOM-1.5deg-AllLevels-Dec-Jan-1979-2016.nc ""$useDate"".nc
                
          #echo item: $i
       done

        cdo mergetime *.nc  /home/user/Documents/work/All_levels/Nofog/Both_neg/Anom""$k""ERA-1.5deg_AllLevels.nc
      # /home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files  
    cdo timmean  /home/user/Documents/work/All_levels/Nofog/Both_neg/Anom""$k""ERA-1.5deg_AllLevels.nc  /home/user/Documents/work/All_levels/Nofog/Both_neg/Anom""$k""ERA_1.5deg_AllLevels.nc

        rm /home/user/Documents/work/All_levels/Nofog/Both_neg/Anom""$k""ERA-1.5deg_AllLevels.nc

  for i in "${dates0[@]}"
       do
            useDate=`date --date=$i'+'$j' day' +'%Y-%m-%d'`
           # echo $useDate
            #   echo $i
            rm ""$useDate"".nc
                
          #echo item: $i
       done


done



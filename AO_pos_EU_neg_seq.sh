#!/bin/bash

 dates0=(1982-11-25
1982-11-26
1982-11-27
1982-11-28
1982-11-29
1982-11-30
1982-12-03
1983-01-21
1984-12-02
1984-12-03
1986-11-26
1986-12-05
1986-12-06
1988-01-10
1988-11-26
1988-11-27
1988-11-28
1988-12-07
1989-01-04
1989-01-05
1989-01-13
1989-01-22
1989-01-23
1990-12-07
1990-12-18
1991-01-13
1992-01-18
1993-01-14
1993-01-15
1993-01-16
1993-01-17
1993-01-18
1993-01-19
1993-01-20
1998-11-25
2001-01-18
2007-12-15
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

        cdo mergetime *.nc  /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/""$k""ERA-1.5deg_AllLevels.nc
      # /home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files  
    cdo timmean  /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/""$k""ERA-1.5deg_AllLevels.nc  /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/Comp""$k""ERA_1.5deg_AllLevels.nc

        rm /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/""$k""ERA-1.5deg_AllLevels.nc


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

        cdo mergetime *.nc  /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/Anom""$k""ERA-1.5deg_AllLevels.nc
      # /home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files  
    cdo timmean  /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/Anom""$k""ERA-1.5deg_AllLevels.nc  /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/Anom""$k""ERA_1.5deg_AllLevels.nc

        rm /home/user/Documents/work/All_levels/Nofog/AO_pos_EU_neg/Anom""$k""ERA-1.5deg_AllLevels.nc

  for i in "${dates0[@]}"
       do
            useDate=`date --date=$i'+'$j' day' +'%Y-%m-%d'`
           # echo $useDate
            #   echo $i
            rm ""$useDate"".nc
                
          #echo item: $i
       done


done



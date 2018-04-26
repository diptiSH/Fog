#!/bin/bash

 dates0=(1982-01-19
1982-12-05
1983-11-28
1983-11-29
1983-12-01
1984-01-18
1984-01-21
1985-01-18
1985-01-20
1985-11-24
1985-11-25
1985-11-27
1985-11-28
1985-11-29
1985-12-12
1985-12-13
1986-12-13
1986-12-22
1987-11-24
1987-11-26
1988-01-20
1988-01-21
1988-01-22
1992-01-11
1992-12-06
2011-01-19
2012-01-18
2012-11-24
2012-11-25
2012-11-27
2012-11-29
2012-11-30
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

        cdo mergetime *.nc  /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/""$k""ERA-1.5deg_AllLevels.nc
      # /home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files  
    cdo timmean  /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/""$k""ERA-1.5deg_AllLevels.nc  /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/Comp""$k""ERA_1.5deg_AllLevels.nc

        rm /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/""$k""ERA-1.5deg_AllLevels.nc


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

        cdo mergetime *.nc  /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/Anom""$k""ERA-1.5deg_AllLevels.nc
      # /home/user/Documents/work/me10Criterion/OneSigma_anom/00Z/nc_files  
    cdo timmean  /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/Anom""$k""ERA-1.5deg_AllLevels.nc  /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/Anom""$k""ERA_1.5deg_AllLevels.nc

        rm /home/user/Documents/work/All_levels/Nofog/AO_neg_EU_pos/Anom""$k""ERA-1.5deg_AllLevels.nc

  for i in "${dates0[@]}"
       do
            useDate=`date --date=$i'+'$j' day' +'%Y-%m-%d'`
           # echo $useDate
            #   echo $i
            rm ""$useDate"".nc
                
          #echo item: $i
       done


done



'c'
'reinit'
'set display color white'


#'set map 15 1 12'
#'set rgb color# R G B'
'set rgb  16    0    0  255'
'set rgb  17   55   55  255'
'set rgb  18  110  110  255'
'set rgb  19  165  165  255'
'set rgb  20  220  220  255'

'set rgb  21  255  220  220'
'set rgb  22  255  165  165'
'set rgb  23  255  110  110'
'set rgb  24  255   55   55'
'set rgb  25  255    0    0'





 j=-9

   while (j <= 9)
'sdfopen /home/dipti/Documents/data/snow_melt/2SOM1/anom/anom_' j'.nc'

  'define smlt1=smlt*1000.0'  

'set gxout shaded'
'set lat 10 70'
'set lon 0 180'
'set clevs  -0.04 -0.03 -0.02 -0.01 -0.005 0.005 0.01 0.02 0.03 0.04'
'set ccols  16 17 18 19 20 0 21 22 23 24 25'

*     'set ccolor 1'
 
     
'd smlt1'

'cbarn'
'draw title 2SOM1_day'j

'printim 2SOM1_day' j'.eps'

 j=j+1


'clear'
'close 1'

*'set grads off'
   endwhile



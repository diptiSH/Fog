i = -7
while (i < 8) 
'reinit'
'set display color white'
'set grads off'
'set map 15 1 12'
'set mproj nps'

if (i < 0)
j=i * -1
 say j
'sdfopen /home/dipti/Documents/data/ERA-1.5/Daily_sequence/200/AnomSOM1_minus_'j'_ERA_1.5_500hPa.nc'
else

if (i > 0 )
'sdfopen /home/dipti/Documents/data/ERA-1.5/Daily_sequence/200/AnomSOM1_'j'_ERA_1.5_500hPa.nc'
say i
else
'sdfopen /home/dipti/Documents/data/ERA-1.5/Daily_sequence/200/AnomSOM1_ERA_1.5_500hPa.nc'  
say "test"
  
endif

endif
'set gxout shaded'
'set lat 0 90'
'set lon 0 360'
'set clevs -2 -1.5 -1 -0.5 -0.1 0.1 0.5 1 1.5 2'

*'set rgb color# R G B'
*'* These are the BLUE shades'
'set rgb  16    0    0  255'
'set rgb  17   55   55  255'
'set rgb  18  110  110  255'
'set rgb  19  165  165  255'
'set rgb  20  220  220  255'
*'* These are the RED shades'
'set rgb  21  255  220  220'
'set rgb  22  255  165  165'
'set rgb  23  255  110  110'
'set rgb  24  255   55   55'
'set rgb  25  255    0    0'

'set ccols 16 17 18 19 20 0 21 22 23 24 25'

'd t'

'cbarn'

'set gxout contour'

'define z1=z/9.8'

'd z1'

'set ccolor 1'

*'set gxout barb'

*'set hempref nhem'
*'set digsiz 0.02'
*'set arrowhead 0.01'

*'define wspd=1.944*mag(u,v)'

*'d skip(maskout(1.944*u,wspd-2),5,5);maskout(1.944*v,wspd-2)'

*'d skip(u,3,3) ; v'
'set ccolor 13'
' set strmden 2 '
' set gxout stream'
'd u;v'




'draw title SOM1_anomaly_500hPa_day'i

'printim 500hPa_SOM1_nps_day_'i'.png'

     i = i + 1 
endwhile



'reinit'
'set display color white'
'set grads off'
'set map 15 1 4'
'set mproj nps'
'set mpvals -100 260  0 90'

'sdfopen /home/iitm/Documents/AnomFogDay0_ERA_1.5_200hPa.nc'

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

'set gxout vector'
'set arrscl 0.15 1.5' 
'set arrowhead 0.04'   

'd skip(u,5,3) ; v'



'draw title 231Day_anomaly 200hPa'

'gxprint 231_anom_200.pdf'



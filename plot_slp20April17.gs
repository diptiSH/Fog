
'reinit'
'set display color white'
'set grads off'
'set map 15 1 4'
'set mproj nps'
'set mpvals -100 260  0 90'

'sdfopen /home/iitm/Documents/AnomFogDay0_ERA_1.5_SLP.nc'


'set ccolor 1'
'set gxout contour'

'define msl1=msl/9.8'

'd msl1'






'draw title 231Day_anomaly SLP'

'gxprint 231_anom_SLP.pdf'



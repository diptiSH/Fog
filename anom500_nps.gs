
i = 0
while (i < 15)

'reinit'
'sdfopen Anom'i'ERA3D-00UTC-1.5deg_Fog.nc'
'enable print test.meta'
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
'set grads off'
'set map 15 1 12'
'set mproj nps'
'set lat 0 90'
'set lon -90 270'
'set mpvals -90 270 0 90'
'set lev 500'
'set gxout shaded'
'set clevs -40 -30 -20 -10 -5 5 10 20 30 40'
'set ccols 16 17 18 19 20 0 21 22 23 24 25'
'd smth9(z/9.80665)'
'run cbarn 1 1'
'set gxout contour'
'set clevs -100 -90 -80 -70 -60 -50 -40 -30 -20 -10 -5 5 10 20 30 40 50 60 70 80 90 100'
'set ccolor 1'
'd smth9(z/9.80665)'
'print'
'disable print'
j=i-7
say j

'!gxeps -c -ia test.meta -o NOFOG_Anom-AOpos-500hPa-lag'j'.eps'

  i = i + 1 
endwhile

#!/usr/bin/env python
from ecmwfapi import ECMWFDataServer
import calendar

server = ECMWFDataServer()
for day in range(9, 25):
 edate="201601%02d"%(day)
 print ("######### ERA-interim  #########")
 print ('get data for ',edate,' (YYYYMMDD)' )
 print ("################################")


 server.retrieve({
     "stream": "oper",
     "levtype" : "pl",
     "param": "60.128/129.128/130.128/131/132/133.128/135.128/138.128/155.128/157.128",
     "dataset" : "era5",
     "expver": "1",
     "time" : "00:00:00/03:00:00/06:00:00/09:00:00/12:00:00/15:00:00/18:00:00/21:00:00",
     "levelist": "1/2/3/5/7/10/20/30/50/70/100/125/150/175/200/225/250/300/350/400/450/500/550/600/650/700/750/775/800/825/850/875/900/925/950/975/1000",
     "date" : "%s"%(edate),
     "type" : "an",
     "class" : "ea",
     "grid": "0.3/0.3",               # Optional. The horizontal resolution in decimal degrees. If not set, the archived grid as specified in the data documentation is used. 
                                     # given as negative numbers. Requires "grid" to be set to a regular grid, e.g. "0.3/0.3".
     "area": "90/-180/-90/180",

     "format" : "grib2",
     "target" : "ERA5_level_global_%s.grib2"%(edate)
      })
            

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
     "levtype" : "sfc",
     "param": "134.128/139.128/151.128/159.128/165.128/166.128/167.128/168.128/170.128/183.128/236.128/246.228/247.228",
     "dataset" : "era5",
     "expver": "1",
     "time" : "00:00:00/03:00:00/06:00:00/09:00:00/12:00:00/15:00:00/18:00:00/21:00:00",
     "date" : "%s"%(edate),
     "type" : "an",
     "class" : "ea",
     "grid": "0.3/0.3",               # Optional. The horizontal resolution in decimal degrees. If not set, the archived grid as specified in the data documentation is used. 
                                     # given as negative numbers. Requires "grid" to be set to a regular grid, e.g. "0.3/0.3".
     "area": "90/-180/-90/180",

     "format" : "grib2",
     "target" : "ERA5_sfc_global_%s.grib2"%(edate)
      })

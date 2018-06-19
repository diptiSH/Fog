#!/usr/bin/env python
from ecmwfapi import ECMWFDataServer
import calendar

server = ECMWFDataServer()
for year in range(1979, 2017):
 print ("YEAR" , year )
 for month in range(1,2):
  lastday1=calendar.monthrange(year,month)
  lastday=lastday1[1]
  bdate="%s%02d01"%(year,month)
  edate="%s%02d%s"%(year,month,lastday)
  print ("######### ERA-interim  #########")
  print ('get data from ', bdate,' to ',edate,' (YYYYMMDD)' )
  print ("################################")


  server.retrieve({
      "stream": "oper",
      "levtype" : "pl",
      "param": "131.128/132.128/129.128/135.128/130.128",
      "dataset" : "interim",
      "step":"0",
      "grid" : "1.5/1.5",
      "time" : "00",
      "levelist": "500/700/850/925/950/1000",
      "date" : "%s/to/%s"%(bdate,edate),
      "type" : "an",
      "class" : "ei",
      "format" : "netcdf",
      "target" : "ERA_data_00Z_%s_%s.nc"%(bdate,edate)
       })

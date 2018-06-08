begin

;fin=addfile("/media/Seagate Backup Plus Drive/2018/fog-files-D/DATA/ERA3D-00UTC-1.5deg-dec-jan-1979-2016.nc","r")

;z500=fin->z(:,{500},:,:)

;printVarSummary(z500)

;;;;;;;;;;;;;;Add file

fin=addfile("/home/iitm/Documents/Data/ERA-1.5/ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")
fanom=addfile("/home/iitm/Documents/Data/ERA-1.5/Daily_anomalies/ERAANOM-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")
;;;;;;;;;;;;;;Read data over region of interest and know the dimensions etc and convert it to gpm
anomZ500g=fanom->z(:,{30:90},{30:100})
anomZ500=anomZ500g
anomZ500=anomZ500g/9.81

z500g=fin->z(:,{30:90},{30:100})
z500=z500g
z500=z500g/9.81   ;convert to gpm
;printVarSummary(z500)

time=z500&time
lat=z500&latitude
lon=z500&longitude

;print(lat)


ntime=dimsizes(time)
nlat=dimsizes(lat)
nlon=dimsizes(lon)

;print(ntime)
;print(nlat)
;print(nlon)

;;;;;;;;;;;;;;initialize delta
del=(/-5.0,-2.5,0,2.5,5.0/)

blocked_longs=new(2356,"integer")
blocked_longs=0

;;;;;;;; time loop
do t=0,ntime-1

bflag=0   ;;;;;;;;;;;;;flag to check consecutive (5 for 2.5 grid) 8 longitudes showing blocking
bLons=0
;;;;;;;;;; longitude loop
   do lo=0,nlon-1
   sgrad=todouble(0.0)  ;initialize southern and northern gradients
   ngrad=todouble(0.0)
   
;;;;;;;;;;;;;;;;;;latitude loop


            do lati=0,dimsizes(del)-1
                   north=80+del(lati)
                   mid=60+del(lati)
                   south=40+del(lati)
                  ; z1=z500(t,{north},lo)
                  ;  print(north)
                  ;  print(z1)
                   sgrad=(z500(t,{mid},lo)-z500(t,{south},lo))/20.0
                   ngrad=(z500(t,{north},lo)-z500(t,{mid},lo))/20.0
;;;;;;;;;;;;;;;;;; chk blocking criterion
                   if(ngrad.lt.-10.0 .and. sgrad.gt.0.0 .and. anomZ500(t,{mid},lo).gt.0.0)then
                     ; print("blocking present")
                     ; print(time(t))
                     ; print(lon(lo))
                     bLons=bLons+1
                     bflag=1
;;;;;;;;;;;;;;;;;; chk blocking number of longitude criterion
                      if (bLons .ge. 8 ) then 
                          print("blocking present")
                          print(time(t))
                          utc_date = cd_calendar(time(t), 0)
                          print(utc_date)
                         
                      end if
                   else 
                      blons=0
                   end if
          
            end do
    
       ; print(z500(t,:,lo))      

   end do

end do


end


 ; local maxima
    ;     max_val=max( z500(t,:,lo) )
    ;     max_lat=maxind( z500(t,:,lo) )
     ;    print(z500(t,:,lo))
     ;    print(max_val)
     ;    print(max_lat)
     ;    print(z500(t,max_lat,lo))




;n=new(ntime,"integer")
;n=0
;do t=0,ntime-1
     
      
;   do lo=0,nlon-1
 ;      sgrad=todouble(0.0)
  ;     ngrad=todouble(0.0)
               ; print(z500(t,:,lo))
                 
   ;     	do l=1,nlat-2
                
    ;             sgrad=z500(t,l,lo)-z500(t,l-1,lo) 
     ;            ngrad=z500(t,l+1,lo)-z500(t,l,lo)
      ;           if(ngrad.lt.0 .and. sgrad.gt.0)then
                  ;  print(l)
                 ;  print(t)
       ;            n(t)=n(t)+1
        ;         end if
             
	 ;       end do
     ; print(n)

  ; end do
;end do

;asciiwrite("test",n)
;print(maxind(n))

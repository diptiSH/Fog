
begin

;;;;;;;;;;;;;;Add file

fin=addfile("/home/iitm/Documents/Data/ERA-1.5/ERADAILY-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")
fanom=addfile("/home/iitm/Documents/Data/ERA-1.5/Daily_anomalies/ERAANOM-1.5deg-500hPa-Dec-Jan-1979-2016.nc","r")
;;;;;;;;;;;;;;Read data over region of interest and know the dimensions etc and convert it to gpm
anomZ500g=fanom->z(:,{15:75},{30:100})
anomZ500=anomZ500g
anomZ500=anomZ500g/9.81 ;convert to gpm

z500g=fin->z(:,{15:75},{30:100})
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
print(nlon)

;exit

;;;;;;;;;;;;;;initialize delta
del=(/-5.0,-2.5,0,2.5,5.0/)


;;;;;;;;;;;;;;;;;initialize blocking matrix
;blockmat=new((/ntime,nlon/),"logical")
blockmat=new((/ntime,nlon/),"integer",0)
latmat=new((/ntime,nlon/),"float",999.999)
;blockmat=False

;;;;;;;; time loop
do t=0,ntime-100

;bLons=0
;;;;;;;;;; longitude loop
   do lo=0,nlon-1
   sgrad=todouble(0.0)  ;initialize southern and northern gradients
   ngrad=todouble(0.0)
   
;;;;;;;;;;;;;;;;;;latitude loop


            do lati=0,dimsizes(del)-1
                   north=70+del(lati)
                   mid=50+del(lati)
                   south=30+del(lati)
                  ; z1=z500(t,{north},lo)
                  ;  print(north)
                  ;  print(z1)
                   sgrad=(z500(t,{mid},lo)-z500(t,{south},lo))/20.0
                   ngrad=(z500(t,{north},lo)-z500(t,{mid},lo))/20.0
;;;;;;;;;;;;;;;;;; chk blocking criterion
                   if(ngrad.lt. -10.0 .and. sgrad.gt.0.0 .and. anomZ500(t,{mid},lo).gt.0.0)then
                     ; print("blocking present")
                     ; print(time(t))
                     ; print(lon(lo))
                    ; bLons=bLons+1
                     ;   blockmat(t,lo)=True
                            blockmat(t,lo)=1
                        latmat(t,lo)=mid
;;;;;;;;;;;;;;;;;; chk blocking number of longitude criterion
                    ;  if (bLons .ge. 8 ) then 
                        ;  print("blocking present")
                         ; print(time(t))
                         ; utc_date = cd_calendar(time(t), 0)
                        ;  print(utc_date)
                         
                     ; end if
                 ;  else 
                   ;   blons=0
                   end if
          
            end do
    
       ; print(z500(t,:,lo))      

   end do

end do
   option        = True
  option@row    = False
  option@tspace = 0
  option@fout   = "file5.i.txt"
  option@title  = "integer data with no missing values"


  write_matrix (blockmat, "47I2", option)

exit

;;;;;;;;;;;;;;; Calculating blocking index using blocking matrix


;;;;;;;; time loop
do t=0,2000;ntime-1

f=0
;cnt=0
;;;;;;;; longitude loop
  do lo=0,nlon-1
     if(blockmat(t,lo).eq.True .and. f.eq.0)then
        startlo=lo
        f=1
        ;print(startlo)
	;;;;;;;;;;;;;;;;;;;if one longitude is blocked then chk next till find unblocked longitude       
		cnt=0
		if(startlo.lt.nlon-2)
			l=startlo+1
		
			do while(blockmat(t,l).eq.False .and. l.lt.nlon-1)
				 cnt=cnt+1 
				 l=l+1
			end do
			if(cnt.ge.8)then
				endlo=l
                            
                             ;;;;;;;;;;;;;;;;;;;; get blocking centre longitude
                         
                                 maxBl=avg(z500(t,:,startlo))
                                 maxlo=lon(startlo)
                                 maxla=latmat(t,startlo)
                                 do j=startlo+1,endlo
                                    if(maxBl .lt. avg(z500(t,:,j))) then
                                       maxBl=avg(z500(t,:,j))
                                       maxlo=lon(j)
                                      ; maxla=latmat(t,j)
                                    end if
                                 end do
            ;;;;;;;;;;;;;;;;;;;; get blocking centre latitude
                         
                                ; maxBl=avg(z500(t,0,:))
                                ; maxla=lat(0)
                                ; do k=1,nlat-1
                                 ;   if(maxBl .lt. avg(z500(t,k,:))) then
                                  ;     maxBl=avg(z500(t,k,:))
                                  ;     maxla=lat(k)
                                  ;  end if
                                 ;end do
                                
				;print(lon(startlo))
                                ;print(maxlo)
				;print(lon(endlo))
                                ;print(maxla)
                                print(t)
            
			end if
		end if
      else
        f=0
     end if

  
    

  end do
      

        
   ;v print(cnt)
  

end do



;asciiwrite("test",blockmat)

end

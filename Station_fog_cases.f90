program fog_properties
implicit none
character ( len =50) :: str1 , str2 , str3,  str4, str5, str6, str7, str8, str13, str18, str19
INTEGER, PARAMETER :: maxrecs = 100000
INTEGER :: J, NR, ios, year, month, fog_ind,  f, no_files, num, day,i,k,mon
real :: temp,tempD,wind,maxtemp,mintemp
CHARACTER(LEN=100) :: filename
CHARACTER(LEN=1) :: junk 
Character(len=50),DIMENSION(:),Allocatable::fog_days
Logical,Dimension(20,1975:2015,1:12,1:31)::fog_mat
real,Dimension(20,1975:2015,1:12,1:31)::fog_mat_lat,fog_mat_lon
integer,Dimension(20,1975:2015,1:12,1:31)::fog_mat_int,fog_mat_temp,fog_mat_tempD,fog_mat_wind,fog_mat_maxtemp,fog_mat_mintemp
real, Dimension(20) :: lat, lon
real::lat_range, lon_range
lat=(/31.71,30.333,29.179,28.585,26.824,26.293,26.761,25.16,25.441,25.591, &
24.65,24.744,23.287,23.178,23.433,22.722,22.767,21.092,21.914,20.244 &
/)

lon=(/74.797,76.467,75.755,77.206,75.812,78.228,80.889,75.846,81.735,85.088, &
77.317,84.951,77.337,80.052,85.4,75.801,81.9,79.047,84.05,85.818 &
/)
fog_mat=.False.
no_files=20
fog_mat_int=0
!write(*,*)fog_mat

open(3,file="fog_matrix_all.txt")
open(4,file="fog_matrix_ind.txt")
open(75,file="fog_matrix_temp.txt")
open(76,file="fog_matrix_tempD.txt")
open(77,file="fog_matrix_wind.txt")
open(78,file="fog_matrix_maxtemp.txt")
open(80,file="fog_matrix_maxtemp_1day_bef.txt")
open(79,file="fog_matrix_mintemp.txt")




do f=1,no_files




if(f<10) then

write (filename, "(A51,I1,A4)") "/home/dipti/Documents/data/north_india_stations_20/",f,".txt"

else 

write (filename, "(A51,I2,A4)") "/home/dipti/Documents/data/north_india_stations_20/",f,".txt"

end if


write(2,*)filename

open(1,file=filename)

!write(*,*)'tested ok'

read(1 ,*) str1
!write (* ,*) str1

!Determine total number of lines in file
NR = 0

DO J=1,maxrecs
 READ(1,*,IOSTAT=ios) junk
 IF (ios /= 0) EXIT
 IF (J == maxrecs) THEN
 write(*,*) 'Error: Maximum number of records exceeded...'
 write(*,*) 'Exiting program now...'
 STOP
 ENDIF
 NR = NR + 1
ENDDO
REWIND(1) 


!Now read data 
DO J=1,NR+1
  fog_ind=0
  year=0
  month=0
  day=0
  write(*,*)j
  READ(1,*) str1,str1,str2,str4,str1,str5,str1,str6,str1,str1,str1,str7,str13,str1,str1,str1,str1,str18,str19,str1,str1,str3
  
	if(J>1)then
                write(*,*)str4
		read(str2,'(i4,i2,i2)')year,month,day
		
                read(str4,*)temp
                read(str5,*)tempD
                read(str13,*)wind
                read(str18,*)maxtemp
                read(str19,*)mintemp
                  
                  temp = (temp-32)*5.0/9.0
                  tempD = (tempD-32)*5.0/9.0
                   maxtemp = (maxtemp-32)*5.0/9.0
                  mintemp = (mintemp-32)*5.0/9.0
        
        


		if((year>=1975).and.(year<=2015)) then
		            if((month.eq.12).or.(month.eq.1))then
					!get fog days
                              fog_mat_maxtemp(f,year,month,day)=maxtemp
					read(str3,'(i1)')fog_ind
					if(fog_ind.ne.0)then
                                        
		       fog_mat(f,year,month,day)=.true.
                       fog_mat_int(f,year,month,day)=fog_ind
                       fog_mat_temp(f,year,month,day)=temp	
                       fog_mat_tempD(f,year,month,day)=tempD
                       	
                       fog_mat_mintemp(f,year,month,day)=mintemp	
                       fog_mat_wind(f,year,month,day)=wind		
                       fog_mat_lat(f,year,month,day)=lat(f)	
                       fog_mat_lon(f,year,month,day)=lon(f)		
                      								
                                          write(*,*)f,year,month,day, fog_mat(f,year,month,day)  

					else 
                                         fog_mat(f,year,month,day)=.false.
                                         fog_mat_int(f,year,month,day)=fog_ind
                                         fog_mat_lat(f,year,month,day)=0.0
                                         fog_mat_lon(f,year,month,day)=0.0
              
					end if
                            
		             end if

		end if

	end if
 
!write(*,*)num
END DO 
!write(*,*)fog_days

close(1)

end do
open(5,file="fog_dates_gt_10.txt")
open(6,file="Java_dates_feeder.txt")
do i=1975,2015
 do j=1,2
  if(j.eq.2) then
     mon=12
     else
     mon=j
   end if	
   do k=1,31
!if(sum(fog_mat_int(:,i,mon,k)).ne.0)then
write(3,*)i,mon,k,fog_mat_int(:,i,mon,k)
lat_range=(maxval(fog_mat_lat(:,i,mon,k))-minval(fog_mat_lat(:,i,mon,k),MASK = fog_mat_lat(:,i,mon,k) .GT.0))
lon_range=(maxval(fog_mat_lon(:,i,mon,k))-minval(fog_mat_lon(:,i,mon,k),MASK = fog_mat_lon(:,i,mon,k) .GT.0))

if(sum(fog_mat_int(:,i,mon,k)).gt.9)then
write(5,*)i,mon,k,sum(fog_mat_int(:,i,mon,k))
write(75,*)i,mon,k,fog_mat_temp(:,i,mon,k)
write(76,*)i,mon,k,fog_mat_tempD(:,i,mon,k)
write(77,*)i,mon,k,fog_mat_wind(:,i,mon,k)
write(78,*)i,mon,k,fog_mat_maxtemp(:,i,mon,k)
write(79,*)i,mon,k,fog_mat_mintemp(:,i,mon,k)
if((mon.eq.1).and.(k.eq.1))then
write(80,*)i-1,"12","31",fog_mat_mintemp(:,i-1,12,31)
else
write(80,*)i,mon,k-1,fog_mat_maxtemp(:,i,mon,k-1)
end if
write(6, "(I4,1X,I2.2,1X,I2.2,A2,1X,I2.2,A2)")i,mon,k-1,"00",k+1,"12"
write(4,'(i4,i2.2,i2.2,1x,f8.3)')i,mon,k,lat_range*lon_range
end if
!end if
   end do
 end do 
end do
close(3)
close(4)
close(6)

end program fog_properties

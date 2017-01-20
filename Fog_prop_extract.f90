program fog_properties
implicit none
character ( len =50) :: str1 , str2 , str3,  str4, str5, str6, str7, str8, str13, str18, str19
INTEGER, PARAMETER :: maxrecs = 100000
INTEGER :: J, NR, ios, year, month, fog_ind,  f, no_files, num, day,i,k,mon,l
real :: temp,tempD,wind,maxtemp,mintemp
CHARACTER(LEN=100) :: filename
CHARACTER(LEN=1) :: junk 
CHARACTER(LEN=10) :: date 
Character(len=50),DIMENSION(:),Allocatable::fog_days
real,Dimension(20,1975:2015,1:12,1:31)::fog_mat_temp,fog_mat_tempD,fog_mat_wind,fog_mat_maxtemp,fog_mat_mintemp
real,Dimension(20,1:62)::dayClim_temp,dayClim_tempD,dayClim_wind,dayClim_maxtemp,dayClim_mintemp

no_files=20

open(75,file="fog_matrix_temp.txt")
open(76,file="fog_matrix_tempD.txt")
open(77,file="fog_matrix_wind.txt")
open(78,file="fog_matrix_maxtemp.txt")
open(79,file="fog_matrix_mintemp.txt")




do f=1,no_files




if(f<10) then

write (filename, "(A51,I1,A4)") "/home/dipti/Documents/data/north_india_stations_20/",f,".txt"

else 

write (filename, "(A51,I2,A4)") "/home/dipti/Documents/data/north_india_stations_20/",f,".txt"

end if


!write(2,*)filename

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
 ! write(*,*)j
  READ(1,*) str1,str1,str2,str4,str1,str5,str1,str6,str1,str1,str1,str7,str13,str1,str1,str1,str1,str18,str19,str1,str1,str3
	if(J>1)then
                !write(*,*)str4
		read(str2,'(i4,i2,i2)')year,month,day
                read(str4,*)temp
                read(str5,*)tempD
                read(str13,*)wind
                read(str18,*)maxtemp
                read(str19,*)mintemp
                ! CHK FOR MISSING VALUES 
                  if((temp-999.9).lt.-1.0) then  
                    temp = (temp-32)*5.0/9.0
                  else
                     temp = 0.0
                  end if
                  if((tempD-999.9).lt.-1.0) then 
                    tempD = (tempD-32)*5.0/9.0
                  else
                    tempD = 0.0
                   ! write(*,*)"test miss value"
                  end if
                  if((maxtemp-999.9).lt.-1.0) then 
                    maxtemp = (maxtemp-32)*5.0/9.0
                  else
                    maxtemp = 0.0
                    !write(*,*)"test miss value"
                    !write(*,*)filename
                    !write(*,*)year,month,day
                  end if
                  if((mintemp-999.9).lt.-1.0) then 
                   mintemp = (mintemp-32)*5.0/9.0
                  else
                   mintemp = 0.0
                  end if
                  if((wind-999.9).gt.-1.0)then 
                     wind = 0.0
                  end if
        
		if((year>=1975).and.(year<=2015)) then
		            if((month.eq.12).or.(month.eq.1))then
                               fog_mat_maxtemp(f,year,month,day)=maxtemp
                               fog_mat_temp(f,year,month,day)=temp	
                               fog_mat_tempD(f,year,month,day)=tempD
                       	       fog_mat_mintemp(f,year,month,day)=mintemp	
                               fog_mat_wind(f,year,month,day)=wind	
			    end if
		end if
	end if
 
!write(*,*)num
END DO 

close(1)

end do

!extract dec jan temp, min temp, max temp, dew temp and wind for each day
do i=1979,2015
 do j=1,2
  if(j.eq.2) then
     mon=12
     else
     mon=j
   end if	
   do k=1,31
 	write (date, "(I4.4,A1,I2.2,A1,I2.2)")i,"-",mon,"-",k
	write(75,*)date,fog_mat_temp(:,i,mon,k)
	write(76,*)date,fog_mat_tempD(:,i,mon,k)
	write(77,*)date,fog_mat_wind(:,i,mon,k)
	write(78,*)date,fog_mat_maxtemp(:,i,mon,k)
        write(79,*)date,fog_mat_mintemp(:,i,mon,k)
	!write(79,'(20(f9.4),1X)')fog_mat_mintemp(:,i,mon,k)
   end do
 end do 
end do
close(75)
close(76)
close(77)
close(78)
close(79)

! get daily climatology

open(65,file="dayClim_temp.txt")
open(66,file="dayClim_tempD.txt")
open(67,file="dayClim_wind.txt")
open(68,file="dayClim_maxtemp.txt")
open(69,file="dayClim_mintemp.txt")

i=1
do j=1,2
  if(j.eq.2) then
     mon=12
     else
     mon=j
   end if	
   do k=1,31
      do l=1,20
 	dayClim_temp(l,i)=sum(fog_mat_temp(l,:,mon,k))/38.0
        dayClim_tempD(l,i)=sum(fog_mat_tempD(l,:,mon,k))/38.0
        dayClim_maxtemp(l,i)=sum(fog_mat_maxtemp(l,:,mon,k))/38.0
        dayClim_mintemp(l,i)=sum(fog_mat_mintemp(l,:,mon,k))/38.0
        dayClim_wind(l,i)=sum(fog_mat_wind(l,:,mon,k))/38.0
       end do
       i=i+1
   end do
 end do 
 do k=1,62
write(65,*)dayClim_temp(:,k)
write(66,*)dayClim_tempD(:,k)
write(67,*)dayClim_wind(:,k)
write(68,*)dayClim_maxtemp(:,k)
write(69,*)dayClim_mintemp(:,k)
end do
close(65)
close(66)
close(67)
close(68)
close(69)

end program fog_properties

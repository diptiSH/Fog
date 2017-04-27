program fog_properties
implicit none
character ( len =50) :: str1 , str2 , str3,  str4, str5, str6, str7, str8, str13, str18, str19,strSLP
INTEGER, PARAMETER :: maxrecs = 100000
INTEGER :: J, NR, ios, f, no_files, fog_ind,year,month,day
real ::temp,tempD,slp,speed,tdc,tc,rh
CHARACTER(LEN=1) :: junk 
CHARACTER(LEN=100) :: filename
real,Dimension(30,1979:2016,1:12,1:31)::fog_mat_tempD,fog_mat_speed,fog_mat_temp,fog_mat_slp,fog_mat_rh
integer,Dimension(30,1979:2016,1:12,1:31)::fog_mat_int


temp=0
tempD=0
slp=0
speed=0
tdc=0
tc=0
rh=0

no_files=30

do f=1,no_files




if(f<10) then

write (filename, "(A49,I1,A4)") "/home/user/Documents/work/North_india_30Stations/",f,".txt"

else 

write (filename, "(A49,I2,A4)") "/home/user/Documents/work/North_india_30Stations/",f,".txt"

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

write(*,*)NR



DO J=1,NR
  fog_ind=0
  year=0
  month=0
  day=0
 
 ! write(*,*)j
  READ(1,*) str1,str1,str2,str4,str1,str5,str6,strSLP,str1,str1,str1,str7,str1,str13,str1,str1,str1,str18,str19,str1,str1,str3
  
	if(J>1)then
                !write(*,*)str4
		read(str2,'(i4,i2,i2)')year,month,day
		 read(str4,*)temp
                 read(str5,*)tempD
                 read(strSLP,*)slp
                 read(str13,*)speed
                 read(str3,'(i1)')fog_ind
                tdc=((tempD-32)*5/9)
                tc=((temp-32)*5/9)
                rh=100*(exp((17.625*tdc)/(243.04+tdc))/exp((17.625*tc)/(243.04+tc)))
                


		if((year>=1979).and.(year<=2016)) then
		            if((month.eq.12).or.(month.eq.1))then
                                    if(fog_ind.eq.0)then
 			           fog_mat_temp(f,year,month,day)=temp	
                                   fog_mat_speed(f,year,month,day)=speed
                                   fog_mat_tempD(f,year,month,day)=tempD
                                   fog_mat_slp(f,year,month,day)=slp
                                   fog_mat_rh(f,year,month,day)=rh
                                   fog_mat_int(f,year,month,day)=fog_ind
                                   end if	
		             end if

		end if

	end if
 
!write(*,*)num
END DO 
!write(*,*)fog_days

close(1)


end do


Write(*,*)minval(fog_mat_temp,MASK=fog_mat_temp .gt. 0.0 .and. fog_mat_temp .lt. 9999.9),  &
minval(fog_mat_speed,MASK=fog_mat_speed .gt. 0.0 .and. fog_mat_speed  .lt.  999.9),  &
minval(fog_mat_tempD,MASK=fog_mat_tempD .gt. 0.0 .and. fog_mat_tempD .lt. 9999.9), &
minval(fog_mat_slp,MASK=fog_mat_slp .gt. 0.0 .and. fog_mat_slp .lt. 9999.9)
Write(*,*)maxval(fog_mat_temp,MASK=(fog_mat_temp .gt. 0.0 .and. fog_mat_temp .lt. 9999.9)),  &
 maxval(fog_mat_speed,MASK=(fog_mat_speed .gt. 0.0 .and. fog_mat_speed .lt. 999.9)),  &
maxval(fog_mat_tempD,MASK=(fog_mat_tempD .gt. 0.0 .and. fog_mat_tempD .lt. 9999.9)), &
maxval(fog_mat_slp,MASK=(fog_mat_slp .gt. 0.0 .and. fog_mat_slp .lt. 9999.9))





end program fog_properties

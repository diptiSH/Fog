program metar_input
implicit none
character(len=200)::testString
INTEGER, PARAMETER :: maxrecs = 30000000
Integer :: NR,ios,coInd,stlen
Integer :: J,K
Integer :: y,m,d,t,windD, vis,lca,lct,lcbh,tca,pw,pastw
Real :: windS,temp,dtemp
CHARACTER(LEN=1) :: junk 
CHARACTER(LEN=30) :: stname

open(10,file="/home/user/Documents/Data/imd_raw/Metar_data/metar.csv")
NR=0
!!!!!!!!!!! Get total number of records
DO J=1,maxrecs
	 READ(10,*,IOSTAT=ios) junk
	 IF (ios /= 0) EXIT
	 IF (J == maxrecs) THEN
	 write(*,*) 'Error: Maximum number of records exceeded...'
	 write(*,*) 'Exiting program now...'
	 STOP
	 ENDIF
	 NR = NR + 1
 ENDDO
REWIND(10)
write(*,*)NR
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! read data
DO J=1,484564!NR
	READ(10,'(A200)') testString
	write(*,*)testString
	!!!!!!!!!!!!!!!!!!!!!!!!!!! get comma seperated values
    Do K=1,32
        stlen=LEN_TRIM(ADJUSTL(testString)) 
		coInd=index(testString,",")
		!!!!!!!!get station name
		if(K.eq.1)then
		 stname=testString(1:coInd-1)
		 write(*,*)stname
		end if
		!!!!!!!!get year
		if(K.eq.3)then
		 read(testString(1:coInd-1),*)y
		 write(*,*)y
		end if
		!!!!!!!!get month
		if(K.eq.4)then
		 read(testString(1:coInd-1),*)m
		 write(*,*)m
		end if
		!!!!!!!!get date
		if(K.eq.5)then
		 read(testString(1:coInd-1),*)d
		 write(*,*)d
		end if
		!!!!!!!!get time
		if(K.eq.6)then
		 read(testString(1:coInd-1),*)t
		 write(*,*)t
		end if
		!get wind direction
        if(K.eq.7 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)windD
		 write(*,*)windD
		end if
		!get wind speed
        if(K.eq.8 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)windS
		 write(*,*)windS
		end if
		!get visibility
        if(K.eq.10 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)vis
		 write(*,*)vis
		end if
		!get low cloud amout
        if(K.eq.13 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)lca
		 write(*,*)lca
		end if
        !get low cloud type
        if(K.eq.14 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)lct
		 write(*,*)lct
		end if
		!get low cloud base height
		if(K.eq.15 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)lcbh
		 write(*,*)lcbh
		end if
        !get low cloud base height
		if(K.eq.15 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)lcbh
		 write(*,*)lcbh
		end if
        !get temperature
		if(K.eq.25 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)temp
		 write(*,*)temp
		end if
        !get dew temperature
		if(K.eq.27 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)dtemp
		 write(*,*)dtemp
		end if
		!get total cloud
		if(K.eq.30 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)tca
		 write(*,*)tca
		end if
        !get present weather
		if(K.eq.31 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)pw
		 write(*,*)pw
		end if
        !get past weather
		if(K.eq.32 .and. coInd.gt.1)then
		 read(testString(1:coInd-1),*)pastw
		 write(*,*)pastw
		end if

		testString=testString(coInd+1:stlen)
		!write(*,*)coInd
		!write(*,*)testString
    end do
ENDDO
close(10)
end program metar_input



	

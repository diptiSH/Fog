program Input_decision_tree
IMPLICIT NONE
INTEGER, PARAMETER :: maxrecs = 30000000
Integer :: J, NR, ios,IndexNo,OldIndex, nfiles, m, old,year,mn,dt,hr
CHARACTER(LEN=1) :: junk 
CHARACTER(LEN=7) :: fln
CHARACTER(LEN=3) :: fn  
CHARACTER(LEN=133) :: str 
Integer, Allocatable :: ObsNo(:)
CHARACTER(LEN=133), Allocatable :: Obsstr(:,:)
real::slp,dbt,wbt,dpt,fff,rf
integer::rh,vv,dd,aw
character(LEN=1) ::flable


open(1,file="hr_data.txt")
NR=0
!!!!!!!!!!! Get total number of records
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

OldIndex=05211
nfiles=1

!!!!!!!!!!! Get total number of files
DO J=1,NR
		read(1,'(A133)')str
		!write(*,*)str
                read(str(1:5),*)IndexNo
		if(OldIndex .ne. IndexNo) then
                  ! write(*,*)IndexNo
                   OldIndex=IndexNo
                   nfiles=nfiles+1
                end if
end do
write(*,*)nfiles
REWIND(1)

!!!!!!!!!!! Get total number of obs for each file
allocate(ObsNo(nfiles))
nfiles=1
ObsNo=1
OldIndex=05211
write(*,*)ObsNo

DO J=1,NR
		read(1,'(A133)')str
		!write(*,*)str
                read(str(1:5),*)IndexNo
		if(OldIndex .ne. IndexNo) then
                  ! write(*,*)IndexNo
                  ! write(*,*)ObsNo
                  ! ObsNo(nfiles)=1
                   OldIndex=IndexNo
                   nfiles=nfiles+1
                else
                    if(J .ne. 1) then
                    ObsNo(nfiles)=ObsNo(nfiles)+1
                    end if
                end if
end do
REWIND(1)

open(5,file="test.txt")
old=1
do j=1,nfiles
   write(fn,'(I3.3)')j
   fln=fn//'.txt'
  open(6,file=fln)
   do m=old,old+ObsNo(j)-1
      read(1,'(A133)')str
      !write(6,*)str
      read(str(1:5),*)IndexNo
      !write(*,*)IndexNo
      read(str(7:10),*)year
      !write(*,*)year
      read(str(12:13),*)mn
      !write(*,*)mn
      read(str(15:16),*)hr
      !write(*,*)hr
     read(str(18:19),*)dt
    !write(*,*)dt 
    if(mn.eq.1 .or. mn.eq.12) then
      if(str(21:26).ne."")then
       read(str(21:26),*)slp
       !write(*,*)slp
      else
       slp=99.92 
      end if
      if(str(35:40).ne."")then
       read(str(35:40),*)dbt
       !write(*,*)dbt
      else
        dbt=99.92
      end if
     if(str(41:45).ne."")then
       read(str(41:45),*)wbt
       !write(*,*)wbt
      else
        wbt=99.92
      end if
      if(str(47:51).ne."")then
       read(str(47:51),*)dpt
       !write(*,*)dpt
      else
        dpt=99.92
      end if
    if(str(53:55).ne."")then
       read(str(53:55),*)rh
       !write(*,*)rh
      else
        rh=999
      end if
    if(str(62:63).ne."")then
       read(str(62:63),*)dd
       !write(*,*)dd
      else
        dd=999
      end if
	if(str(65:67).ne."")then
       read(str(65:67),*)fff
       !write(*,*)fff
      else
        fff=99.92
      end if
      if(str(69:70).ne."")then
       read(str(69:70),*)aw
       !write(*,*)aw
      else
        aw=999
      end if
     if(str(72:73).ne."")then
       read(str(72:73),*)vv
       !write(*,*)vv
          if(VV .gt. 93) then
          flable="F"
          else
          flable="T"
          end if
      else
        flable="m"
        vv=999
      end if
      if(str(111:115).ne."")then
       read(str(111:115),*)rf
       !write(*,*)rf
      else
        rf=99.92
      end if
!     write(6,'(6.1,A1,3(5.1,A1),I3,A1,)')slp,dbt,wbt,dpt,rh,dd,fff,aw,rf,vv
   !  write(*,*)dbt
 write(6,'(f6.1,A1,f6.2,A1,f6.2,A1,f6.2,A1,I3.3,A1,I3.3,A1,f6.2,A1,A1)')slp,",",dbt,",",wbt,",",dpt,",",rh,",",aw,",",rf,",",flable
    ! write(6,*)slp,",",dbt,",",wbt,",",dpt,",",rh,",",aw,",",rf,",",flable
    end if
   end do	
   close(6)
   old=old+ObsNo(j)
!write(*,*)ObsNo(j)
end do
close(5)
close(1)

end program Input_decision_tree

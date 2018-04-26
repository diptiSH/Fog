begin 

 ;fname  = "date"        ;input Data
 fname  = "allDate"        ;input Data
                                       ; open "data " as 2-dim array
  ;data   = asciiread (fname,(/105,3/), "integer")
data   = asciiread (fname,(/2139,3/), "integer")

;  print(data)

   AOdata   = readAsciiTable ("AO",4, "float",0)
  
print(AOdata)
 ; combined_data=new((/105/),"float")
combined_data=new((/2139/),"float")  

do i=0,23253
  do j=0,2138
    ;print(i)
   ;print(j)
   if ((AOdata(i,0).eq.data(j,0)).and.(AOdata(i,1).eq.data(j,1)).and.(AOdata(i,2).eq.data(j,2))) then
          combined_data(j)=AOdata(i,3)
     
 end if
  end do
  
  end do
asciiwrite ("AllDatesAO.txt" , combined_data)

end 

begin 

 fname  = "date"        ;input Data
                                       ; open "data " as 2-dim array
  data   = asciiread (fname,(/105,3/), "integer")

;  print(data)

   AOdata   = readAsciiTable ("NAO",4, "float",0)
  
print(AOdata)
  combined_data=new((/105/),"float") 

do i=0,24775
  do j=0,104
    ;print(i)
   ;print(j)
   if ((AOdata(i,0).eq.data(j,0)).and.(AOdata(i,1).eq.data(j,1)).and.(AOdata(i,2).eq.data(j,2))) then
          combined_data(j)=AOdata(i,3)
     
 end if
  end do
  
  end do
asciiwrite ("OneSigmafNAO11.txt" , combined_data)

end 

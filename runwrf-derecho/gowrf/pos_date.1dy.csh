#! /bin/csh -f 
#
# Dec 1, 2018 programm go forward 1 day.
# usage: pos_date.1dy.csh  yyyymmdd 

set date_s = $1

set top_m = (31 28 31 30 31 30 31 31 30 31 30 31)

set year_s = `echo $date_s | awk '{print substr($1,1,4)}'`
set month_s = `echo $date_s | awk '{print substr($1,5,2)}'` 
set day_s = `echo $date_s | awk '{print substr($1,7,2)}'` 

#-------------------------------- 
#-------------------------------- 

set month_s = `expr $month_s + 0`
set year_s = `expr $year_s + 0`


    set day_n = `expr $day_s + 1`
# 
    if ( $day_n > $top_m[$month_s] ) then 
         set day_n = 1
         set month_n = `expr $month_s + 1`
         if ( $month_n == 13 ) then 
             set month_n = 1
             set year_n  = `expr $year_s + 1`
         else 
             if ( $month_n < 0 ) then
                 echo " CHECK ERROR "
             else 
                 set year_n  = $year_s;
             endif 
         endif 
                                
     else 
         set month_n = $month_s
         set year_n = $year_s
     endif 

    if ($day_n < 10) set day_n = 0$day_n
    if ($month_n < 10) set month_n = 0$month_n

    echo $year_n$month_n$day_n 

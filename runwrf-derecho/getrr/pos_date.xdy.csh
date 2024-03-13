#! /bin/csh -f 
#
# Devuelve la fecha (yyyymmdd) n dias despues despues de la
# proporcionada inicialmente. 
#
# Uso :
#
# next_date.v2.csh yyyymmdd number
#
# Salida : Siguiente fecha en el formato
#          yyyymmdd number 
#
# Dec 16, 2008  now the programm works for 1 day back too.

set exepath = /home/cmc542/2016/ATLAS/SIx/ 
set exepath = /glade/work/cmc542/2018/proj-WRFdust/wrf_gfs/
set exepath = $EXEPATH

set date_s = $1
set jump = $2 

set year_s = `echo $date_s | awk '{print substr($1,1,4)}'`
set month_s = `echo $date_s | awk '{print substr($1,5,2)}'` 
set day_s = `echo $date_s | awk '{print substr($1,7,2)}'` 

set yyyymmdd = $year_s$month_s$day_s

foreach fdd (`awk -v II=1 -v NN=$jump 'BEGIN{for(i=II;i<=NN;i++) {if(i<10) i="0"i;print i}}'`)
#  echo $fdd 
   set xdate = `$exepath/pos_date.1dy.csh $yyyymmdd` 
   set yyyymmdd = $xdate 
end 

echo $yyyymmdd 


#--

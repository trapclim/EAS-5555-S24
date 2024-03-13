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
#          yyyymmddhr number 
#
# Dec 16, 2008  now the programm works for 1 day back too.

set exepath = /home/cmc542/2016/ATLAS/SIx/ 
#-set exepath = /glade/work/cmc542/2018/proj-WRFdust/wrf_gfs/
set exepath = /glade/work/cmc542/2020/proj-wrfDrougth/scripts/wrf_run_phaI/

set date_s = $1
set jump = $2 

set year_s = `echo $date_s | awk '{print substr($1,1,4)}'`
set month_s = `echo $date_s | awk '{print substr($1,5,2)}'` 
set day_s = `echo $date_s | awk '{print substr($1,7,2)}'` 
set hour_s = `echo $date_s | awk '{print substr($1,9,2)}'` 

set yyyymmddss = $year_s$month_s$day_s$hour_s 

foreach fdd (`awk -v II=1 -v NN=$jump 'BEGIN{for(i=II;i<=NN;i++) {if(i<10) i="0"i;print i}}'`)
#  echo $fdd 
   set xdate = `$exepath/pos_date.1hr.csh $yyyymmddss` 
   set yyyymmddss = $xdate 
end 

echo $yyyymmddss

#--

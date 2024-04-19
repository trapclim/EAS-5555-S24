#! /bin/csh 
#
set files =  dates.loop.5dy.Oct.2015.txt
set files =  dates.loop.5dy.Oct.2016.txt
#----------activation part---------# 
set PWD = `pwd`
set USER = `whoami`
#----
set odatesf = odates.now.txt 
rm -rf $odatesf
#----
mkdir -p $PWD/TMP 
setenv OPATH0 /glade/derecho/scratch/${USER}/wrf-model/CFS-Rx_DATA_STORE

#----
# DATA from 2011 to 2023 
# https://www.ncei.noaa.gov/data/climate-forecast-system/access/operational-9-month-forecast/6-hourly-by-pressure/
#----

set nlines = `cat $files | wc -l`  

foreach ifile (`awk -v N=$nlines 'BEGIN {for(i=1;i<=N;i++) print i}'`)   
   echo $ifile
   set start_dateC = `cat $files | awk -v i=0 -v lin=$ifile '{i++;if (i==lin) print $1}'`    
   set end_date = `cat $files  | awk -v i=0 -v lin=$ifile '{i++;if (i==lin) print $2}'`
   echo $start_dateC >> $odatesf  
#----
echo "##---------------##" 
echo "##DATE CASE: " $start_dateC "  " $end_date  
set ENSs = (E1) 
#-set ENSs = (E1 E2 E3) 

foreach ens ($ENSs) 
   echo "## ENS:" $ens 

   set yymmddI = `$PWD/split_string.csh $start_dateC $end_date YYMMDDI`
   set utcI = `$PWD/split_string.csh $start_dateC $end_date HHI`
   set xinitrunC = ${yymmddI}${utcI}
#---
   set ini_time = `pos_date.xhr.csh $xinitrunC 0`

   set yy_x = `echo $ini_time | awk '{print substr($1,1,4)}'`
   set mm_x = `echo $ini_time | awk '{print substr($1,5,2)}'`
   set dd_x = `echo $ini_time | awk '{print substr($1,7,2)}'`
   set hr_x = `echo $ini_time | awk '{print substr($1,9,2)}'`

   set start_date  = "$yy_x-${mm_x}-${dd_x}_${hr_x}:00:00" 
   echo "###############"
   echo "###START DATE: " $start_date 
#
      echo "####time:    " $start_dateC $start_date $end_date $ens 
      
      get.4mo.CFS.qsub.ope.csh  $start_dateC $start_date $end_date  

#     exit 
#  end 
#  exit 
   
end 
#----ifile 
end 

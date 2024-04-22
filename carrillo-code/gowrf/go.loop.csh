#! /bin/csh 

set PWD = `pwd`
set USER = `whoami`
#----------activation part---------#
if ( $#argv < 1 ) then
   echo "Too few arguments: required at least a casename"
   echo "Try something like:"
   echo ">> go.loop.csh MyCaseNow"
   exit 1
endif
setenv runcase $1 

setenv OPATH0 /glade/derecho/scratch/${USER}/wrf-model/CFS-Rx_DATA_STORE
setenv OPATHR /glade/derecho/scratch/${USER}/wrf-model/CFS-Rx_DATA 
setenv Ndomains 1
#----------active=1,inactive=0-----# 
setenv cpcode 0
setenv cpcode 1
set getdata = 0
#---------------
set odatesf = odates.now.txt 
rm -rf $odatesf
#---
#---
set files = dates.txt
echo  "Running "$runcase
echo "with dates set in file '"$files"' ."
echo "Dates are set as:"
echo `cat $files`

#--- 

#echo "FILES: " $files 
#echo "SLEEP 1h 15min (4500) sec ... " 
#sleep 4500 

set nlines = `cat $files | wc -l`  

foreach ifile (`awk -v N=$nlines 'BEGIN {for(i=1;i<=N;i++) print i}'`)   
   echo $ifile
   set start_dateC = `cat $files | awk -v i=0 -v lin=$ifile '{i++;if (i==lin) print $1}'`    
   set end_date = `cat $files  | awk -v i=0 -v lin=$ifile '{i++;if (i==lin) print $2}'`
   echo $start_dateC >> $odatesf  
#----
echo "##---------------##" 
echo "##DATE CASE: " $start_dateC "  " $end_date  
set ENSs = (E1 E2 E3) 
#set ENSs = (E2 E2 E3) 
#set CU_params = (P1 P2 P3 P4 P5 P6) 
#set CU_params = (P7 P8 P9 P10 P11 P12) 
#set CU_params = (P7 P8 P9 P10 P11) 
set CU_params = (P1 P2 P3 P5 P6) 

foreach ens ($ENSs) 
   echo "## ENS:" $ens 

   set yymmddI = `$PWD/split_string.csh $start_dateC $end_date YYMMDDI`
   set utcI = `$PWD/split_string.csh $start_dateC $end_date HHI`
   set xinitrunC = ${yymmddI}${utcI}
#---
   if( $ens == "E1" ) then
       set ini_time = `pos_date.xhr.csh $xinitrunC 0`
   endif
   if( $ens == "E2" ) then
       set ini_time = `pos_date.xhr.csh $xinitrunC 6`
   endif
   if( $ens == "E3" ) then
       set ini_time = `pos_date.xhr.csh $xinitrunC 12`
   endif
   set yy_x = `echo $ini_time | awk '{print substr($1,1,4)}'`
   set mm_x = `echo $ini_time | awk '{print substr($1,5,2)}'`
   set dd_x = `echo $ini_time | awk '{print substr($1,7,2)}'`
   set hr_x = `echo $ini_time | awk '{print substr($1,9,2)}'`

   set start_date  = "$yy_x-${mm_x}-${dd_x}_${hr_x}:00:00" 
   echo "###############"
   echo "###START DATE: " $start_date 

   foreach cu_para ($CU_params) 
      if( $ens == "E1"  && $cu_para == "P1" ) then
#     if( $ens == "E1"  && $cu_para == "P7" ) then
          set getdata = 1
      else 
          set getdata = 0
      endif 
      echo "####CU-para: " $cu_para 
      echo "####time:    " $getdata  $cu_para $start_dateC $start_date $end_date $ens 
      

#     set WRFversion = WRFV3.9.1_intel_dmpar
#     set WRFpath = /glade/scratch/${USER}/wrf-model/PRE_COMPILED_CODE/${WRFversion}/test/em_real/ 
      set WRFversion = wrfv4.0.1
      set WRFpath = /glade/derecho/scratch/${USER}/wrf-model/PRE_COMPILED_CODE/${WRFversion}/test/em_real/ 

      set yymmddI = `$PWD/split_string.csh $start_dateC $end_date YYMMDDI`
      set utcI = `$PWD/split_string.csh $start_dateC $end_date HHI`
      set initrunC = ${yymmddI}.${utcI}
      set run_case = ${initrunC}"."$ens"."$cu_para 

      if ( -f $WRFpath/$run_case/rsl.out.0001 ) then
           set test_success = `tail -1 $WRFpath/$run_case/rsl.out.0001  | awk '{print $4}'`
      	   if ( $test_success == "SUCCESS" ) then
  	   	echo "END WRF-RUN !: " $test_success
  	   	echo "WRF: "$WRFpath/$run_case/rsl.out.0001
#               go.4mo.CFS.rrqsub.csh  $getdata  $cu_para $start_dateC $start_date $end_date $ens 
# 	   	exit 
           else 
#              echo go.4mo.CFS.qsub.csh  $getdata  $cu_para $start_dateC $start_date $end_date $ens 
#              go.4mo.CFS.qsub.csh  $getdata  $cu_para $start_dateC $start_date $end_date $ens 
	       echo "#######" 
	       echo "N O T  SUCCESS" 
	       echo "Re R U N wrf" 
	       echo "#######" 
#- 	       exit 
#-	       it runs all again
               go.4mo.CFS.qsub.csh  $getdata  $cu_para $start_dateC $start_date $end_date $ens 
#-	       we only run wrf
#-             go.4mo.CFS.wrf.qsub.csh  $getdata  $cu_para $start_dateC $start_date $end_date $ens 
           endif
      else 

           echo go.4mo.CFS.qsub.csh  $getdata  $cu_para $start_dateC $start_date $end_date $ens 
           go.4mo.CFS.qsub.csh  $getdata  $cu_para $start_dateC $start_date $end_date $ens 
           echo "#######" 
           echo "N E W RUN" 
           echo "#######" 
#--
#          exit 
#--
      endif 

      exit 

   end 
   
end 
#----ifile below  
if ( $utcI == 06 | $utcI == 18 ) then
     echo "SLEEP 1h 30min (5400) sec ... " 
     sleep 5400 
endif 

end 

#! /bin/csh

set opath = $OPATH
set exepath = $EXEPATH
set PWD = `pwd`

if ( ! -d "$opath" ) then
    echo "#############################################"
    echo "$opath is not a directory and it was created."
    echo "#############################################"
    mkdir -p $opath 
#   exit 1
endif
#
#
#
set UTCs = (00 06 12 18) 
#----------------
#----------------
set yyyymmdd = $1
set ndays = $2 
set yy = `echo $yyyymmdd | awk '{print substr($1,1,4)}'`
set mm = `echo $yyyymmdd | awk '{print substr($1,5,2)}'`
set dd = `echo $yyyymmdd | awk '{print substr($1,7,2)}'`
set UTCI = $3 

#----------------
#---------------- 
foreach xday (`awk -v II=0 -v NN=$ndays 'BEGIN{for(i=II;i<=NN;i++) {print i}}'`)
#  echo $fdd 
   set xdate = `$exepath/pos_date.xdy.csh $yyyymmdd $xday`
#  echo "XDATE: " $xdate 
  
   set yy_x = `echo $xdate | awk '{print substr($1,1,4)}'`
   set mm_x = `echo $xdate | awk '{print substr($1,5,2)}'`
   set dd_x = `echo $xdate | awk '{print substr($1,7,2)}'`

   foreach UTC ($UTCI)
#-     ftp://nomads.ncdc.noaa.gov/GFS/Grid4/201810/20181001/gfs_4_20181001_0000_000.grb2
#-     set file  = gfs_4_${year}${mm}${day}_0000_${UTC}.grb2
#-     wget ftp://nomads.ncdc.noaa.gov/GFS/Grid4/$year$mm/${year}${mm}${day}/$file
#-
       foreach UTCx ($UTCs)
#         PGB 
          set file = pgbf${yy_x}${mm_x}${dd_x}${UTCx}.01.${yy}${mm}${dd}${UTC}.grb2
#         set source = https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/6-hourly-by-pressure-level-9-month-runs/
          set source = "https\://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/6-hourly-by-pressure-level-9-month-runs/" 

#         get file only if file does not exist
          if ( ! -f "$opath/$file" ) then
             echo "#############################################"
             echo "$opath/$file DO NOT exist "
             echo "#############################################"
#            wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#            mv $file $opath 
#	     set getCFS = $PWD/get.CFS.Rx.sub.pgb.${xday}.csh 
	     set getCFS = $PWD/TMP/get.CFS.Rx.sub.pgb.${xday}.csh 
		 sed s:SOURCE:"$source":g < $PWD/get.CFS.Rx.sub.FRM.csh | \
		 sed s:FILE:"$file":g | \
		 sed s:OPATH:"$opath":g | \
		 sed s:PWD:"$PWD":g | \
		 sed s:YY:"$yy":g | \
		 sed s:MM:"$mm":g | \
		 sed s:DD:"$dd":g > $getCFS
	     chmod +x $getCFS
             if ( `expr $xday % 10` == 0 ) then 
                 $getCFS
             else 
                 $getCFS >& log.get.pgb.${xday}.txt &
                 echo "sleep 2 ..." 
                 sleep 2 
             endif 
#            $PWD/get.CFS.Rx.sub.pgb.csh
#            qsub $PWD/get.CFS.Rx.sub.pgb.csh
          else 
             echo "#############################################"
             echo "$opath/$file exist "
             echo "#############################################"
          endif
#          wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#          mv $file $opath 
#         FLX
          set file = flxf${yy_x}${mm_x}${dd_x}${UTCx}.01.${yy}${mm}${dd}${UTC}.grb2
          set source = "https\://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/6-hourly-flux-9-month-runs/" 
          if ( ! -f "$opath/$file" ) then
#            echo "#############################################"
#            echo "$opath/$file DO NOT exist "
#            echo "#############################################"
#            wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#            mv $file $opath 
	     set getCFS = $PWD/TMP/get.CFS.Rx.sub.flx.${xday}.csh 
		 sed s:SOURCE:"$source":g < $PWD/get.CFS.Rx.sub.FRM.csh | \
		 sed s:FILE:"$file":g | \
		 sed s:OPATH:"$opath":g | \
		 sed s:PWD:"$PWD":g | \
		 sed s:YY:"$yy":g | \
		 sed s:MM:"$mm":g | \
		 sed s:DD:"$dd":g >  $getCFS
	     chmod +x $getCFS
             $getCFS >& log.get.flx.${xday}.txt &  
             echo "sleep 2 ..." 
             sleep 2 
#            qsub $PWD/get.CFS.Rx.sub.flx.csh 
          else 
             echo "#############################################"
             echo "$opath/$file exist "
             echo "#############################################"
          endif
       end 
   end 
end

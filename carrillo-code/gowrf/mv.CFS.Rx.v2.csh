#! /bin/csh
# usage 
#set opath = /glade/scratch/cmc542/20XXWRF/GFS_DATA/ 
#set exepath = /glade/work/cmc542/2018/proj-WRFdust/wrf_gfs/ 
set opath = $OPATH
set exepath = $EXEPATH

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
#set UTCs = (00 06 12 18) 
#----------------
#----------------
#----------------
set yyyymmdd = $1
#
set yy_x = `echo $yyyymmdd | awk '{print substr($1,1,4)}'`
set mm_x = `echo $yyyymmdd | awk '{print substr($1,5,2)}'`
set dd_x = `echo $yyyymmdd | awk '{print substr($1,7,2)}'`
set UTC_x = `echo $yyyymmdd | awk '{print substr($1,9,2)}'`
#---------------- 
set yyyymmdd = $2
#
set yy = `echo $yyyymmdd | awk '{print substr($1,1,4)}'`
set mm = `echo $yyyymmdd | awk '{print substr($1,5,2)}'`
set dd = `echo $yyyymmdd | awk '{print substr($1,7,2)}'`
set UTC = `echo $yyyymmdd | awk '{print substr($1,9,2)}'`

#set UTCx = $ss
#set UTC = $2

#         PGB 
          set file = pgbf${yy_x}${mm_x}${dd_x}${UTC_x}.01.${yy}${mm}${dd}${UTC}.grb2
#         set source = https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/6-hourly-by-pressure-level-9-month-runs/

#         wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#         mv $file $opath 
          echo "MV: " $opath/$file 
	  if ( -d "$opath/$file" ) then
              mv  $opath/$file $opath/TMP 
	  endif
#         FLX
          set file = flxf${yy_x}${mm_x}${dd_x}${UTC_x}.01.${yy}${mm}${dd}${UTC}.grb2
#         set source = https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/6-hourly-flux-9-month-runs/

#         wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
          echo "MV: " $opath/$file
	  if ( -d "$opath/$file" ) then
             mv $opath/$file $opath/TMP 
	  endif
# 

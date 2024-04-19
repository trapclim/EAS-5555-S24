#! /bin/csh
# usage 
#set opath = /glade/scratch/cmc542/20XXWRF/GFS_DATA/ 
#set exepath = /glade/work/cmc542/2018/proj-WRFdust/wrf_gfs/ 
set opath = $OPATH
set exepath = $EXEPATH
set opath_s = $OPATH_S

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

#  foreach UTC ($UTCs)
   foreach UTC ($UTCI)
#-     ftp://nomads.ncdc.noaa.gov/GFS/Grid4/201810/20181001/gfs_4_20181001_0000_000.grb2
#-     set file  = gfs_4_${year}${mm}${day}_0000_${UTC}.grb2
#-     wget ftp://nomads.ncdc.noaa.gov/GFS/Grid4/$year$mm/${year}${mm}${day}/$file
#-
       foreach UTCx ($UTCs)
#         PGB 
          set file = pgbf${yy_x}${mm_x}${dd_x}${UTCx}.01.${yy}${mm}${dd}${UTC}.grb2
          set source = https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/6-hourly-by-pressure-level-9-month-runs/

#-        wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#-        mv $file $opath 
 	  if ( -f "$opath_s/$file" ) then
             ln -s $opath_s/$file $opath/$file
	  endif 
#         FLX
          set file = flxf${yy_x}${mm_x}${dd_x}${UTCx}.01.${yy}${mm}${dd}${UTC}.grb2
          set source = https://www.ncei.noaa.gov/data/climate-forecast-system/access/reforecast/6-hourly-flux-9-month-runs/

#         wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#         mv $file $opath 
 	  if ( -f "$opath_s/$file" ) then
          ln -s $opath_s/$file $opath/$file
          endif 
#-        set opath_s = $OPATH_S
#-        set opath_s = $OPATH_S

       end 
   end 
    
end

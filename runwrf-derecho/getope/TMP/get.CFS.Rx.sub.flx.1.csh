#!/bin/csh

if( 1 == 0 ) then 
#-#PBS -N get_CFS
#-#PBS -A UCOR0050
#-#PBS -l walltime=00:05:00
#-#PBS -q regular
#-#PBS -j oe
#-#PBS -l select=1:ncpus=1:mpiprocs=1
endif 

cd /glade/work/cmc542/2020/proj-wrfHurr-der/scripts/wrf_run_phaI_hurr/toToby/getope

#-wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#-mv $file $opath

wget --no-check-certificate https://www.ncei.noaa.gov/data/climate-forecast-system/access/operational-9-month-forecast/6-hourly-flux//2016/201610/20161020/2016102000/flxf2016102118.01.2016102000.grb2
mv flxf2016102118.01.2016102000.grb2 /glade/derecho/scratch/cmc542/wrf-model/CFS-Rx_DATA_STORE/20161020.00/ 
 
exit

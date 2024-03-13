#!/bin/csh

if( 1 == 0 ) then 
#-#PBS -N get_CFS
#-#PBS -A UCOR0050
#-#PBS -l walltime=00:05:00
#-#PBS -q regular
#-#PBS -j oe
#-#PBS -l select=1:ncpus=1:mpiprocs=1
endif 

cd PWD

#-wget ${source}/${yy}/${yy}${mm}/${yy}${mm}${dd}/$file
#-mv $file $opath

wget --no-check-certificate SOURCE/YY/YYMM/YYMMDD/FILE
mv FILE OPATH 
 
exit

#!/bin/csh
#PBS -A UCOR0073 
#PBS -N run_met
#PBS -q main
#PBS -l walltime=01:10:00
#PBS -l select=1:ncpus=1:mpiprocs=1:ompthreads=1

setenv MPI_SHEPHERD true 
cd WPSpath

###mpiexec_mpt -n 64 ./metgrid.exe
###mpiexec_mpt dplace -s 1 ./metgrid.exe

rm -rf WPSpath/met_em* 
rm -rf WRFpath/met_em* 

#-mpiexec_mpt ./metgrid.exe
#-mpiexec_mpt dplace -s 1 ./metgrid.exe
./metgrid.exe
#-mpiexec_mpt /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WPSV4.0.2_intel_serial/metgrid/src/metgrid.exe
#mpiexec_mpt /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WPSV3.9.1_intel_serial/metgrid/src/metgrid.exe
#ln -sf /glade/scratch/cmc542/20XXWRF/WPS_1/met_em* /glade/scratch/cmc542/20XXWRF/WRF_1/test/em_real
ln -sf WPSpath/met_em* WRFpath 

#-rm -rf WPSpath/PGB* 
#-rm -rf WPSpath/FLX* 

exit

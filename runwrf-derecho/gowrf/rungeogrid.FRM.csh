#!/bin/csh

#--#PBS -A UCOR0073
#--#PBS -N run_geo
#--#PBS -l walltime=00:15:00
#--#PBS -q main
#--#PBS -l select=1:ncpus=1:mpiprocs=1:ompthreads=1

#-cd /glade/scratch/cmc542/20XXWRF/WPS_1
#cd /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WPSV3.9.1_intel_serial/ 

setenv MPI_SHEPHERD true
cd WPSpath

###mpiexec_mpt -n 64 ./geogrid.exe
#-mpiexec_mpt dplace -s 1 ./geogrid.exe
./geogrid.exe
#-mpiexec_mpt ./geogrid.exe

#-cp $geofile WPSpath/geo_em.d01.nc

exit

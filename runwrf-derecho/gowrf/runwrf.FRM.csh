#!/bin/csh
#PBS -N run_wrf
#PBS -A UCOR0073
#PBS -q main
#PBS -l walltime=5:01:00
#PBS -l select=8:ncpus=32:mpiprocs=32:ompthreads=1

limit stacksize unlimited
#cd /glade/scratch/cmc542/20XXWRF/WRF_1/test/em_real

setenv MPI_SHEPHERD true
cd WRFpath

###mpiexec_mpt -n 64 ./wrf.exe
###mpiexec_mpt dplace -s 1 ./wrf.exe

#-cheyenne 
#-mpiexec_mpt ./wrf.exe
#-derecho 
mpiexec -n 32 -ppn 32 ./wrf.exe
 
#-mpiexec_mpt /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WRFV4.0.2_intel_dmpar/main/wrf.exe
#mpiexec_mpt /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WRFV3.9.1_intel_dmpar_large-file/main/wrf.exe

#-mv wrfout_d01_1000-01-01_00:00:00 wrfout_10000101-10000110.125W-to-5E.0N-to-60N.nc
#-mv wrfout_10000101-10000110.125W-to-5E.0N-to-60N.nc /glade/scratch/cmc542/20XXWRF/WRF_OUTPUT/crtl/1000/output
#-mv wrfrst_d01_* /glade/scratch/cmc542/20XXWRF/WRF_OUTPUT/crtl/1000/output
#-mkdir /glade/scratch/cmc542/20XXWRF/WRF_OUTPUT/crtl/1000/output/../info
#-mv rsl.* /glade/scratch/cmc542/20XXWRF/WRF_OUTPUT/crtl/1000/output/../info
#-cp namelist.input /glade/scratch/cmc542/20XXWRF/WRF_OUTPUT/crtl/1000/output

exit

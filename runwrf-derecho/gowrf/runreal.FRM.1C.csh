#!/bin/csh
#PBS -A UCOR0073
#PBS -N run_real
#PBS -q main
#PBS -l walltime=00:45:00
#PBS -l select=1:ncpus=1:mpiprocs=1:ompthreads=1

#cd /glade/scratch/cmc542/20XXWRF/WRF_1/test/em_real

setenv MPI_SHEPHERD true

cd WRFpath
###mpiexec_mpt -n 64 ./real.exe
###mpiexec_mpt dplace -s 1 ./real.exe

#-mpiexec_mpt ./real.exe
#-mpiexec_mpt dplace -s 1 ./real.exe

./real.exe

#-mpiexec_mpt  /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WRFV4.0.2_intel_dmpar/main/real.exe
#mpiexec_mpt  /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WRFV3.9.1_intel_dmpar_large-file/main/real.exe
#mpiexec_mpt  /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/WRFV3.9.1_intel_dmpar_large-file/main/real.exe
#-mpiexec_mpt  /glade/u/home/wrfhelp/PRE_COMPILED_CODE/WRFV4.0_intel_dmpar/test/em_real/real.exe

#-rm -rf WPSpath/met_em*
#-rm -rf WRFpath/met_em*

exit

#!/bin/csh
#PBS -A UCOR0073 
#PBS -N run_ung
#PBS -q main
#PBS -l walltime=00:25:00
#PBS -l select=1:ncpus=1:mpiprocs=1:ompthreads=1


set WPSpath = WPSpath_D
set OPATH = OPATH_D
set PWD = PWD_D
set start_date = start_date_D 
set end_date = end_date_D 
set namelistWPS = namelistWPS_D 
#-set pref_ungrid1 = pref_ungrid1_D 
#-set pref_ungrid2 = pref_ungrid2_D 

#----
cd $WPSpath 
#      UNGRID part I 
        link_grib.csh $OPATH/flxf*grb2
        set pref_ungrid1 = FLX
        sed s/START_DATE/$start_date/g < $PWD/$namelistWPS | \
        sed s/PREF_UNGRID/$pref_ungrid1/g | \
        sed s/END_DATE/$end_date/g > namelist.wps

        ungrib.exe
#      UNGRID part II 
        link_grib.csh $OPATH/pgbf*grb2
        set pref_ungrid2 = PGB
        sed s/START_DATE/$start_date/g < $PWD/$namelistWPS | \
        sed s/PREF_UNGRID/$pref_ungrid2/g | \
        sed s/PREF_1UNGRID/$pref_ungrid1/g | \
        sed s/PREF_2UNGRID/$pref_ungrid2/g | \
        sed s/END_DATE/$end_date/g > namelist.wps

        ungrib.exe

exit

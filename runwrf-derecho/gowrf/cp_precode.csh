#! /bin/csh 

#-set  WPSV = WRFV4.0.2_intel_dmpar  
#-set  WRFV = WPSV4.0.2_intel_serial 

#set PRECODE = /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/ 

set PRECODEsource = $1 
set PRECODE = $2

#set WPSV = 'WPSV3.9.1_intel_serial' 
#set WRFV = 'WRFV3.9.1_intel_dmpar_large-file' 
#- set WPSV = 'WPSV4.0.1_intel_serial_large-file' 
#-set WRFV = 'WRFV4.0.1_intel_dmpar' 
set WRFV = $3
set WPSV = $4


#mkdir -p /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/$WPSV
#mkdir -p /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/$WRFV

#cp -R ~wrfhelp/PRE_COMPILED_CODE/$WPSV/* /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/$WPSV
#cp -R ~wrfhelp/PRE_COMPILED_CODE/$WRFV/*  /glade/work/cmc542/wrf-model/PRE_COMPILED_CODE/$WRFV

mkdir -p $PRECODE/$WPSV
mkdir -p $PRECODE/$WRFV

#-cp -R ~wrfhelp/PRE_COMPILED_CODE/$WPSV/* $PRECODE/$WPSV
#-cp -R ~wrfhelp/PRE_COMPILED_CODE/$WRFV/* $PRECODE/$WRFV
cp -R $PRECODEsource/$WPSV/* $PRECODE/$WPSV
cp -R $PRECODEsource/$WRFV/* $PRECODE/$WRFV
cp ungrib.exe.mchen $PRECODE/$WPSV/ungrib/src/ungrib.exe

exit 

JASPERLIB=/glade/u/home/wrfhelp/UNGRIB_LIBRARIES/lib
export JASPERLIB 
JASPERINC=/glade/u/home/wrfhelp/UNGRIB_LIBRARIES/include
export JASPERINC 


#! /bin/csh 

#-set  WPSV = WRFV4.0.2_intel_dmpar  
#-set  WRFV = WPSV4.0.2_intel_serial 

#-set PRECODEsource = $1 

set PRECODE = $1
set WRFV = $2
set WPSV = $3
set initrun = $4 

#-cp -R $PRECODEsource/$WPSV/* $PRECODE/$WPSV
#-cp -R $PRECODEsource/$WRFV/* $PRECODE/$WRFV

#cp -R $PRECODE/$WPSV/*  $PRECODE/$WPSV/$initrun
echo $PRECODE/$WPSV/$initrun
mkdir -p  $PRECODE/$WPSV/$initrun
ln -sf  $PRECODE/$WPSV/*.exe  $PRECODE/$WPSV/$initrun/ 
#-ln -sf  $PRECODE/$WPSV/link_grib.csh  $PRECODE/$WPSV/$initrun/
ln -sf  $PRECODE/$WPSV/link_grib.csh  $PRECODE/$WPSV/$initrun/link_grib.csh
ln -sf  $PRECODE/$WPSV/geo_em.*.nc  $PRECODE/$WPSV/$initrun/ 
#-ln -sf  $PRECODE/$WPSV/ungrid  $PRECODE/$WPSV/$initrun/ungrid/ 
mkdir -p $PRECODE/$WPSV/$initrun/ungrib/ 
cp -R  $PRECODE/$WPSV/ungrib/Variable_Tables  $PRECODE/$WPSV/$initrun/ungrib/ 

mkdir -p $PRECODE/$WPSV/$initrun/metgrid/ 
cp $PRECODE/$WPSV/metgrid/METGRID.TBL*  $PRECODE/$WPSV/$initrun/metgrid/ 


#cp -R $PRECODE/$WRFV/test/em_real/  $PRECODE/$WRFV/test/em_real/$initrun
echo $PRECODE/$WRFV/test/em_real/$initrun
mkdir -p $PRECODE/$WRFV/test/em_real/$initrun
 
ln -sf $PRECODE/$WRFV/test/em_real/real.exe   $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/wrf.exe   $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/*.TBL  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/*DATA  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/CAMtr*  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/*.formatted  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/*.formatted  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/*.asc*  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/CCN_ACTIVATE.BIN  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/p3_lookup_table_1.dat  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/tr*t*  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/gribmap.txt  $PRECODE/$WRFV/test/em_real/$initrun
ln -sf $PRECODE/$WRFV/test/em_real/grib2map.tbl  $PRECODE/$WRFV/test/em_real/$initrun

exit 

#! /bin/csh 

set PWD = `pwd` 

#----------activation part---------# 
#----------active=1,inactive=0-----# 
#-set cpcode = 0 
#-set cpcode = 1 
set getdata = $1
#-set getdata = 0
#-set rmdata = 1 
set rmdata = 0 
set geogrid = 0
if ( $cpcode == 1 ) then
     set geogrid = 0
endif 
set ungrid =  1
set ungridqsub = 1
#set ungrid =  0
#-set metgrid = 1
set metgrid = 1 
set metgridqsub = 1 
#-set metgridqsub = 0 
set runreal = 1
#-set runrealqsub = 0
set runrealqsub = 1
set runwrfqsub = 1 
set runwrf  = 1
#set runwrf  = 0
#---- 
if ( $runrealqsub == 1x  ) then
# set metgridqsub = 0 
# set metgrid = 0 
# set rmdata = 0  
# set getdata = 0
# set ungrid =  0
# set ungridqsub =  0 
endif 
if ( $metgridqsub == 1x  ) then
# set rmdata = 0  
# set getdata = 0
# set ungrid =  0
# set ungridqsub =  0 
endif 

#---------------domains: 1,2,3 
#set Ndomains = 1 
#-set Ndomains = 3 
set Fqsub = 1 
#-set Fqsub = 0 
#--changes start here--# 
set cu_para = $2 
#set cu_para = P1 
#----
#----
set start_dateC = $3
set start_date  = $4
set end_date =   $5
set ens = $6
#----
#----
#----
#----
if( $Ndomains == 1 ) then 
    set namelistWPS = namelist.default-1dom.wps
    set namelistINPUT = namelist.default-1dom.input
endif 

if( $Ndomains == 2 ) then
    set namelistWPS = namelist.default-2dom.wps
    set namelistINPUT = namelist.default-2dom.input
endif

if( $Ndomains == 3 ) then
    set namelistWPS = namelist.default-3dom.wps
    set namelistINPUT = namelist.default-3dom.input
endif 

#--INPUT DATA 
set indata = "CFS.Rx" 
#--------------------------------------
set USER = `whoami` 
#--------------------------------------
set yymmddI = `$PWD/split_string.csh $start_dateC $end_date YYMMDDI` 
#-set ndaysF = `$PWD/split_string.csh $start_dateC $end_date NDAYSF` 
set utcI = `$PWD/split_string.csh $start_dateC $end_date HHI` 
set initrunC = ${yymmddI}.${utcI} 
#-------------------------------------------------------------# 
set yymmddI = `$PWD/split_string.csh $start_date $end_date YYMMDDI` 
set ndaysF = `$PWD/split_string.csh $start_date $end_date NDAYSF` 
set utcI = `$PWD/split_string.csh $start_date $end_date HHI` 
set initrun = ${yymmddI}.${utcI} 
#-------------------------------------------------------------# 
  echo "INIdate " $yymmddI 
  echo "Ndays " $ndaysF
  echo "UTC " $utcI
  echo "INIrun " $initrun
#-----
#-0. Define PATHS
setenv EXEPATH $PWD

#-setenv OPATH /glade/derecho/scratch/$USER/wrf-model/CFS-Rx_DATA/$initrunC/ 
#-setenv OPATH_S /glade/campaign/univ/ucor0050/cmc542/archive/wrf-model/CFS-Rx_DATA_STORE/$initrunC/ 
setenv OPATH $OPATHR/$initrunC/ 
setenv OPATH_S $OPATH0/$initrunC/ 

#-set runcase = "Hurr-Patr-2015-D3"
set PRECODE = /glade/derecho/scratch/${USER}/wrf-model/$runcase/PRE_COMPILED_CODE/ 
set PRECODEsource = /glade/work/wrfhelp/derecho_pre_compiled_code/

#-set WRFversion = WRFV3.9.1_intel_dmpar 
#-set WPSversion = WPSV4.0.1_intel_serial
  set WRFversion = wrfv4.0.1
  set WPSversion = wpsv4.0.1 

#-set WRFpath = /glade/scratch/${USER}/wrf-model/$runcase/PRE_COMPILED_CODE/${WRFversion}/test/em_real/${initrunC}"."$ens"."$cu_para/ 
#-set WPSpath = /glade/scratch/${USER}/wrf-model/PRE_COMPILED_CODE/${WPSversion}/${initrunC}"."$ens"."$cu_para/ 
set WRFpath = $PRECODE/${WRFversion}/test/em_real/${initrunC}"."$ens"."$cu_para/ 
set WPSpath = $PRECODE/${WPSversion}/${initrunC}"."$ens"."$cu_para/ 


setenv JASPERLIB /glade/u/home/wrfhelp/UNGRIB_LIBRARIES/lib
setenv JASPERINC /glade/u/home/wrfhelp/UNGRIB_LIBRARIES/include
#-------------------------------------------------------------# 
#-1. This copy the pre-compiled WPS and WRF codel in cheyenne

if( $cpcode == 1 ) then 
    echo "#--CP PRE-CODE ..." 
    cp_precode.csh $PRECODEsource $PRECODE $WRFversion $WPSversion
    #-5.1. changes path for geogrid.exe: 
    if ( $geogrid == 1 ) then
    #---namelist 
  	set pref_ungrid1 = FLX 
	sed s/START_DATE/$start_date/g < $PWD/$namelistWPS | \
	sed s/PREF_UNGRID/$pref_ungrid1/g | \
	sed s/END_DATE/$end_date/g > ${PRECODE}/${WPSversion}/namelist.wps
    #---geogrid 
	sed s:WPSpath:"$PRECODE/$WPSversion":g < $PWD/rungeogrid.FRM.csh > $PWD/rungeogrid.csh 
	chmod +x $PWD/rungeogrid.csh 
        $PWD/rungeogrid.csh
    endif 
endif 

#-1b. Build case 
echo "#--CP RUN-CASE ..." 
echo cp_run_case.csh $PRECODE $WRFversion $WPSversion $initrunC"."$ens"."$cu_para
cp_run_case.csh $PRECODE $WRFversion $WPSversion $initrunC"."$ens"."$cu_para 

if( $rmdata  == 1  && ($ens == "E2" || $ens == "E3") ) then 
   set yymmddI = `$PWD/split_string.csh $start_dateC $end_date YYMMDDI` 
   set utcI = `$PWD/split_string.csh $start_dateC $end_date HHI` 
   set xinitrunC = ${yymmddI}${utcI} 
#---
   if( $ens == "E2" ) then 
       set rm_time = `pos_date.xhr.csh $xinitrunC 0` 
   endif 
   if( $ens == "E3" ) then 
       set rm_time = `pos_date.xhr.csh $xinitrunC 6` 
   endif 
   mv.CFS.Rx.v2.csh $rm_time $xinitrunC
endif 

#--
#-2. This get the GFS initial data 
#--- 
if( $getdata == 1 ) then 
   mkdir -p $OPATH/TMP/
   mv $OPATH/*grb* $OPATH/TMP/
   if ( $indata == 'GFS' ) then 
      get.GFS.csh $yymmddI $ndaysF 
   else 
      if ( $indata == 'GFS.RR' ) then 
         get.GFS.RR.csh $yymmddI $ndaysF 
      else
         if ( $indata == 'NARR' ) then 
            get.NARR.csh $yymmddI $ndaysF 
         else
            if ( $indata == 'GFS.ana' ) then 
                get.GFS.ana.csh $yymmddI $ndaysF 
            else 
                if ( $indata == 'CFS.Rx' ) then 
	            echo "LINK CFS INPUT DATA ..." 
                    link.CFS.Rx.v2.csh $yymmddI $ndaysF $utcI
                else 
	            echo "DEFINE INPUT DATA SOURCE: GFS, GFS.ana, NARR" 
	            exit 
	        endif 
            endif 
         endif 
      endif 
   endif 
endif   
#--- 
#-3. link the grib files 
#--- 

cd $WPSpath
#-link_grib.csh $OPATH/*grb* 
#---
#-4. link the appropriated Vtable
#---
  if ( $indata == 'GFS.ana' | $indata == 'GFS' ) then 
     ln -sf ungrib/Variable_Tables/Vtable.GFS Vtable
  else 
     if ( $indata == 'NARR' )  then 
        ln -sf ungrib/Variable_Tables/Vtable.NARR Vtable
     else 
        if ( $indata == 'CFS.Rx' ) then 
            ln -sf ungrib/Variable_Tables/Vtable.CFSR Vtable
        else 

        endif 

     endif 
  endif

  ln -sf ungrib/Variable_Tables/Vtable.CFSR Vtable

#-ln -sf ungrib/Variable_Tables/Vtable.CFSR_press_pgbh06 Vtable
#-ln -sf ungrib/Variable_Tables/Vtable.NARR Vtable

#--
#-5. RUN the ungrib : 
#--

#-5.1. changes path for geogrid.exe: 
if ( $geogrid == 1x ) then
#--     namelist 
  	set pref_ungrid1 = FLX 
	sed s/START_DATE/$start_date/g < $PWD/$namelistWPS | \
	sed s/PREF_UNGRID/$pref_ungrid1/g | \
	sed s/END_DATE/$end_date/g > ${PRECODE}/${WPSversion}/namelist.wps
#--     geogrid 
	sed s:WPSpath:"$PRECODE/$WPSversion":g < $PWD/rungeogrid.FRM.csh > $PWD/rungeogrid.csh 
	chmod +x $PWD/rungeogrid.csh 
        $PWD/rungeogrid.csh
endif 

#-5.2. changes dates in namelist.wps: 
if ( $ungrid == 1 ) then
    if ( $ungridqsub == 1 ) then
        sed s:WPSpath_D:"$WPSpath":g < $PWD/runungrid.FRM.csh | \
        sed s:OPATH_D:"$OPATH":g | \
        sed s:PWD_D:"$PWD":g | \
        sed s/start_date_D/"$start_date"/g | \
        sed s/end_date_D/"$end_date"/g | \
        sed s:namelistWPS_D:"$namelistWPS":g  >  $WPSpath/runungrid.csh

        chmod +x $WPSpath/runungrid.csh
        set JID1 = `qsub -h $WPSpath/runungrid.csh` 
        echo "SLEEP 2 ..."
        sleep 2
#    exit 
    else 
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
    endif 

endif 

#-
#-6. RUN metgrid, WRF-real, and WRF 
#-
#- with QSUB1, QSUB2, and QSUB 3
#  1. qsub runmetgrid.csh 
#  2. qsub runreal.csh
#  3. qsub runwrf.csh
#- REF: dependent jobs: https://www2.cisl.ucar.edu/resources/computational-systems/cheyenne/running-jobs/pbs-pro-job-script-examples

if ( $metgrid == 1 ) then
     ln -sf metgrid/METGRID.TBL.ARW METGRID.TBL
#---6.1. submit metgrid.exe:
    if ( $metgridqsub == 1 ) then
	sed s:WPSpath:"$WPSpath":g < $PWD/runmetgrid.FRM.1C.csh | \
	sed s:WRFpath:"$WRFpath":g >  $WPSpath/runmetgrid.csh 
	chmod +x $WPSpath/runmetgrid.csh 
#       qsub $WPSpath/runmetgrid.csh 
        set JID2 = `qsub -W depend=afterok:$JID1 $WPSpath/runmetgrid.csh` 
#-      exit 
    else 
#-----
        sed s:WPSpath:"$WPSpath":g < $PWD/runmetgrid.FRM.1C.csh | \
        sed s:WRFpath:"$WRFpath":g >  $PWD/runmetgrid.csh 

        chmod +x $PWD/runmetgrid.csh 
   	if ( $Fqsub == 1 ) then 
           set JID1 = `qsub -h  $PWD/runmetgrid.csh` 
   	else 
     	   $PWD/runmetgrid.csh
   	endif 
    endif 

endif 

#-exit 

#-
#-6.2. run WRF: real.exe 
#-

cd $WRFpath

#-
#- edit namelist.input
#-

set run_days = `$PWD/split_string.csh $start_date $end_date NDAYS` 
set run_hours = `$PWD/split_string.csh $start_date $end_date NHOURS` 
set start_year = `$PWD/split_string.csh $start_date $end_date YRI` 
set start_month = `$PWD/split_string.csh $start_date $end_date MMI` 
set start_day = `$PWD/split_string.csh $start_date $end_date DDI` 
set start_hour = `$PWD/split_string.csh $start_date $end_date HHI` 
set end_year = `$PWD/split_string.csh $start_date $end_date YRE` 
set end_month = `$PWD/split_string.csh $start_date $end_date MME` 
set end_day = `$PWD/split_string.csh $start_date $end_date DDE` 
set end_hour = `$PWD/split_string.csh $start_date $end_date HHE` 
#-set met_nlevs = 32;#  GFS
#-set met_nlevs = 27;#  GFS.ana 
#-set met_nlevs = `ncdump $WPSpath/met_em.d01.${start_year}-${start_month}-${start_day}_${start_hour}:00:00.nc  -h  | grep num_metgrid_levels | head -1  | awk '{print $3}'`
#-set met_nlevs = 27 
set met_nlevs = 38
#-echo $met_nlevs 

if ( $cu_para == "P1" ) then 
#        New Kain Fritsch 
     set cu_p = 1  
     set sf_sfclay = 2
     set bl_pbl = 2
     set sf_surface = 4 
endif 
if ( $cu_para == "P2" ) then 
#        Best-Miller_Janjic
     set cu_p = 2 
     set sf_sfclay = 2
     set bl_pbl = 2
     set sf_surface = 4 
endif 
if ( $cu_para == "P3" ) then 
#        Grell-Devenyi Ensemble 
     set cu_p = 3 
     set sf_sfclay = 2
     set bl_pbl = 2
     set sf_surface = 4 
endif 
if ( $cu_para == "P4" ) then 
#        Arakawa-Schubert
     set cu_p = 4 
     set sf_sfclay = 2
     set bl_pbl = 2
     set sf_surface = 4 
endif 
if ( $cu_para == "P5" ) then 
#        Grell-3d
     set cu_p = 5 
     set sf_sfclay = 2
     set bl_pbl = 2
     set sf_surface = 4 
endif 
if ( $cu_para == "P6" ) then 
#        Old Kain Fritsch 
     set cu_p = 99 
     set sf_sfclay = 2
     set bl_pbl = 2
     set sf_surface = 4 
endif 
if ( $cu_para == "P7" ) then 
#        New Kain Fritsch 
     set cu_p = 1  
#  Therman diffision
     set sf_surface = 1  
#  Monin-Obuknov  
     set sf_sfclay = 1   
#   YSU  
     set bl_pbl = 1
endif 
if ( $cu_para == "P8" ) then 
#        New Kain Fritsch 
     set cu_p = 1  
#  Noah 
     set sf_surface = 2  
#  Monin-Obuknov  
     set sf_sfclay = 1   
#   YSU  
     set bl_pbl = 1
endif 
if ( $cu_para == "P9" ) then 
#        New Kain Fritsch 
     set cu_p = 1  
#  Noah 
     set sf_surface = 2  
#  Janjic-Eta
     set sf_sfclay = 2   
#   MYJ
     set bl_pbl = 2
endif 
if ( $cu_para == "P10" ) then 
#        New Kain Fritsch 
     set cu_p = 1  
#  RUC
     set sf_surface = 3  
#  Monin-Obuknov  
     set sf_sfclay = 1   
#   YSU  
     set bl_pbl = 1
endif 
if ( $cu_para == "P11" ) then 
#        New Kain Fritsch 
     set cu_p = 1  
#  RUC
     set sf_surface = 3  
#  Janjic-Eta
     set sf_sfclay = 2   
#   MYJ
     set bl_pbl = 2
endif 
if ( $cu_para == "P12" ) then 
#        New Kain Fritsch 
     set cu_p = 1  
#  Pleim Xu
     set sf_surface = 7  
#  Pleim Xu
     set sf_sfclay = 7   
#  Pleim Xu
     set bl_pbl = 7 
endif 


#sed s/RUN_DAYS/$run_days/g < $PWD/namelist.FRM.input | \
sed s/RUN_DAYS/$run_days/g < $PWD/$namelistINPUT | \
sed s/RUN_HOURS/$run_hours/g | \
sed s/START_YEAR/$start_year/g | \
sed s/START_MONTH/$start_month/g | \
sed s/START_DAY/$start_day/g | \
sed s/START_HOUR/$start_hour/g | \
sed s/END_YEAR/$end_year/g | \
sed s/END_MONTH/$end_month/g | \
sed s/END_DAY/$end_day/g | \
sed s/END_HOUR/$end_hour/g | \
sed s/CU_P/$cu_p/g | \
sed s/SF_SFC/$sf_surface/g | \
sed s/SF_CLY/$sf_sfclay/g | \
sed s/BL_PBL/$bl_pbl/g | \
sed s/MET_NLEVS/$met_nlevs/g > namelist.input 

if ( $runreal == 1 ) then

    if ( $runrealqsub == 1  ) then
	sed s:WPSpath:"$WPSpath":g < $PWD/runreal.FRM.1C.csh | \
	sed s:WRFpath:"$WRFpath":g >  $WRFpath/runreal.csh 
	chmod +x $WRFpath/runreal.csh 

#-	$WRFpath/runreal.csh
 	set JID3 = `qsub -W depend=afterok:$JID2 $WRFpath/runreal.csh` 
#-	exit 
    else 
        sed s:WPSpath:"$WPSpath":g < $PWD/runreal.FRM.1C.csh | \
        sed s:WRFpath:"$WRFpath":g >  $PWD/runreal.csh 
        chmod +x $PWD/runreal.csh 
#-	6.2. submit real.exe:
#-	set JID2 = `qsub -W depend=afterok:$JID1 $PWD/runreal.csh` 
#-	echo "JID2 " $JID2
   	if ( $Fqsub == 1 ) then 
#-		set JID2 = `qsub -W depend=afterok:$JID1 $PWD/runreal.csh` 
#-   		set JID2 = `qsub -h $PWD/runreal.csh` 
     		set JID2 = `qsub -W depend=afterok:$JID1 $PWD/runreal.csh` 
   	else 
     		$PWD/runreal.csh
   	endif 
    endif 
endif 

if ( $runwrf == 1 ) then
#-edit WRFpath 
   sed s:WPSpath:"$WPSpath":g < $PWD/runwrf.FRM.csh | \
   sed s:WRFpath:"$WRFpath":g >  $WRFpath/runwrf.csh 
   chmod +x $WRFpath/runwrf.csh 
#-6.3. submit wrf.exe:
   if ( $runwrfqsub == 1  ) then
      qsub -W depend=afterok:$JID3 $WRFpath/runwrf.csh
#-----post with arwpost
#     set JID4 = `qsub -W depend=afterok:$JID3 $WRFpath/runwrf.csh` 
#     set run_case = ${initrunC}"."$ens"."$cu_para
#     set argfile = arwpost.rr.arg.${run_case}.txt 
#     sed s/ARGFILE/"$argfile"/g < $PWD/post/arwpost.rr-arg-FRM.csh > $PWD/post/arwpost.rr.${run_case}.csh 
#     chmod +x $PWD/post/arwpost.rr.${run_case}.csh 
      
#     echo "cu_para " $cu_para > $PWD/post/$argfile
#     echo "start_dateC " $start_dateC >> $PWD/post/$argfile
#     echo "start_date " $start_date >> $PWD/post/$argfile
#     echo "end_date " $end_date >> $PWD/post/$argfile
#     echo "ens " $ens >> $PWD/post/$argfile
#     qsub -W depend=afterok:$JID4 $PWD/post/arwpost.rr.${run_case}.csh  
#----- 
      sleep 2 
      qrls $JID1 
   else
   	if ( $Fqsub == 1 ) then 
     		qsub -W depend=afterok:$JID2 $PWD/runwrf.csh 
     		qrls $JID1 
   	else 
     		qsub $PWD/runwrf.csh 
   	endif 
   endif 
endif 
#-------------
#-------------
echo "-------------------------------------------"
echo "Model will be run in the directory below:"
echo $PRECODE
echo "-------------------------------------------"

echo "-------------------------------------------"
echo "Output data (if successful) can be found in:"
echo $WRFpath
echo "-------------------------------------------"

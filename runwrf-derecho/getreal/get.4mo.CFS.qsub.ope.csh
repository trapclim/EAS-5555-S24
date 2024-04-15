#! /bin/csh 

set PWD = `pwd` 

#----------activation part---------# 
set getdata = 1
set indata = "CFS.Rx" 
#----------------------------------# 
#----
#----
set start_dateC = $1
set start_date  = $2
set end_date =   $3
#--------------------------------------
#--------------------------------------
set yymmddI = `$PWD/split_string.csh $start_dateC $end_date YYMMDDI` 
set ndaysF = `$PWD/split_string.csh $start_dateC $end_date NDAYSF` 
set utcI = `$PWD/split_string.csh $start_dateC $end_date HHI` 
set initrunC = ${yymmddI}.${utcI} 
#-------------------------------------------------------------# 
#-------------------------------------------------------------# 
  echo "INIdate " $yymmddI 
  echo "Ndays " $ndaysF
  echo "UTC " $utcI
#-----
#-0. Define PATHS
setenv EXEPATH $PWD
setenv OPATH $OPATH0/$initrunC/ 
#-------------------------------------------------------------# 
#-1. This get the GFS initial data 
#--- 
if( $getdata == 1 ) then 
   mkdir -p $OPATH/TMP/
             if ( $indata == 'CFS.Rx' ) then 
#               get.CFS.Rx.csh $yymmddI $ndaysF
	        echo "GET CFS INPUT DATA" 
#-              get.CFS.Rx.v2.csh $yymmddI $ndaysF $utcI
#-              get.CFS.Rx.store.v2.csh $yymmddI $ndaysF $utcI
#               get.CFS.Rx.store.v3.csh $yymmddI $ndaysF $utcI
                get.CFS.Rx.store.v3.ope.csh $yymmddI $ndaysF $utcI
#-              get.CFS.Rx.store.v3.s2.csh $yymmddI $ndaysF $utcI
             else 
	        echo "DEFINE INPUT DATA SOURCE: GFS, GFS.ana, NARR" 
	        exit 
	     endif 

endif   
#--- 
exit 

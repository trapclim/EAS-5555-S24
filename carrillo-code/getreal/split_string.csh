#! /bin/csh 
# usage ./split_string.csh   start_date end_date flag 

#set start_date = '2018-10-01_00:00:00'
#set end_date = '2018-10-03_18:00:00'
#set flag = "NDAYS"
set start_date = $1
set end_date = $2
set flag = $3

#------------------------#     
#set flag = "NHOURS"
#------------------------#     
#set flag = "YRI" 
#set flag = "MMI" 
#set flag = "DDI" 
#set flag = "HHI" 
#set flag = "MNI" 
#set flag = "SSI" 
#--------------------------#     
#set flag = "YRE" 
#set flag = "MME" 
#set flag = "DDE" 
#set flag = "HHE" 
#set flag = "MNE" 
#set flag = "SSE" 
#-------------------------# 

set tmp1  = `echo $start_date | awk '{a=split($1,b,"_"); print b[1]}'` 
set yri = `echo $tmp1 | awk '{a=split($1,b,"-"); print b[1]}'` 
set mmi = `echo $tmp1 | awk '{a=split($1,b,"-"); print b[2]}'` 
set ddi = `echo $tmp1 | awk '{a=split($1,b,"-"); print b[3]}'` 

set tmp1  = `echo $start_date | awk '{a=split($1,b,"_"); print b[2]}'` 
set hhi = `echo $tmp1 | awk '{a=split($1,b,":"); print b[1]}'` 
set mni = `echo $tmp1 | awk '{a=split($1,b,":"); print b[2]}'` 
set ssi = `echo $tmp1 | awk '{a=split($1,b,":"); print b[3]}'` 

#--echo $yri  $mmi $ddi $hhi $mni $ssi 

#--echo $start_date | awk '{a=split($1,b,"_"); print b[2]}'

set tmp1  = `echo $end_date | awk '{a=split($1,b,"_"); print b[1]}'` 
set yre = `echo $tmp1 | awk '{a=split($1,b,"-"); print b[1]}'` 
set mme = `echo $tmp1 | awk '{a=split($1,b,"-"); print b[2]}'` 
set dde = `echo $tmp1 | awk '{a=split($1,b,"-"); print b[3]}'` 

set tmp1  = `echo $end_date | awk '{a=split($1,b,"_"); print b[2]}'` 
set hhe = `echo $tmp1 | awk '{a=split($1,b,":"); print b[1]}'` 
set mne = `echo $tmp1 | awk '{a=split($1,b,":"); print b[2]}'` 
set sse = `echo $tmp1 | awk '{a=split($1,b,":"); print b[3]}'` 

#--echo $yre  $mme $dde   $hhe  $mne $sse 

 set MMs =   (31 28 31 30 31   30  31  31  30  31  30  31) 
 set MMjuls = (0 31 59 90 120 151 181 212 243 273 304 334) 

#awk -v M=$mmi -v D=$ddi -v H=$hhi -v MN=$mni -v S=$ssi 'BEGIN {print D + H/24 + MN/(24*60) +S/(24*60*60)}' 
#--
#-- NDAYS - NHOURS  
#-- 
 set jdayi = `awk -v M=$MMjuls[$mmi] -v D=$ddi -v H=$hhi -v MN=$mni -v S=$ssi 'BEGIN {print M + D + H/24 + MN/(24*60) +S/(24*60*60)}'` 
 set jdaye = `awk -v M=$MMjuls[$mme] -v D=$dde -v H=$hhe -v MN=$mne -v S=$sse 'BEGIN {print M + D + H/24 + MN/(24*60) +S/(24*60*60)}'` 

#--echo $jdayi  $jdaye 

 set ndays = `awk -v D1=$jdayi -v D2=$jdaye 'BEGIN {print int(D2 - D1)}'` 
 set nhours = `awk -v D1=$jdayi -v D2=$jdaye 'BEGIN {print int( 24*( (D2-D1) - int(D2-D1) ))}'` 
 if ( $nhours == 0 ) then 
      set ndaysF =  $ndays
 else 
      set ndaysF = `awk -v D1=$ndays 'BEGIN {print int(D1 + 1)}'`
 endif 

#-- echo $ndays  
#-- echo $nhours
#------------------------#     
if ( $flag == "YYMMDDI" ) then 
   echo ${yri}${mmi}${ddi} 
endif 
#------------------------#     
if ( $flag == "NDAYSF" ) then 
   echo $ndaysF 
endif 
if ( $flag == "NDAYS" ) then 
   echo $ndays
endif 
if ( $flag == "NHOURS" ) then 
   echo $nhours
endif 
#------------------------#     
if ( $flag == "YRI" ) then 
   echo $yri
endif 
if ( $flag == "MMI" ) then 
   echo $mmi
endif 
if ( $flag == "DDI" ) then 
   echo $ddi
endif 
if ( $flag == "HHI" ) then 
   echo $hhi
endif 
if ( $flag == "MNI" ) then 
   echo $mni
endif 
if ( $flag == "SSI" ) then 
   echo $ssi
endif 
#--------------------------#     
if ( $flag == "YRE" ) then 
   echo $yre
endif 
if ( $flag == "MME" ) then 
   echo $mme
endif 
if ( $flag == "DDE" ) then 
   echo $dde
endif 
if ( $flag == "HHE" ) then 
   echo $hhe
endif 
if ( $flag == "MNE" ) then 
   echo $mne
endif 
if ( $flag == "SSE" ) then 
   echo $sse
endif 
#-------------------------# 

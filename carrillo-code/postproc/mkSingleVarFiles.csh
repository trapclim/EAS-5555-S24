#!/bin/csh

module load nco

if ( $#argv < 2 ) then
   echo "Too few arguments"
   echo "You must specify a path and a filename like this:"
   echo "mkSingleVarFiles.csh <PATHNAME> <WRFOUTFILE>"
   exit 1
endif

set DATAPATH=$1
set FILENAME=$2

cd $DATAPATH
ls $FILENAME

ncdump -h $FILENAME > allvars.txt

set mylist=("T2 Q2 U10 V10 PSFC RAINNC SNOWNC")

foreach i ( $mylist )
    echo "ncks -v "$i" "$FILENAME" -o "$FILENAME"."$i".nc"
    ncks -v $i $FILENAME -o $FILENAME.$i.nc
end



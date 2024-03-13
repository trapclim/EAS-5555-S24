Usage: 

1. get input data 
   1.a. for operational 
        in folder getope
        edit dates in file dates.loop.5dy.Oct.2016.txt 
        run as: get.loop.ope.csh 

   1.b. for restrospective forecast 
        in folder getrr
        edit dates in file dates.loop.5dy.Oct.2010.txt 
        run as: get.loop.csh

2. run WRF  
  in folder gowrf 
  edit run date in file dates.loop.5dy.Oct.2016.txt 
  run as: go.loop.csh 
  define cpcode 1 (in go.llop.csh) to copy pre-compiled coded (only needed the first time of run), then define cpcode 0

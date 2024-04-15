1. Navigate to this directory (`runwrf-derecho`)

##Default case:
2. To get data run `get.loop.ope.csh` 
 - This will retrieve data from 2011 until 5 days before the present time.

3. Now navigate to the `gowrf` folder. Here the important file is `go.loop.csh`. This file will do the following for some arbitrary date in 2016:
 - ALL WPS steps (ungrib, geogrid, metgrid, etc...)
 - Submits real.exe and wrf.exe to the scheduler 

##Change spatial domain:
4. To change the domain you need to edit `namelist-FRM-CA-MX-CO.wps` and `namelist.FRM-CA-MX-CO.input`. Both of these are in `gowrf`.

##Change time domains for historical cases
5. Edit the file `dates.loop.5dy.Oct.2015.txt`

##For forecasting
6. Navigate to the folder `getreal`
 - Edit this file `dates.loop.5dy.Apr.2024.txt`
 - Domain is still set in `gowrf/namelist-FRM-CA-MX-CO.wps` and `gowrf/namelist.FRM-CA-MX-CO.input`.

7. Run the script `get.loop.ope.csh`. Dates are defined in the file above. If you don't edit this file, you won't be running a forecast.

8. Log in with Casper https://jupyterhub.hpc.ucar.edu/ to visualize your output if that's your preference.

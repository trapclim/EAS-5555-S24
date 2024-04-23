# Do this once:
0. Clone the repo:
```
git clone https://github.com/trapclim/EAS-5555-S24.git
```
1. Navigate to wherever you cloned Carlos's repo (this might be different for your computer):
```
cd ~/EAS-5555-S24/carrillo-code/
```

2. If this is the first time you are running the updated `carrillo-code` you can now use one of the following options.

I) Run the bash script called `setup-code.sh` like this:
```
bash setup-ccode.sh
```

This will handle adding the `PATH=$PATH:.` and `export PATH` lines to your `.bashrc` and `.bash_profile` files. However, if you run it more than once (or if you've already done this step) it will make a mess of your `.bashrc` and `.bash_profile` scripts. It will also change the permissions of the `.csh` files to make them exexecutables.


II) Alternatively, you can simply edit `.bashrc` and `.bash_profile` manually using nano, emacs, or vim and add the lines above. You can also manually change the permisions of the .csh scripts like this:
```
chmod +x ./*/*.csh
chmod +x runfcst
```


# Running forecasts:
## 1 The easy way:
Navigate to `EAS-5555-S24/carrillo-code`:
```
cd ~/EAS-5555-S24/carrillo-code/
```
Then run the script `runfcst` (you might have to first change permissions using `chmod +x runfcst`):
```
runfcst
```

This will create a "run case" named with your username followed by the date and time (fomatted like $user-DD-MM-YYYY-hh.mm.ss). Example: `ault-04-23-2024-08.22.54`

It will go through all the same steps you've seen previously automatically (setting the dates, copying the code, linking files, running through the WPS and WRF routines). If successful, it will create a new directory in scratch named like the one below:
```
/glade/derecho/scratch/$user/wrf-model/$runcase/PRE_COMPILED_CODE//wrfv4.0.1/test/em_real/$casename/
```

In the case above, that looks like the path below:
```
/glade/derecho/scratch/ault/wrf-model/ault-04-23-2024-08.22.54/PRE_COMPILED_CODE//wrfv4.0.1/test/em_real/20240423.00.E1.P1/
```

And in that folder, you will find your `wrfout` output file.

## 2 Specifying a name for your runcase (instead of using the default):
```
runfcst SomeNameYouLike
```

Example:

```
runfcst Apr23-2024
```

## 3 Using `get.loop.ope.csh` and  `go.loop.csh` (the old way):
```
cd getreal/
```

Now modify the file `dates.txt` to whatever interval you want to forecast for.

Next, copy `dates.txt` to `../gowrf/`:

```
cp dates dates.txt ../gowrf/
```

Finally, navigate to `../gowrf/` and run `go.loop.csh` by specifying a "runcase" name:
```
cd ../gowrf/
go.loop.csh MyCaseName
```



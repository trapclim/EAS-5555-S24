# Do this once:
0. Clone the repo:
```
git clone https://github.com/trapclim/EAS-5555-S24.git
```
1. Navigate to wherever you cloned Carlos's repo (this might be different for your computer):
```
cd ~/EAS-5555-S24/runwrf-derecho/getope
```

2. Now you will need to change the ".csh" files into executables:
```
chmod +x *.csh
```

# Every time you log in:
1. include "." (your current directory) in `PATH`:
```
PATH=$PATH:.
export PATH
```

We will add those lines to your `.profile` or `.bash_profile` files later, but for now, just remember to do it when you log in.

# Now let's get started. 
1. First run `./get.loop.ope.csh`



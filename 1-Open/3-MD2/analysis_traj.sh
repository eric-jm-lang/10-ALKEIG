#!/bin/bash -f

#module add OpenMPI/2.0.1-gcccuda-2016.10
#export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
#source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

if [ -f analysis_traj.in ];
then
  rm analysis_traj.in
fi


echo "parm open10.parm7" >> analysis_traj.in

for i in 1 2 3 4 5; do
  for j in md1 md2 md3 md4 md5 md6 md7 md8 md9 md10 md11 md12 md13 md14 md15; do
    echo "trajin ./${i}/open_${i}_${j}.nc" >> analysis_traj.in
  done 
done 

echo "center :1-192 mass origin
image familiar com :1-192
trajout open_all.nc
run
clear all 
parm open10.parm7
trajin open_all.nc
strip :WAT
strip :Na+
strip :Cl-
trajout open_all_dry.nc
run
clear all
parm open10.parm7
parmstrip :WAT
parmstrip :Na+
parmstrip :Cl-
parmwrite out open10_dry.parm7
run
clear all
parm open10.parm7
trajin open10.rst7
strip :WAT
strip :Na+
strip :Cl-
trajout open10_dry.rst7
run
clear all
parm closed10.parm7
trajin closed10.rst7
strip :WAT
strip :Na+
strip :Cl-
trajout closed10_dry.rst7
run
parm open10_dry.parm7
reference closed10_dry.rst7
trajin open_all_dry.nc
rms reference out open_rmsd_to_closed.dat '(!:WAT & @CA,C,N,O)'
run
clear all
parm open10_dry.parm7
reference open10_dry.rst7
trajin open_all_dry.nc
rms reference out open_rmsd_to_open.dat '(!:WAT & @CA,C,N,O)'
run
clear all
parm open10.parm7
trajin open_all.nc
principal :1-192 dorotation mass
center mass origin :1-192
trajout open_all_rot.nc
trajout open_all_rot.dcd
run
clear all 
parm open10.parm7
trajin open10.rst7
principal :1-192 dorotation mass
center mass origin :1-192
trajout open10_rot.rst7
run
clear all 
parm open10.parm7
trajin open_all_rot.nc
grid water_density.dx 80 0.5 80 0.5 120 0.5 :WAT@O normdensity
run 
clear all 
parm open10.parm7
trajin open_all_rot.nc
strip :WAT
strip :Na+
strip :Cl-
trajout open_all_rot_dry.nc
run
clear all
parm open10.parm7
trajin open10_rot.rst7
strip :WAT
strip :Na+
strip :Cl-
trajout open10_rot_dry.rst7
run
clear all
quit" >> analysis_traj.in

#cpptraj < analysis_traj.in




#!/bin/bash -f

#module add OpenMPI/2.0.1-gcccuda-2016.10
#export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
#source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

if [ -f analysis_traj_2.in ];
then
  rm analysis_traj_2.in
fi


echo "parm closed10.parm7" >> analysis_traj_2.in

for i in 1 2 3 4 5; do
  for j in md1 md2 md3 md4 md5 md6 md7 md8 md9 md10 md11 md12 md13 md14 md15 md16 md17 md18 md19; do
    echo "trajin ./${i}/closed_${i}_${j}.nc" >> analysis_traj_2.in
  done 
done 

echo "center :1-192 mass origin
image familiar com :1-192
trajout closed_all.nc
run
clear all
parm closed10.parm7
trajin closed_all.nc
strip :WAT
strip :Na+
strip :Cl-
trajout closed_all_dry.nc
run
clear all
parm closed10_dry.parm7
trajin closed10_dry.rst7
trajout closed10_dry.pdb
run 
clear all
parm closed10_dry.parm7
reference open10_dry.rst7
trajin closed_all_dry.nc
rms reference out closed_rmsd_to_open.dat '(!:WAT & @CA,C,N,O)'
trajout closed_all_dry_fit2open.nc
run
clear all
parm closed10_dry.parm7
reference closed10_dry.rst7
trajin closed_all_dry.nc
rms reference out closed_rmsd_to_closed.dat '(!:WAT & @CA,C,N,O)'
trajout closed_all_dry_fit2closed.nc
run
clear all
parm closed10_dry.parm7
reference open10_dry.rst7
trajin closed10_dry.rst7
rms reference xray_closed_rmsd_to_open.dat '(!:WAT & @CA,C,N,O)'
trajout closed10_dry_fit2open.rst7
run 
quit" >> analysis_traj_2.in

#cpptraj < analysis_traj.in




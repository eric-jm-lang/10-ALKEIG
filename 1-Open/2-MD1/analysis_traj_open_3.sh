#!/bin/bash -f

#module add OpenMPI/2.0.1-gcccuda-2016.10
#export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
#source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

for i in 1 2 3 4 5; do
  cd $i
  if [ -f analysis_traj_${i}.in ];
    then
    rm analysis_traj_${i}.in
  fi

  echo "parm open10.parm7" >> analysis_traj_${i}.in

  for j in  eq7 eq8 md1 md2 md3 md4 md5 md6 md7 md8 md9 md10 md11 md12 md13 md14 md15 md16 md17 md18 md19 md20; do
    echo "trajin ./open_${i}_${j}.nc" >> analysis_traj_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
trajout open_all_dry_${i}.nc
run
clear all
parm ../open10_dry.parm7
reference ../closed10_dry.rst7
trajin open_all_dry_${i}.nc
rms reference out ../open_rmsd_to_closed_${i}.dat '(!:WAT & @CA,C,N,O)'
run
clear all
parm ../open10_dry.parm7
reference ../open10_dry.rst7
trajin open_all_dry_${i}.nc
rms reference out ../open_rmsd_to_open_${i}.dat '(!:WAT & @CA,C,N,O)'
quit" >> analysis_traj_${i}.in

cd ..

done


#cpptraj < analysis_traj.in



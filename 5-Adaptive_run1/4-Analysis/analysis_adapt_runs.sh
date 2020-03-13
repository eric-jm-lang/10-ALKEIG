#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

for i in {0..245}; do
  cd ../3-MD/$i
  if [ -f analysis_traj_${i}.in ];
    then
    rm analysis_traj_${i}.in
  fi

  echo "parm adapt1_${i}_wat.parm7" >> analysis_traj_${i}.in

  for j in md1; do
    echo "trajin adapt1_${i}_${j}.nc" >> analysis_traj_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
trajout ../../4-Analysis/trajectories_dry/adapt1_dry_${i}.nc
run
quit" >> analysis_traj_${i}.in

cpptraj < analysis_traj_${i}.in > analysis_traj_${i}.out

echo "${i} done"

cd ../../4-Analysis

done





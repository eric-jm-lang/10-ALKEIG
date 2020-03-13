#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

for i in 1 2 3 4 5; do
  cd ../2-MD1/$i
  if [ -f analysis_traj_${i}.in ];
    then
    rm analysis_traj_${i}.in
  fi

  echo "parm open_ipa_HMR.parm7" >> analysis_traj_${i}.in

  for j in eq7 eq8 md1 md2 md3 md4; do
    echo "trajin open_ipa_${i}_${j}.nc" >> analysis_traj_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
strip :IPA
trajout ../../3-Analysis/trajectories_dry/open_ipa_dry_${i}.nc
run
clear all
quit" >> analysis_traj_${i}.in

cpptraj < analysis_traj_${i}.in > analysis_traj_${i}.out

echo "${i} done"

cd ../../3-Analysis

done 


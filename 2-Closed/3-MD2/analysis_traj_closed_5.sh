#!/bin/bash -f

#module add OpenMPI/2.0.1-gcccuda-2016.10
#export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
#source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

for i in 2 3 4 5; do
  cd $i
  if [ -f analysis_traj_${i}.in ];
    then
    rm analysis_traj_${i}.in
  fi
  k=$(expr $i + 5)
  echo "parm closed10.parm7" >> analysis_traj_${i}.in

  for j in md1 md2 md3 md4 md5 md6 md7 md8 md9 md10 md11 md12 md13 md14 md15 md16 md17 md18 md19 md20 md21 md22; do
    echo "trajin ./closed_${i}_${j}.nc 1 last 2" >> analysis_traj_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
trajout ../traj_dry_noeq/closed_dry_${k}.nc
run
clear all
quit" >> analysis_traj_${i}.in

cd ..

done

for i in 1; do
  cd $i
  if [ -f analysis_traj_${i}.in ];
    then
    rm analysis_traj_${i}.in
  fi
  k=$(expr $i + 5)
  echo "parm closed10.parm7" >> analysis_traj_${i}.in

  for j in md1 md2 md3 md4 md5 md6 md7 md8 md9 md10 md11 md12 md13 md14 md15 md16 md17 md18; do
    echo "trajin ./closed_${i}_${j}.nc 1 last 2" >> analysis_traj_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
trajout ../traj_dry_noeq/closed_dry_${k}.nc
run
clear all
quit" >> analysis_traj_${i}.in

cd ..

done



#cpptraj < analysis_traj.in



#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh


for i in 1 2 3 4 5; do
  cd ./trajectories_dry_ipa
  if [ -f analysis_traj_ipa.in ];
    then
    rm analysis_traj_ipa.in
  fi

  echo "parm ../../2-MD1/1/parm open_ipa_HMR.parm7" >> analysis_traj_ipa.in
  for i in 1 2 3 4 5; do
    for j in eq7 eq8 md1 md2 md3 md4; do
      echo "trajin ../../2-MD1/${i}/open_ipa_${i}_${j}.nc" >> analysis_traj_ipa.in
    done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
trajout open_ipa_dry_ipa_all.nc
run
clear all
parm ../../2-MD1/1/open_ipa_HMR.parm7
parmstrip :WAT
parmstrip :Na+
parmstrip :Cl-
parmwrite out open_ipa_dry_ipa.parm7
run
clear all
parm ../../2-MD1/1/open_ipa_HMR.parm7
trajin ../../2-MD1/1/open_ipa_1_ini.parm7
strip :WAT
strip :Na+
strip :Cl-
trajout open_ipa_dry_ipa.rst7
trajout open_ipa_dry_ipa.pdb
run
clear all
parm open_ipa_dry_ipa.parm7
reference
" >> analysis_traj_ipa_${i}.in


echo "${i} IPA  done"

cd ../../4-Analysis

done

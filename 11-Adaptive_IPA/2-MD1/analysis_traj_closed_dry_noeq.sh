#!/bin/bash -f

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 24 25 ; do
  cd $i
  if [ -f analysis_traj_${i}.in ];
    then
    rm analysis_traj_${i}.in
  fi

  echo "parm adapt1_ipa_${i}_wat_HMR.parm7" >> analysis_traj_${i}.in

  for j in  md1; do
    echo "trajin ./adapt1_ipa_${i}_${j}.nc 1 last 1" >> analysis_traj_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
strip :IPA
trajout ../traj_dry_noeq/adapt1_ipa_dry_${i}.nc
run
clear all
quit" >> analysis_traj_${i}.in

cd ..

done

#cpptraj < analysis_traj.in



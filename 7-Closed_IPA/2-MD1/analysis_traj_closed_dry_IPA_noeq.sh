#!/bin/bash -f

for i in 1 2 3 4 5 6 7 8 9 10 ; do
  cd $i
  if [ -f analysis_traj_ipa_${i}.in ];
    then
    rm analysis_traj_ipa_${i}.in
  fi

  echo "parm closed_ipa_HMR.parm7" >> analysis_traj_ipa_${i}.in

  for j in  md1 md2 md3 md4 md5 md6 md7 md8 md9 md10; do
    echo "trajin ./closed_ipa_${i}_${j}.nc" >> analysis_traj_ipa_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
trajout ../traj_dry_ipa_noeq/closed_ipa_dry_${i}.nc
run
clear all
quit" >> analysis_traj_ipa_${i}.in

cd ..

done


#cpptraj < analysis_traj.in



#!/bin/bash -f

for i in 3 5 7 12 15 16 20 21 25; do
  cd $i
  if [ -f analysis_traj_ipa_${i}.in ];
    then
    rm analysis_traj_ipa_${i}.in
  fi

  echo "parm adapt1_ipa_${i}_wat_HMR.parm7" >> analysis_traj_ipa_${i}.in

  for j in  md1; do
    echo "trajin ./adapt1_ipa_${i}_${j}.nc" >> analysis_traj_ipa_${i}.in
  done

echo "center :1-192 mass origin
image familiar com :1-192
strip :WAT
strip :Na+
strip :Cl-
trajout ../traj_dry_ipa_noeq/adapt1_ipa_dry_${i}.nc
run
clear all
quit" >> analysis_traj_ipa_${i}.in

cpptraj < analysis_traj_ipa_${i}.in
echo "$i done!"
cd ..

done

echo "parm ./1/adapt1_ipa_1_wat_HMR.parm7
parmstrip :WAT
parmstrip :Na+
parmstrip :Cl-
parmwrite out ./traj_dry_ipa_noeq/adapt1_ipa_dry.parm7" >> parm.in

cpptraj < parm.in


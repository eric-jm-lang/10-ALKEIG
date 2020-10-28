#!/bin/bash -f

for i in 3 5 7 12 15 16 20 21 25; do
  cd $i
  if [ -f analysis_traj_ipa_${i}.in ];
    then
    rm analysis_traj_ipa_${i}.in
  fi

  echo "parm adapt1_ipa_${i}_wat_HMR.parm7
trajin ./adapt1_ipa_${i}_wat.rst7
strip :WAT
strip :Na+
strip :Cl-
trajout ../traj_dry_ipa_noeq/adapt1_ipa_dry_${i}.rst7
run
quit" >> analysis_traj_ipa_${i}.in

cpptraj < analysis_traj_ipa_${i}.in
echo "$i done!"
cd ..

done

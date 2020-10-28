#!/bin/bash -f

for i in 3 5 7 12 15 16 20 21 25; do

  if [ -f density_ipa_${i}.in ];
    then
    rm density_ipa_${i}.in
  fi

echo "parm ../1-Trajectories/6-States_with_IPA/adapt1_ipa_dry_${i}.parm7
trajin ../1-Trajectories/6-States_with_IPA/adapt1_ipa_dry_${i}_aligned.nc
grid ./grid_normdens_ipa_${i}.dx 60 0.5 60 0.5 160 0.5 :IPA normdensity
run
clear all
quit" >> density_ipa_${i}.in

cpptraj < density_ipa_${i}.in
echo "$i done!"
rm  density_ipa_${i}.in

done

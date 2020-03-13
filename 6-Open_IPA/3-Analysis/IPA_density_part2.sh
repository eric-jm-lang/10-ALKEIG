#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

cd ./trajectories_dry_ipa

rm strip_wat.in

echo "parm ../../2-MD1/1/open_ipa_HMR.parm7
parmstrip :WAT
parmstrip :Na+
parmstrip :Cl-
parmwrite out open_ipa_dry_ipa.parm7
run
clear all
parm ../../2-MD1/1/open_ipa_HMR.parm7
trajin ../../2-MD1/1/open_ipa_1_ini.rst7
strip :WAT
strip :Na+
strip :Cl-
trajout open_ipa_dry_ipa.rst7
run
clear all
quit" > strip_wat.in

cpptraj < strip_wat.in

for i in 1 2 3 4 5; do

rm grid_density_${i}.in

echo "parm open_ipa_dry_ipa.parm7
reference open_ipa_dry_ipa.rst7
trajin open_ipa_dry_ipa_${i}.nc
rms reference '(!:WAT & @CA,C,N,O)'
trajout open_ipa_dry_ipa_${i}_ali.nc
trajout open_ipa_dry_ipa_${i}_last.rst7 onlyframes -1
run
clear all
parm open_ipa_dry_ipa.parm7
trajin open_ipa_dry_ipa_${i}_ali.nc
grid grid_normdens_${i}.dx 30 0.5 30 0.5 140 0.5 :IPA@C2 normdensity
run
clear all
quit" > grid_density_${i}.in

cpptraj < grid_density_${i}.in

done

cd ..

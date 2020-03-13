#!/bin/bash -f

#module add OpenMPI/2.0.1-gcccuda-2016.10
#export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
#source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

cd ./trajectories_dry_ipa

for i in 1 2 3 4 5; do

rm grid_density_${i}.in

echo "parm open_ipa_dry_ipa.parm7
trajin open_ipa_dry_ipa_${i}_ali.nc
grid grid_normdens_${i}.dx 80 0.5 80 0.5 140 0.5 :IPA normdensity
run
clear all
quit" > grid_density_${i}.in

cpptraj < grid_density_${i}.in

done

cd ..

#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J ipa20
#SBATCH --time=4-00:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd $SLURM_SUBMIT_DIR
#
old=wat
for name in min1 min2 min3 min4 min5 min6 heat eq1; do

$AMBERHOME/bin/pmemd.cuda -O -i ${name}.i -o adapt1_ipa_20_${name}.mdout -p adapt1_ipa_20_wat_HMR.parm7 -c adapt1_ipa_20_${old}.rst7 -ref adapt1_ipa_20_wat.rst7 -x adapt1_ipa_20_${name}.nc -r adapt1_ipa_20_${name}.rst7 -inf adapt1_ipa_20_${name}.mdinfo

old=${name}

done

old=eq1

for name in eq2 eq3 eq4 eq5 eq6 eq7 md1; do

$AMBERHOME/bin/pmemd.cuda -O -i ${name}.i -o adapt1_ipa_20_${name}.mdout -p adapt1_ipa_20_wat_HMR.parm7 -c adapt1_ipa_20_${old}.rst7 -ref adapt1_ipa_20_wat.rst7 -x adapt1_ipa_20_${name}.nc -r adapt1_ipa_20_${name}.rst7 -inf adapt1_ipa_20_${name}.mdinfo

cp adapt1_ipa_20_${name}.rst7 adapt1_ipa_20_${name}.rst7.ORG
mv adapt1_ipa_20_${name}.rst7 TEMP_adapt1_ipa_20_${name}.rst7

cat > image.in <<EOF
parm adapt1_ipa_20_wat_HMR.parm7
trajin TEMP_adapt1_ipa_20_${name}.rst7
center :1-192 mass origin
image familiar com :1-192
trajout adapt1_ipa_20_${name}.rst7 restart
run
EOF
cpptraj < image.in
rm image.in

old=${name}

done



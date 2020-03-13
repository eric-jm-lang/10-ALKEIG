#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J C_ipa8
#SBATCH --time=7-00:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=14 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd $SLURM_SUBMIT_DIR
#
old=md7

for name in md8 md9; do
$AMBERHOME/bin/pmemd.cuda -O -i ${name}.i -o closed_ipa_8_${name}.mdout -p closed_ipa_HMR.parm7 -c closed_ipa_8_${old}.rst7 -ref closed_ipa_8_ini.rst7 -x closed_ipa_8_${name}.nc -r closed_ipa_8_${name}.rst7 -inf closed_ipa_8_${name}.mdinfo

cp closed_ipa_8_${name}.rst7 closed_ipa_8_${name}.rst7.ORG
mv closed_ipa_8_${name}.rst7 TEMP_closed_ipa_8_${name}.rst7

cat > image.in <<EOF
parm closed_ipa_HMR.parm7
trajin TEMP_closed_ipa_8_${name}.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_ipa_8_${name}.rst7 restart
run
EOF
cpptraj < image.in
rm image.in

old=${name}
done



#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J 4_md3-4
#SBATCH --time=4-00:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#SBATCH --mem=12GB
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd $SLURM_SUBMIT_DIR
#
old=md2
for name in md3 md4; do
$AMBERHOME/bin/pmemd.cuda -O -i ${name}.i -o open_ipa_4_${name}.mdout -p open_ipa_HMR.parm7 -c open_ipa_4_${old}.rst7 -ref open_ipa_4_ini.rst7 -x open_ipa_4_${name}.nc -r open_ipa_4_${name}.rst7 -inf open_ipa_4_${name}.mdinfo

cp open_ipa_4_${name}.rst7 open_ipa_4_${name}.rst7.ORG
mv open_ipa_4_${name}.rst7 TEMP_open_ipa_4_${name}.rst7

cat > image.in <<EOF
parm open_ipa_HMR.parm7
trajin TEMP_open_ipa_4_${name}.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_ipa_4_${name}.rst7 
run
EOF
cpptraj < image.in
rm image.in TEMP_open_ipa_4_${name}.rst7

old=${name}
done



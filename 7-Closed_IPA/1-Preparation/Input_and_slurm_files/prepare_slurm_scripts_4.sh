#!/bin/bash

#Run from BC4

for i in  6 8 10; do
 
echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J Cipa${i}4
#SBATCH --time=7-00:00:00     # Walltime
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
cd \$SLURM_SUBMIT_DIR
#
old=md10

for name in md11 md12; do
\$AMBERHOME/bin/pmemd.cuda -O -i \${name}.i -o closed_ipa_${i}_\${name}.mdout -p closed_ipa_HMR.parm7 -c closed_ipa_${i}_\${old}.rst7 -ref closed_ipa_${i}_ini.rst7 -x closed_ipa_${i}_\${name}.nc -r closed_ipa_${i}_\${name}.rst7 -inf closed_ipa_${i}_\${name}.mdinfo

cp closed_ipa_${i}_\${name}.rst7 closed_ipa_${i}_\${name}.rst7.ORG
mv closed_ipa_${i}_\${name}.rst7 TEMP_closed_ipa_${i}_\${name}.rst7

cat > image.in <<EOF
parm closed_ipa_HMR.parm7
trajin TEMP_closed_ipa_${i}_\${name}.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_ipa_${i}_\${name}.rst7 restart
run
EOF
cpptraj < image.in
rm image.in

old=\${name}
done

" >  run4.slurm
  
  
  mv run4.slurm ../../2-MD1/${i}
  cp md8.i ../../2-MD1/${i}/md11.i
  cp md8.i ../../2-MD1/${i}/md12.i
done


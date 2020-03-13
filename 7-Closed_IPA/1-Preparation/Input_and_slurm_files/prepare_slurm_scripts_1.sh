#!/bin/bash

#Run from BC4

for i in  {1..10}; do
 
echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J C_ipa${i}
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
cd \$SLURM_SUBMIT_DIR
#
old=ini
for name in min1 min2 min3 min4 min5 min6 heat; do
  mpirun -n 12 \$AMBERHOME/bin/pmemd.MPI -O -i \${name}.i -o closed_ipa_${i}_\${name}.mdout -p closed_ipa_HMR.parm7 -c closed_ipa_${i}_\${old}.rst7 -ref closed_ipa_${i}_ini.rst7 -x closed_ipa_${i}_\${name}.nc -r closed_ipa_${i}_\${name}.rst7 -inf closed_ipa_${i}_\${name}.mdinfo

old=\${name}

done

old=heat

for name in eq1 eq3 eq4 eq5 eq6; do
\$AMBERHOME/bin/pmemd.cuda -O -i \${name}.i -o closed_ipa_${i}_\${name}.mdout -p closed_ipa_HMR.parm7 -c closed_ipa_${i}_\${old}.rst7 -ref closed_ipa_${i}_ini.rst7 -x closed_ipa_${i}_\${name}.nc -r closed_ipa_${i}_\${name}.rst7 -inf closed_ipa_${i}_\${name}.mdinfo

old=\${name}
done

old=eq6

for name in eq7 eq8 md1 md2 md3 md4 md5 md6 md7; do
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

" >  run.slurm
  
  
  mkdir ../../2-MD1/${i}
  mv run.slurm ../../2-MD1/${i}
  cp *.i ../../2-MD1/${i}
  cp ../closed_ipa_10_HMR.parm7 ../../2-MD1/${i}/closed_ipa_HMR.parm7
  cp ../closed_ipa_10.rst7 ../../2-MD1/${i}/closed_ipa_${i}_ini.rst7
done


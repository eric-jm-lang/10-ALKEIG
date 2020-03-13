#!/bin/bash -f

  
for i in 2; do
  

    cp *.i ./${i}
    cp closed10.* ./${i}
    cp closed10.rst7 ./${i}/closed_${i}_ini.rst7
    cd ./${i}
    

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed${i}_minheateq
#SBATCH --time=24:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR=\"/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/${i}\"
#
cd \$MYDIR
old=ini
for name in min1 min2 min3 min4 min5 min6 heat eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed10.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo
  
  
  old=\$name
done" >  minheateq.slurm 


echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed${i}_md1
#SBATCH --time=48:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR=\"/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/${i}\"
#
cd \$MYDIR
old=eq8
for name in md1; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed10.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo
  
  cp closed_${i}_\$name.rst7 closed_${i}_\$name.rst7.ORG
  mv closed_${i}_\$name.rst7 TEMP_closed_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm closed10.parm7
trajin TEMP_closed_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in
  
  old=\$name
done" >  md1.slurm 


    cd ..

done




#!/bin/bash -f

  
for i in 1 2 3 4 5; do

    cd ./${i}
    cp md1.i md2.i
cp md1.i md2.i
cp md1.i md3.i
cp md1.i md4.i
cp md1.i md5.i
cp md1.i md6.i
cp md1.i md7.i
cp md1.i md8.i
cp md1.i md9.i
cp md1.i md10.i
    

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed${i}md1-5
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

export MYDIR=\"/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/2-Closed/3-MD2/${i}\"
#
cd \$MYDIR
old=eq8
for name in md1 md2 md3 md4 md5; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10_HMR.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed10.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo
  
  cp closed_${i}_\$name.rst7 closed_${i}_\$name.rst7.ORG
  mv closed_${i}_\$name.rst7 TEMP_closed_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm closed10_HMR.parm7
trajin TEMP_closed_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md1-5.slurm 

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed${i}md6-10
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

export MYDIR=\"/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/2-Closed/3-MD2/${i}\"
#
cd \$MYDIR
old=md5
for name in md6 md7 md8 md9 md10; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10_HMR.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed10.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo
  
  cp closed_${i}_\$name.rst7 closed_${i}_\$name.rst7.ORG
  mv closed_${i}_\$name.rst7 TEMP_closed_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm closed10_HMR.parm7
trajin TEMP_closed_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md6-10.slurm 

    cd ..

done







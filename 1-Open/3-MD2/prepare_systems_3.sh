#!/bin/bash -f

  
for i in 1 2 3 4 5; do

    cd ./${i}
cp md1.i md11.i
cp md1.i md12.i
cp md1.i md13.i
cp md1.i md14.i
cp md1.i md15.i
cp md1.i md16.i
cp md1.i md17.i
cp md1.i md18.i
cp md1.i md19.i
cp md1.i md20.i
cp md1.i md21.i
cp md1.i md22.i
cp md1.i md23.i
cp md1.i md24.i
cp md1.i md25.i
cp md1.i md26.i
cp md1.i md27.i
cp md1.i md28.i
cp md1.i md29.i
cp md1.i md30.i
    

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open${i}md11-15
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

export MYDIR=\"/mnt/storage/home/el14718/mulholland_group/mulholland_group/el14718/10-ALKEIG/1-Open/3-MD2/${i}\"
#
cd \$MYDIR
old=md10
for name in md11 md12 md13 md14 md15; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o open_${i}_\$name.mdout -p open10_HMR.parm7 -c open_${i}_\$old.rst7 \
  -ref open10.rst7 -x open_${i}_\$name.nc -r open_${i}_\$name.rst7 -inf open_${i}_\$name.mdinfo
  
  cp open_${i}_\$name.rst7 open_${i}_\$name.rst7.ORG
  mv open_${i}_\$name.rst7 TEMP_open_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md11-15.slurm 

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open${i}md16-20
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

export MYDIR=\"/mnt/storage/home/el14718/mulholland_group/mulholland_group/el14718/10-ALKEIG/1-Open/3-MD2/${i}\"
#
cd \$MYDIR
old=md15
for name in md16 md17 md18 md19 md20; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o open_${i}_\$name.mdout -p open10_HMR.parm7 -c open_${i}_\$old.rst7 \
  -ref open10.rst7 -x open_${i}_\$name.nc -r open_${i}_\$name.rst7 -inf open_${i}_\$name.mdinfo
  
  cp open_${i}_\$name.rst7 open_${i}_\$name.rst7.ORG
  mv open_${i}_\$name.rst7 TEMP_open_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md16-20.slurm 


echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open${i}md21-25
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

export MYDIR=\"/mnt/storage/home/el14718/mulholland_group/mulholland_group/el14718/10-ALKEIG/1-Open/3-MD2/${i}\"
#
cd \$MYDIR
old=md20
for name in md21 md22 md23 md24 md25; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o open_${i}_\$name.mdout -p open10_HMR.parm7 -c open_${i}_\$old.rst7 \
  -ref open10.rst7 -x open_${i}_\$name.nc -r open_${i}_\$name.rst7 -inf open_${i}_\$name.mdinfo
  
  cp open_${i}_\$name.rst7 open_${i}_\$name.rst7.ORG
  mv open_${i}_\$name.rst7 TEMP_open_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md21-25.slurm 

echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open${i}md26-30
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

export MYDIR=\"/mnt/storage/home/el14718/mulholland_group/mulholland_group/el14718/10-ALKEIG/1-Open/3-MD2/${i}\"
#
cd \$MYDIR
old=md25
for name in md26 md27 md28 md29 md30; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o open_${i}_\$name.mdout -p open10_HMR.parm7 -c open_${i}_\$old.rst7 \
  -ref open10.rst7 -x open_${i}_\$name.nc -r open_${i}_\$name.rst7 -inf open_${i}_\$name.mdinfo
  
  cp open_${i}_\$name.rst7 open_${i}_\$name.rst7.ORG
  mv open_${i}_\$name.rst7 TEMP_open_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md26-30.slurm 

    cd ..

done








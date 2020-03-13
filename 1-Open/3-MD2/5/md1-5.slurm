#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open5md2-5
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

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/1-Open/3-MD2/5"
#
cd $MYDIR
old=eq8
for name in md1 md2 md3 md4 md5; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o open_5_$name.mdout -p open10_HMR.parm7 -c open_5_$old.rst7   -ref open10.rst7 -x open_5_$name.nc -r open_5_$name.rst7 -inf open_5_$name.mdinfo
  
  cp open_5_$name.rst7 open_5_$name.rst7.ORG
  mv open_5_$name.rst7 TEMP_open_5_$name.rst7
  
  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_5_$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_5_$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=$name
done

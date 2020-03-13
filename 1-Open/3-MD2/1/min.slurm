#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J open1_min
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=28 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/1-open/3-MD2/1"
#
cd $MYDIR
old=ini
for name in min1 min2 min3 min4 min5 min6; do
  mpirun -n 28 $AMBERHOME/bin/pmemd.MPI -O -i $name.i -o open_1_$name.mdout -p open10_HMR.parm7 -c open_1_$old.rst7   -ref open10.rst7 -x open_1_$name.nc -r open_1_$name.rst7 -inf open_1_$name.mdinfo
  
old=$name
done

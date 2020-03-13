#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J closed4_min
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=28 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/2-Closed/3-MD2/4"
#
cd $MYDIR
old=ini
for name in min1 min2 min3 min4 min5 min6 ; do
 mpirun -n 28 $AMBERHOME/bin/pmemd.MPI -O -i $name.i -o closed_4_$name.mdout -p closed10_HMR.parm7 -c closed_4_$old.rst7   -ref closed10.rst7 -x closed_4_$name.nc -r closed_4_$name.rst7 -inf closed_4_$name.mdinfo
  
old=$name
done

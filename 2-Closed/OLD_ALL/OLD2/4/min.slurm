#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J closed2_minheateq
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=28 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/4"
#
cd $MYDIR
old=ini
for name in min6 min7 min8 ; do
  mpirun -n 28 $AMBERHOME/bin/pmemd.MPI -O -i $name.i -o closed_2_$name.mdout -p closed10.parm7 -c closed_2_$old.rst7   -ref closed10.rst7 -x closed_2_$name.nc -r closed_2_$name.rst7 -inf closed_2_$name.mdinfo
  
  
  old=$name
done

#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J closed1_heat
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/1"
#
cd $MYDIR

old=min8
for name in heat ; do
 mpirun -n 28 $AMBERHOME/bin/pmemd.MPI -O -i $name.i -o closed_1_$name.mdout -p closed10.parm7 -c closed_1_$old.rst7   -ref closed_1_min8.rst7 -x closed_1_$name.nc -r closed_1_$name.rst7 -inf closed_1_$name.mdinfo

old=$name
done

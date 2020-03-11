#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J 1_o2c_1
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=2          # number of tasks
#SBATCH --ntasks-per-node=28 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/4-TMD/1/open2closed"
#
cd $MYDIR
old=eq3
for name in tmd1; do
  mpirun -np ${SLURM_NTASKS} $AMBERHOME/bin/sander.MPI -O -i $name.i -o open_1_$name.mdout -p open10.parm7 -c open_1_$old.rst7 -ref closed_forfit_watok_fitted.rst7 -x open_1_$name.nc -r open_1_$name.rst7 -inf open_1_$name.mdinfo
  

  old=$name
done

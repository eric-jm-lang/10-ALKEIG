#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J c_MD2_3
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd $SLURM_SUBMIT_DIR

for i in 5; do
  cd $i

  $AMBERHOME/bin/cpptraj < analysis_traj_${i}.in > analysis_traj_${i}.log
  
  cd ..

done

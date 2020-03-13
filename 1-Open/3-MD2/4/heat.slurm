#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open4_heat
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/1-open/3-MD2/4"
#
cd $MYDIR
old=min6
for name in heat; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o open_4_$name.mdout -p open10_HMR.parm7 -c open_4_$old.rst7   -ref open_4_min6.rst7 -x open_4_$name.nc -r open_4_$name.rst7 -inf open_4_$name.mdinfo

old=$name
done

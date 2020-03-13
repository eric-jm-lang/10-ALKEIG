#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open3_minheateq
#SBATCH --time=48:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/el14718/10-ALKEIG/1-open/2-MD1/3"
#
cd $MYDIR
old=ini
for name in min1 min2 min3 min4 min5 min6 heat eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o open_3_$name.mdout -p open10.parm7 -c open_3_$old.rst7   -ref open10.rst7 -x open_3_$name.nc -r open_3_$name.rst7 -inf open_3_$name.mdinfo
 
  old=$name
done

#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed3_eq
#SBATCH --time=24:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/2-Closed/3-MD2/3"
#
cd $MYDIR
old=min6
for name in heat eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8; do
 $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o closed_3_$name.mdout -p closed10_HMR.parm7 -c closed_3_$old.rst7   -ref closed_3_min6.rst7 -x closed_3_$name.nc -r closed_3_$name.rst7 -inf closed_3_$name.mdinfo

  old=$name
done

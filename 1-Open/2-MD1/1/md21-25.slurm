#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J open1md21-25
#SBATCH --time=5-00:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
cd $SLURM_SUBMIT_DIR
#
old=md20
for name in md21 md22 md23 md24 md25; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o open_1_$name.mdout -p open10.parm7 -c open_1_$old.rst7   -ref open10.rst7 -x open_1_$name.nc -r open_1_$name.rst7 -inf open_1_$name.mdinfo
  
  cp open_1_$name.rst7 open_1_$name.rst7.ORG
  mv open_1_$name.rst7 TEMP_open_1_$name.rst7
  
  cat > image.in <<EOF
parm open10.parm7
trajin TEMP_open_1_$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_1_$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=$name
done

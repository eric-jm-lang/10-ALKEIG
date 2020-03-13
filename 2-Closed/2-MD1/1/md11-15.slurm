#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed1md11-15
#SBATCH --time=7-00:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/2-Closed/2-MD1/1"
#
cd $MYDIR
old=md10
for name in md11 md12 md13 md14 md15; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o closed_1_$name.mdout -p closed10.parm7 -c closed_1_$old.rst7   -ref closed10.rst7 -x closed_1_$name.nc -r closed_1_$name.rst7 -inf closed_1_$name.mdinfo
  
  cp closed_1_$name.rst7 closed_1_$name.rst7.ORG
  mv closed_1_$name.rst7 TEMP_closed_1_$name.rst7
  
  cat > image.in <<EOF
parm closed10.parm7
trajin TEMP_closed_1_$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_1_$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=$name
done

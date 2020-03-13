#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed4md26-30
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

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/2-Closed/2-MD1/4"
#
cd $MYDIR
old=md25
for name in md26 md27 md28 md29 md30; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o closed_4_$name.mdout -p closed10.parm7 -c closed_4_$old.rst7   -ref closed10.rst7 -x closed_4_$name.nc -r closed_4_$name.rst7 -inf closed_4_$name.mdinfo
  
  cp closed_4_$name.rst7 closed_4_$name.rst7.ORG
  mv closed_4_$name.rst7 TEMP_closed_4_$name.rst7
  
  cat > image.in <<EOF
parm closed10.parm7
trajin TEMP_closed_4_$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_4_$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=$name
done

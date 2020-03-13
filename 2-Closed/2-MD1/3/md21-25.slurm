#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed3md21-25
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

export MYDIR="/mnt/storage/home/el14718/mulholland_group/el14718/10-ALKEIG/2-Closed/2-MD1/3"
#
cd $MYDIR
old=md20
for name in md21 md22 md23 md24 md25; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o closed_3_$name.mdout -p closed10.parm7 -c closed_3_$old.rst7   -ref closed10.rst7 -x closed_3_$name.nc -r closed_3_$name.rst7 -inf closed_3_$name.mdinfo
  
  cp closed_3_$name.rst7 closed_3_$name.rst7.ORG
  mv closed_3_$name.rst7 TEMP_closed_3_$name.rst7
  
  cat > image.in <<EOF
parm closed10.parm7
trajin TEMP_closed_3_$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_3_$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=$name
done

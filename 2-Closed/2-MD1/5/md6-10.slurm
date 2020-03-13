#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed5md6-10
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

export MYDIR="/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/5"
#
cd $MYDIR
old=md5
for name in md6 md7 md8 md9 md10; do
  $AMBERHOME/bin/pmemd.cuda -O -i $name.i -o closed_5_$name.mdout -p closed10.parm7 -c closed_5_$old.rst7   -ref closed10.rst7 -x closed_5_$name.nc -r closed_5_$name.rst7 -inf closed_5_$name.mdinfo
  
  cp closed_5_$name.rst7 closed_5_$name.rst7.ORG
  mv closed_5_$name.rst7 TEMP_closed_5_$name.rst7
  
  cat > image.in <<EOF
parm closed10.parm7
trajin TEMP_closed_5_${name}.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_5_${name}.rst7 restart
run
EOF
  $AMBERHOME/bin/cpptraj < image.in
  rm image.in

  old=$name
done

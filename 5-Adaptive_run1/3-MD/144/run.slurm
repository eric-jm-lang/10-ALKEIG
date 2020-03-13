#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J 144
#SBATCH --time=09:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
##SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=14 # number of tasks per node
#SBATCH --gres=gpu:1
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
#
cd $SLURM_SUBMIT_DIR
#
old=wat
for name in min1 min2 min3 min4 min5 min6 heat; do
  mpirun -n 12 $AMBERHOME/bin/pmemd.MPI -O -i ${name}.i -o adapt1_144_${name}.mdout -p adapt1_144_wat_HMR.parm7 -c adapt1_144_${old}.rst7 -ref adapt1_144_wat.rst7 -x adapt1_144_${name}.nc -r adapt1_144_${name}.rst7 -inf adapt1_144_${name}.mdinfo

old=${name}

done

old=heat

for name in eq1 eq3 eq4 eq5 eq6; do
$AMBERHOME/bin/pmemd.cuda -O -i ${name}.i -o adapt1_144_${name}.mdout -p adapt1_144_wat_HMR.parm7 -c adapt1_144_${old}.rst7 -ref adapt1_144_wat.rst7 -x adapt1_144_${name}.nc -r adapt1_144_${name}.rst7 -inf adapt1_144_${name}.mdinfo

old=${name}
done

old=eq6

for name in md1; do
$AMBERHOME/bin/pmemd.cuda -O -i ${name}.i -o adapt1_144_${name}.mdout -p adapt1_144_wat_HMR.parm7 -c adapt1_144_${old}.rst7 -ref adapt1_144_wat.rst7 -x adapt1_144_${name}.nc -r adapt1_144_${name}.rst7 -inf adapt1_144_${name}.mdinfo

cp adapt1_144_${name}.rst7 adapt1_144_${name}.rst7.ORG
mv adapt1_144_${name}.rst7 TEMP_adapt1_144_${name}.rst7

cat > image.in <<EOF
parm adapt1_144_wat_HMR.parm7
trajin TEMP_adapt1_144_${name}.rst7
center :1-192 mass origin
image familiar com :1-192
trajout adapt1_144_${name}.rst7 ncrestart
run
EOF
cpptraj < image.in
rm image.in

old=${name}
done



#!/bin/bash -f

  
for i in 1 2 3 4 5; do
  

    cp *.i ./${i}
    cp closed10.* ./${i}
    cp closed10.rst7 ./${i}/closed_${i}_ini.rst7
    cd ./${i}
    

echo "#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J closed${i}_min
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=28 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR=\"/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/${i}\"
#
cd \$MYDIR
old=ini
for name in min6 min7 min8 ; do
 mpirun -n 28 \$AMBERHOME/bin/pmemd.MPI -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed10.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo
  
old=\$name
done" >  min.slurm


echo "#!/bin/bash -login
#
#SBATCH -p test
#SBATCH -J closed${i}_heat
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mail-user=eric.lang@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1          # number of tasks
#SBATCH --ntasks-per-node=28 # number of tasks per node
#
module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

export MYDIR=\"/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/${i}\"
#
cd \$MYDIR

old=min8
for name in heat ; do
 mpirun -n 28 \$AMBERHOME/bin/pmemd.MPI -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed_${i}_min8.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo

old=\$name
done" >  heat.slurm


echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed${i}_eq
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

export MYDIR=\"/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/${i}\"
#
cd \$MYDIR
old=heat
for name in eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8; do
 \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed_${i}_min8.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo

  old=\$name
done" >  eq.slurm 


echo "#!/bin/bash -login
#
#SBATCH -p gpu
#SBATCH -J closed${i}_md1
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

export MYDIR=\"/mnt/storage/home/el14718/el14718/10-ALKEIG/2-Closed/2-MD1/${i}\"
#
cd \$MYDIR
old=eq8
for name in md1; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o closed_${i}_\$name.mdout -p closed10.parm7 -c closed_${i}_\$old.rst7 \
  -ref closed10.rst7 -x closed_${i}_\$name.nc -r closed_${i}_\$name.rst7 -inf closed_${i}_\$name.mdinfo
  

  old=\$name
done" >  md1.slurm 



    cd ..

done







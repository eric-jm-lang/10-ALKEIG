#!/bin/bash -f

  
for i in 1 2 3 4 5; do

    cd ./${i}
cp ../md11.i .
cp md11.i md12.i
cp md11.i md13.i
cp md11.i md14.i
cp md11.i md15.i
cp md11.i md16.i
cp md11.i md17.i
cp md11.i md18.i
   

echo "#!/bin/bash
#PBS -l select=1:ncpus=1:ngpus=1
#PBS -l walltime=72:00:00
#PBS -j oe
#PBS -M eric.lang@bristol.ac.uk
#PBS -N ${i}_1

module add lang/intel-parallel-studio-xe/2019.u3
module add lang/cuda/10.1.105
export CUDA_HOME=/usr/local/cuda
export AMBERHOME=/home/el14718/SOFTWARE/amber18
source /home/el14718/SOFTWARE/amber18/amber.sh

cd \$PBS_O_WORKDIR
#
old=md10
for name in md11 md12 md13; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o open_${i}_\$name.mdout -p open10_HMR.parm7 -c open_${i}_\$old.rst7 \
  -ref open10.rst7 -x open_${i}_\$name.nc -r open_${i}_\$name.rst7 -inf open_${i}_\$name.mdinfo
  
  cp open_${i}_\$name.rst7 open_${i}_\$name.rst7.ORG
  mv open_${i}_\$name.rst7 TEMP_open_${i}_\$name.rst7
  
  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md11-13.qsub


echo "#!/bin/bash
#PBS -l select=1:ncpus=1:ngpus=1
#PBS -l walltime=72:00:00
#PBS -j oe
#PBS -M eric.lang@bristol.ac.uk
#PBS -N ${i}_2

module add lang/intel-parallel-studio-xe/2019.u3
module add lang/cuda/10.1.105
export CUDA_HOME=/usr/local/cuda
export AMBERHOME=/home/el14718/SOFTWARE/amber18
source /home/el14718/SOFTWARE/amber18/amber.sh

cd \$PBS_O_WORKDIR
#
old=md13
for name in md14 md15 md16; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o open_${i}_\$name.mdout -p open10_HMR.parm7 -c open_${i}_\$old.rst7 \
  -ref open10.rst7 -x open_${i}_\$name.nc -r open_${i}_\$name.rst7 -inf open_${i}_\$name.mdinfo

  cp open_${i}_\$name.rst7 open_${i}_\$name.rst7.ORG
  mv open_${i}_\$name.rst7 TEMP_open_${i}_\$name.rst7

  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md14-16.qsub

echo "#!/bin/bash
#PBS -l select=1:ncpus=1:ngpus=1
#PBS -l walltime=72:00:00
#PBS -j oe
#PBS -M eric.lang@bristol.ac.uk
#PBS -N ${i}_3

module add lang/intel-parallel-studio-xe/2019.u3
module add lang/cuda/10.1.105
export CUDA_HOME=/usr/local/cuda
export AMBERHOME=/home/el14718/SOFTWARE/amber18
source /home/el14718/SOFTWARE/amber18/amber.sh

cd \$PBS_O_WORKDIR
#
old=md16
for name in md17 md18; do
  \$AMBERHOME/bin/pmemd.cuda -O -i \$name.i -o open_${i}_\$name.mdout -p open10_HMR.parm7 -c open_${i}_\$old.rst7 \
  -ref open10.rst7 -x open_${i}_\$name.nc -r open_${i}_\$name.rst7 -inf open_${i}_\$name.mdinfo

  cp open_${i}_\$name.rst7 open_${i}_\$name.rst7.ORG
  mv open_${i}_\$name.rst7 TEMP_open_${i}_\$name.rst7

  cat > image.in <<EOF
parm open10_HMR.parm7
trajin TEMP_open_${i}_\$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout open_${i}_\$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

  old=\$name
done" >  md17-18.qsub

    cd ..
done








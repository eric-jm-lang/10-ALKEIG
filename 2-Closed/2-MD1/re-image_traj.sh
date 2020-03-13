#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
  
for i in 1 2 3; do
  cd ./${i}
  name=md1
  
  cat > image.in <<EOF
parm closed10.parm7
trajin closed_${i}_$name.nc
center :1-192 mass origin
image familiar com :1-192
trajout closed_${i}_${name}_ok.nc
run
EOF
  cpptraj < image.in
  rm image.in

cd ..  
  
done


#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
  
for i in 1 2 3 4 5; do
  cd ./${i}
  name=md1
  
  cp closed_${i}_$name.rst7 closed_${i}_$name.rst7.ORG
  mv closed_${i}_$name.rst7 TEMP_closed_${i}_$name.rst7
  
  cat > image.in <<EOF
parm closed10.parm7
trajin TEMP_closed_${i}_$name.rst7
center :1-192 mass origin
image familiar com :1-192
trajout closed_${i}_$name.rst7 restart
run
EOF
  cpptraj < image.in
  rm image.in

cd ..  
  
done


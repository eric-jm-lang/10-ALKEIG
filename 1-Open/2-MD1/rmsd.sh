#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh
   
  cat > image.in <<EOF
parm ./1/open10.parm7
reference ./1/open10.rst7
trajin ./1/open_1_md1.nc
trajin ./2/open_2_md1.nc
trajin ./3/open_3_md1.nc
center :1-192 mass origin
image familiar com :1-192
rms reference out open_rmsd_to_open.dat '(!:WAT & @CA,C,N,O)'
run
clear all
parm ./1/open10.parm7
reference ../../2-Closed/2-MD1/1/closed10.rst7
trajin ./1/open_1_md1.nc
trajin ./2/open_2_md1.nc
trajin ./3/open_3_md1.nc
center :1-192 mass origin
image familiar com :1-192
rms reference out open_rmsd_to_closed.dat '(!:WAT & @CA,C,N,O)'
run


EOF
  cpptraj < image.in
  rm image.in




#!/bin/bash -f

module add OpenMPI/2.0.1-gcccuda-2016.10
export AMBERHOME=/mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16
source /mnt/storage/scratch/el14718/SOFTWARE/amber16-mofified/amber16/amber.sh

echo "parm open10_dry.parm7
reference closed10_dry.rst7
trajin open10_dry.rst7
rms reference out xray_open_rmsd_to_closed.dat '(!:WAT & @CA,C,N,O)'
trajout open10_dry_fit2closed.rst7
trajout open10_dry_fit2closed.pdb
run 
clear all
parm closed10_dry.parm7
reference open10_dry.rst7
trajin closed10_dry.rst7
rms reference out xray_closed_rmsd_to_open.dat '(!:WAT & @CA,C,N,O)'
trajout closed10_dry_fit2open.rst7
trajout closed10_dry_fit2open.pdb
run
quit" >> fit.in

cpptraj < fit.in

rm fit.in

#!/bin/bash

for i in 0 1 2 3 4 5; do

sed -i '/TER/d' closed4_dry_rot${i}.pdb

pdb4amber -i closed4_dry_rot${i}.pdb -o closed5_dry_rot${i}.pdb

cat > tleap.in <<EOF
source leaprc.protein.ff14SB 
prot = loadPDB closed5_dry_rot${i}.pdb
saveamberparm prot closed6_dry_rot${i}.parm7 closed6_dry_rot${i}_temp.rst7
quit
EOF

tleap -f tleap.in

cat > cpptraj.in <<EOF
parm closed6_dry_rot${i}.parm7
trajin closed6_dry_rot${i}_temp.rst7
principal :1-192 dorotation mass
center :1-192 mass origin
trajout closed6_dry_rot${i}.rst7
trajout closed6_dry_rot${i}.pdb
run
quit
EOF
  cpptraj < cpptraj.in > cpptraj.out

rm tleap.in

done

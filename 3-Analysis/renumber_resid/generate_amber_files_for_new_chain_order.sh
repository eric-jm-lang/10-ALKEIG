#!/bin/bash

for i in 0 1 2 3 4 5; do

sed -i '/TER/d' closed4_dry_rot${i}.pdb

pdb4amber -i closed4_dry_rot${i}.pdb -o closed5_dry_rot${i}.pdb

cat > tleap.in <<EOF
source leaprc.protein.ff14SB 
prot = loadPDB closed5_dry_rot${i}.pdb
saveamberparm prot closed6_dry_rot${i}.parm7 closed6_dry_rot${i}.rst7
savepdb prot closed6_dry_rot${i}.pdb
quit
EOF

tleap -f tleap.in

rm tleap.in

done

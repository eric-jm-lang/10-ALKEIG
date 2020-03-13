#!/bin/bash

#Run from BC4

for i in {0..245}; do
	pdb4amber -i ../1-starting_structures/${i}.pdb -o ${i}_amb.pdb > ${i}.log
	
	sed -i 's/HETATM/ATOM  /g' ${i}_amb.pdb
	
	solvate -t 5.0 -n 8 ${i}_amb ./adapt1_${i}_solvate

  	sed -i 's/OH2 TIP3 /O   WAT I/g' adapt1_${i}_solvate.pdb
  	sed -i 's/TIP3 /WAT I/g' adapt1_${i}_solvate.pdb


cat > tleap_1.in <<EOF
source leaprc.protein.ff14SB
source leaprc.water.tip3p
prot = loadpdb adapt1_${i}_solvate.pdb
charge prot
solvateOct prot TIP3PBOX 6.0 iso 0.75
savepdb prot adapt1_${i}_wat_temp.pdb
quit
EOF
  #tleap -f tleap_$i.in #> tleap_$i.out

  tleap -f tleap_1.in > tleap_1.out
  nb_wat=$(grep -c "WAT" adapt1_${i}_wat_temp.pdb)
  echo ${nb_wat}
  #tleap_${i}.out
  charge=$(grep "Total unperturbed charge" tleap_1.out | awk '{print $4}' | sed 's/.000000//g')
  echo ${charge}
  nb_ion=$(awk "BEGIN {printf \"%d\n\", (${nb_wat} /3) * 0.1 * 0.0187 + 0.5}")
  echo $nb_ion
  if (("$charge" >= 0)); then
    NA=$(expr $nb_ion)
    CL=$(expr $charge + $nb_ion)

  else
    NA=$(expr $charge + $nb_ion)
    CL=$(expr $nb_ion)
  fi
  echo $NA
  echo $CL

cat > tleap_2.in <<EOF
source leaprc.protein.ff14SB
source leaprc.water.tip3p
prot = loadpdb adapt1_${i}_solvate.pdb
solvateOct prot TIP3PBOX 6.0 iso 0.75
addIonsRand prot Cl- $CL Na+ $NA
charge prot
saveAmberParm prot adapt1_${i}_wat.parm7 adapt1_${i}_wat_temp.rst7
quit
EOF
  tleap -f tleap_2.in

cat > cpptraj.in <<EOF
parm adapt1_${i}_wat.parm7
trajin adapt1_${i}_wat_temp.rst7
principal :1-192 dorotation mass
center :1-192 mass origin
trajout adapt1_${i}_wat.rst7
trajout adapt1_${i}_wat.pdb
run
quit
EOF
  cpptraj < cpptraj.in

  cat > parmed_$i.in <<EOF
parm adapt1_${i}_wat.parm7
HMassRepartition
outparm adapt1_${i}_wat_HMR.parm7
quit
EOF
  parmed -O -i parmed_$i.in #> parmed_$i.out


rm  *.txt *.log *.out *.in *_temp* *_sslink *.lis

done


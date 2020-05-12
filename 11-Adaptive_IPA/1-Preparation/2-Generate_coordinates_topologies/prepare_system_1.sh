#!/bin/bash


# Loop over the number of structures
for i in {1..25}; do
	# pdb4amber needed for the proper format and residue numbering
	pdb4amber -i ../1-rep_struct_with_IPA_1/sample.pdb.${i} -o ${i}_amb.pdb --nohyd > ${i}.log
	
	sed -i 's/HETATM/ATOM  /g' ${i}_amb.pdb

	# Run Solvate	
	solvate -t 5.0 -n 8 ${i}_amb ./adapt1_ipa_${i}_solvate

  	sed -i 's/OH2 TIP3 /O   WAT I/g' adapt1_ipa_${i}_solvate.pdb
  	sed -i 's/TIP3 /WAT I/g' adapt1_ipa_${i}_solvate.pdb



# Determine the size of the water box as well as the number of ions to add for a 25%/75% IPA/Water

cat > tleap_$i_1.in <<EOF
source leaprc.protein.ff14SB
source leaprc.water.tip3p
source leaprc.gaff  
loadamberparams JorgAA_IPAnb.frcmod  
loadamberprep JorgAA_IPAnb.prepi  
IPA = loadpdb JorgAA_IPAbox.pdb  
set IPA restype solvent  
setbox IPA centers  
prot = loadpdb adapt1_ipa_${i}_solvate.pdb
charge prot
solvateOct prot IPA 6 iso 0.5  
solvateOct prot TIP3PBOX XXXX iso 0.5 
savepdb prot adapt1_ipa_${i}_wat_temp.pdb
quit
EOF

# Perform a binary search to identify the optimal size of the water oct. box
	# Set the boundaries for the search
	min=5.0
	max=15.0

	while (( $(echo "$min < $max" |bc -l) )); do

		# Compute the mean between min and max
		wat_shell=$(awk "BEGIN {printf \"%.2f\n\", (${min}+${max}) /2}")
		
		# Run tleap with the new size
		sed "s/XXXX/${wat_shell}/g" tleap_$i_1.in > tleap_temp.in
		tleap -f tleap_temp.in > tleap_temp.out

		# Retrieve the number of water and IPA molecules. Note: the obtain value correspond to all the atoms of those molecules and needs to be devided by 3 and 12 respectivelly
		nb_wat=$(grep -c "WAT" adapt1_ipa_${i}_wat_temp.pdb)
		# echo ${nb_wat}
		nb_ipa=$(grep -c "IPA" adapt1_ipa_${i}_wat_temp.pdb)
		# echo ${nb_ipa}

		# Calculate the volume ratio Wat/IPA: for 75%/25% it should be 3 (i.e. 3 volume for 1 volume), taking into account that a molecule of IPA occupies the volume of 4.2365 water molecules 
		ratio=$(awk "BEGIN {printf \"%.2f\n\", ((${nb_wat} /3) / (${nb_ipa} /12)) / 4.2365}")
		# echo $ratio

		# Retrieve the charge
		charge=$(grep "Total unperturbed charge" tleap_temp.out | awk '{print $4}' | sed 's/.000000//g')

		# perform the search
		if (($(echo "$ratio > 3.05" |bc -l))) ; then
			max=${wat_shell}
			# echo ${wat_shell}
		elif (($(echo "$ratio < 2.95" |bc -l))) ; then
			min=${wat_shell}
			# echo ${wat_shell}
		else 
			echo "Water box parameter: ${wat_shell}"
			echo "WAT/IPA ratio: $ratio"

			# Calculate the number of ions needed. Nothe the `+ 0.5` is to round up properly the integer
			# n_ions = (((M_wat * N_wat) / (d_wat * 1000)) + ((M_ipa * N_ipa) / (d_ipa * 1000))) * C
			# n_ions = (((18.015 * 12562) / (0.9982 * 1000)) + ((60.096 * 982) / (0.786 * 1000))) * 0.1
			nb_ion=$(awk "BEGIN {printf \"%d\n\", (((18.015 * (${nb_wat} /3)) / (0.9982 * 1000)) + ((60.096 * (${nb_ipa} /12)) / (0.786 * 1000))) * 0.1 + 0.5}")


			# echo $nb_ion
			if (("$charge" >= 0)); then
			    NA=$(expr $nb_ion)
			    CL=$(expr $charge + $nb_ion)

			else
			    NA=$(expr $charge + $nb_ion)
			    CL=$(expr $nb_ion)
			fi
			echo "Number of Na+ needed: $NA"
			echo "Number of Cl- needed: $CL"

			# Stop the while loop
			min=${wat_shell}
			max=${wat_shell}

	    	fi
	done

# Run the actual tleap script to generate the parm7 and rst7 files
cat > tleap_$i_2.in <<EOF
source leaprc.protein.ff14SB
source leaprc.water.tip3p
source leaprc.gaff  
loadamberparams JorgAA_IPAnb.frcmod  
loadamberprep JorgAA_IPAnb.prepi  
IPA = loadpdb JorgAA_IPAbox.pdb  
set IPA restype solvent  
setbox IPA centers  
prot = loadpdb adapt1_ipa_${i}_solvate.pdb
charge prot
solvateOct prot IPA 6 iso 0.5  
solvateOct prot TIP3PBOX ${wat_shell} iso 0.5
addIonsRand prot Cl- $CL Na+ $NA
charge prot
saveAmberParm prot adapt1_ipa_${i}_wat.parm7 adapt1_ipa_${i}_wat_temp.rst7
quit
EOF
  tleap -f tleap_$i_2.in > tleap_$i_2.out

# Align the channel along the z axis
cat > cpptraj_$i.in <<EOF
parm adapt1_ipa_${i}_wat.parm7
trajin adapt1_ipa_${i}_wat_temp.rst7
principal :1-192 dorotation mass
center :1-192 mass origin
trajout adapt1_ipa_${i}_wat.rst7
trajout adapt1_ipa_${i}_wat.pdb
run
quit
EOF
  cpptraj < cpptraj_$i.in > cpptraj_$i.out

# Use the HMassRepartition to use a time step of 4 fs
  cat > parmed_$i.in <<EOF
parm adapt1_ipa_${i}_wat.parm7
HMassRepartition
outparm adapt1_ipa_${i}_wat_HMR.parm7
quit
EOF
  parmed -O -i parmed_$i.in > parmed_$i.out

# Delete the temporary files and intermediate PDBs
rm  *.txt *.log *.out *.in *_temp* *_sslink *.lis *_nonprot.pdb *_amb.pdb

done


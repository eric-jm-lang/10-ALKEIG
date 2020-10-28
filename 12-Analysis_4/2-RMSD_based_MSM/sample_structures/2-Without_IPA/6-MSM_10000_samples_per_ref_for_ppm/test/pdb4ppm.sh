#!/bin/bash

for f in *.pdb; do

	name=$(echo "$f" | cut -f 1 -d '.')
	
	grep -v "ACE" ${name}.pdb > ${name}.tmp; mv ${name}.tmp ${name}.pdb
	grep -v "NHE" ${name}.pdb > ${name}.tmp; mv ${name}.tmp ${name}.pdb
	grep -v "TER" ${name}.pdb > ${name}.tmp; mv ${name}.tmp ${name}.pdb

       	ppm_linux_64.exe -pdb ${name}.pdb -pre ${name}.dat -begin 0 -stop 9999 -para pdb
	ppm_linux_64.exe -pdb ${name}.pdb -pre ${name}_old.dat -begin 0 -stop 9999 -para old

	for file in ${name}_CB_pre.dat ${name}_HB_pre.dat ${name}_CB_pre_old.dat ${name}_HB_pre_old.dat; do
		if [ -f $file ] ; then
  			rm $file
		fi
	done
		
	for i in 14 46 78 110 142 174; do

		grep "${i}      ALA       CB" ${name}.dat | awk '{print $6}' >> ${name}_CB_pre.dat
		grep "${i}      ALA       HB" ${name}.dat | awk '{print $6}' >> ${name}_HB_pre.dat
		grep "${i}      ALA       CB" ${name}_old.dat | awk '{print $6}'  >> ${name}_CB_pre_old.dat
		grep "${i}      ALA       HB" ${name}_old.dat | awk '{print $6}'>> ${name}_HB_pre_old.dat
	done
done


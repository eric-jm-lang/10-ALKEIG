#!/bin/bash
for j in {1..5}; do 
	cd $j 
	for i in {11..30}; do
		 rm md${i}.i 
	done 
	rm md11-15.slurm md16-20.slurm md21-25.slurm md26-30.slurm
	cd ..
done

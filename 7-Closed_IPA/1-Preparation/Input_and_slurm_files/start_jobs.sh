#!/bin/bash

#Run from BC4

for i in  {1..10}; do
cd ../../2-MD1/${i}
#sed -i 's/#SBATCH --time=15:00:00/#SBATCH --time=09:00:00/g' run.slurm
sbatch run.slurm
cd ../../1-Preparation/Input_and_slurm_files
done


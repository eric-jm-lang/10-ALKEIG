#!/bin/bash

#Run from BC4

for i in  {217..245}; do
cd ../../3-MD/${i}
#sed -i 's/#SBATCH --time=15:00:00/#SBATCH --time=09:00:00/g' run.slurm
sbatch run.slurm
cd ../../2-system_preparation/Input_and_slurm_files
done


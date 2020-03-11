50 ns TMD simulations
&cntrl
 imin=0,   			          ! Not a minimisation run
 irest=1, 			          ! Restart simulation
 ntx=5,  			            ! Read coordinates velocities
 nscm=1000,		           	! Reset COM every 1000 steps
 nstlim=25000000, dt=0.002,	! Run MD for 500 ps with a timestep of 2 fs
 ntpr=5000, ntwx=25000, 		! Write the trajectory every 50 ps and the energies every 10 ps
 ioutfm=1,		           	! Use Binary NetCDF trajectory format (better)
 iwrap=0, 		          	!  wrapping will be performed
 ntxo=1, 			            ! NetCDF file
 ntwr=-250000,		         	! Write a restrt file every 500 ps , if negative value, the files are not overwritten
 ntb=2, 			            ! Use PBC at constant pressure
 cut=10.0,		          	! 10 angstrom non-bond cut off
 ntc=2, ntf=2,	       		! SHAKE on all H
 ntp=1,			            	! Isotropic pressure regulation
 pres0=1.01325,		       	! Reference pressure in bars
 taup=1.0, 			          ! Pressure relaxation time (in ps)
 barostat=1,		        	! Berendsen barostat
 ntt=3,    			          ! Temperature regulation using langevin dynamics
 gamma_ln=2.0, 		        ! Langevin thermostat collision frequency
 tempi=293.15, 		       	! Initial thermostat temperature in K
 temp0=293.15,			      ! Final thermostat temperature in K
 ig=-1,				            ! Randomize the seed for the pseudo-random number generator
 ntr=0, 			            ! Flag for restraining specified atoms
 itgtmd=1,                ! Flag for TMD 
 tgtrmsd=0.25,             ! Value of the target RMSD 
 tgtmdfrc=5,              ! Value of the force constant 
 tgtfitmask='(!:WAT & @CA,C,O,N)',       ! Define the atoms that will be used for the rms superposition
 tgtrmsmask='(!:WAT & @CA,C,O,N)',       ! Define the atoms that will be used for the rms difference calculation
 nmropt=0,			          ! NMR restraints and weight changes read
/

500 ps NPT MD equilibration of system with restraints
&cntrl
 imin=0,   		   	        ! Not a minimisation run
 irest=1,           			! Restart simulation
 ntx=5,  		             	! Read coordinates velocities
 nscm=1000,	          		! Reset COM every 1000 steps
 nstlim=250000, dt=0.002,	! Run MD for 0.5 ns with a timestep of 2 fs
 ntpr=5000, ntwx=25000, 		! Write the trajectory every 10 ps and the energies every 1 ps
 ioutfm=1,	           		! Use Binary NetCDF trajectory format (better)
 iwrap=0, 		          	! No wrapping will be performed
 ntxo=2, 	            		! NetCDF file
 ntwr=250000,	        		! Write a restrt file every 10 ps steps, if negative value, the files are not overwritten
 ntb=2, 	             		! Use PBC at constant pressure
 cut=10.0,	           		! 10 angstrom non-bond cut off
 ntc=2, ntf=2,	       		! SHAKE on all H
 ntp=1,		             		! Isotropic pressure regulation
 pres0=1.01325,	      		! Reference pressure in bars
 taup=1.0, 		           	! Pressure relaxation time (in ps)
 barostat=1,	         		! Berendsen barostat
 ntt=3,    	          		! Temperature regulation using langevin dynamics
 gamma_ln=5.0, 	      		! Langevin thermostat collision frequency
 tempi=293.15, 		       	! Initial thermostat temperature in K
 temp0=293.15,			      ! Final thermostat temperature in K
 ig=-1,				            ! Randomize the seed for the pseudo-random number generator
 ntr=1, 			            ! Flag for restraining specified atoms
 restraint_wt=0.5,    ! kcal/mol/A**2 restraint force constant
 restraintmask='@CA | @2862,2934,3042,3102,3141,3144,3147,3150,3153,3156,3159,3162,3165,3171,3621,3852,4317,457',
 nmropt=0,	           		! NMR restraints and weight changes read
/

500 ns NPT MD equilibration of system no restraints
&cntrl
 imin=0,      		               	! Not a minimisation run
 irest=1, 		               	! Restart simulation
 ntx=5,  		               	! Read coordinates velocities
 nscm=1000,		               	! Reset COM every 1000 steps
 nstlim=125000000, dt=0.004,           	! Run MD for 500 ns with a timestep of 4 fs
 ntpr=12500, ntwx=12500, 	   	! Write the trajectory every 10 ps and the energies every 10 ps
 ioutfm=1,	             		! Use Binary NetCDF trajectory format (better)
 iwrap=0, 	             		! No wrapping will be performed
 ntxo=2, 	              		! NetCDF file
 ntwr=250000,	         		! Write a restrt file every 1 ns steps, if negative value, the files are not overwritten
 ntb=2, 	               		! Use PBC at constant pressure
 cut=10.0,	             		! 10 angstrom non-bond cut off
 ntc=2, ntf=2,		        	! SHAKE on all H
 ntp=1,			              	! Isotropic pressure regulation
 pres0=1.01325,	        		! Reference pressure in bars
 taup=1.0, 	            		! Pressure relaxation time (in ps)
 barostat=2,          			! MC barostat
 ntt=3,    		             	! Temperature regulation using langevin dynamics
 gamma_ln=5.0,        			! Langevin thermostat collision frequency
 tempi=293.15, 		       	        ! Initial thermostat temperature in K
 temp0=293.15,			        ! Final thermostat temperature in K
 ig=-1,				        ! Randomize the seed for the pseudo-random number generator
 ntr=0, 	               		! Flag for restraining specified atoms
 nmropt=0,	             		! NMR restraints and weight changes read
/

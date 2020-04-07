500 ps NPT MD equilibration of system with   restraint on backbone
&cntrl
 imin=0,   			          ! Not a minimisation run
 irest=0, 			          ! Restart simulation
 ntx=1,  			            ! Read coordinates not velocities
 nscm=1000,			          ! Reset COM every 1000 steps
 nstlim=250000, dt=0.002,	! Run MD for 500 ps with a timestep of 2 fs
 ntpr=5000, ntwx=25000, 		! Write the trajectory every 10 ps and the energies every 10 ps
 ioutfm=1,			          ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			          ! wrapping will not be performed
 ntxo=2, 			            ! NetCDF file
 ntwr=250000,			        ! Write a restrt file every 10 ps steps, if negative value, the files are not overwritten
 ntb=2, 			            ! Use PBC at constant pressure
 cut=10.0,			          ! 12 angstrom non-bond cut off
 ntc=2, ntf=2,			      ! SHAKE on all H
 ntp=1,				            ! Isotropic pressure regulation
 pres0=1.01325,			      ! Reference pressure in bars
 taup=1.0, 			          ! Pressure relaxation time (in ps)
 barostat=2,			        ! Berendsen barostat
 ntt=3,    			          ! Temperature regulation using langevin dynamics
 gamma_ln=2.0, 			      ! Langevin thermostat collision frequency
 tempi=293.15, 		       	! Initial thermostat temperature in K
 temp0=293.15,			      ! Final thermostat temperature in K
 ig=-1,				            ! Randomize the seed for the pseudo-random number generator
 ntr=1, 			            ! Flag for restraining specified atoms
 restraint_wt=5.0, 		    ! The weight (in kcal/molA2) for the positional restraints
 restraintmask='(!:WAT & @CA,C,O,N | @2872,2944,3052,3112,3151,3154,3157,3160,3163,3166,3169,3172,3175,3181,3625,3856,4321,4576,29728,29752,29758,29794,29815,31069,38005,38032,38071,38074)',
 nmropt=0,			          ! NMR restraints and weight changes read
/

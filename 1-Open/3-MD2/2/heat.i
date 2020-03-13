MD heating of system over 100 ps
&cntrl
 imin=0,  			           ! Not a minimisation run
 irest=0, 			           ! Restart simulation
 ntx=1, 			             ! Read coordinates but not velocities from ASCII formatted inpcrd coordinate file
 nscm=1000,			           ! Reset COM every 1000 steps
 nstlim=50000, dt=0.002,	 ! Run MD for 100 ps with a timestep of 2 fs
 ntpr=500, ntwx=500, 		 ! Write the trajectory every 10 ps and the energies every 1 ps
 ioutfm=1,			           ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			           ! No wrapping will be performed
 ntxo=2, 			             ! NetCDF file
 ntwr=5000,			           ! Write a restrt file every 10 ps steps, if negative value, the files are not overwritten
 ntb=1,			               ! Use PBC at constant volume
 cut=10.0,			           ! 12 angstrom non-bond cut off
 ntc=2, ntf=2,			       ! SHAKE on all H
 ntp=0,				             ! No pressure regulation
 ntt=3,    			           ! Temperature regulation using langevin dynamics
 gamma_ln=5.0, 			       ! Langevin thermostat collision frequency
 ig=-1,				             ! Randomize the seed for the pseudo-random number generator
 ntr=1, 			             ! Flag for restraining specified atoms
 restraint_wt=5.0, 		     ! The weight (in kcal/molA2) for the positional restraints
 restraintmask='(!:WAT & @CA,C,O,N | @2862,2934,3042,3102,3141,3144,3147,3150,3153,3156,3159,3162,3165,3171,3621,3852,4317,457)',
 nmropt=1,			           ! NMR restraints and weight changes read
/
&wt
  TYPE='TEMP0', ISTEP1=0, ISTEP2=48000,
  VALUE1=0.0, VALUE2=293.15,
/
&wt TYPE='END' /

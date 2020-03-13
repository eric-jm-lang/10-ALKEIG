Minimization of side chains
&cntrl
 imin=1, 	 						 ! Turn on minimazation
 ncyc=1000,            ! Number of steepest descent steps
 maxcyc=10000,         ! Total number of miniization cycles
 ntmin=1,              ! Steepest descent for ncyc steps , then conjugate gradient
 ntx=1,                ! Coordinates, but no velocities, will be read;
 cut=10.0,             ! Cut-off electrostatics
 ntwx=10,             ! Coordinates written every ntwx steps
 ntpr=10,              ! Print out energy information every ntpr steps
 ioutfm=1,			       ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			       ! No wrapping will be performed
 ntxo=1, 			         ! NetCDF file
 ntr=1,                ! Restraints turn on
 restraint_wt=1.0,    ! kcal/mol/A**2 restraint force constant
 restraintmask='@CA | @2862,2934,3042,3102,3141,3144,3147,3150,3153,3156,3159,3162,3165,3171,3621,3852,4317,457',
 nmropt=0
/

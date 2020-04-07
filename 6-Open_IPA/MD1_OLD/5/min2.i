Minimization of side chains
&cntrl
 imin=1, 	 						  ! Turn on minimazation
 ncyc=1000,             ! Number of steepest descent steps
 maxcyc=10000,          ! Total number of miniization cycles
 ntmin=1,               ! Steepest descent for ncyc steps , then conjugate gradient
 ntx=1,                 ! Coordinates, but no velocities, will be read;
 cut=10.0,              ! Cut-off electrostatics
 ntwx=10,              ! Coordinates written every ntwx steps
 ntpr=10,               ! Print out energy information every ntpr steps
 ioutfm=1,			        ! Use Binary NetCDF trajectory format (better)
 iwrap=0, 			        ! Wrapping will be performed
 ntxo=2, 			          ! NetCDF file
 ntr=1,                 ! Restraints turn on
 restraint_wt=25.0,     ! kcal/mol/A**2 restraint force constant
 restraintmask='(!:WAT & @CA,C,O,N | @2872,2944,3052,3112,3151,3154,3157,3160,3163,3166,3169,3172,3175,3181,3625,3856,4321,4576,29728,29752,29758,29794,29815,31069,38005,38032,38071,38074)',
 nmropt=0
/

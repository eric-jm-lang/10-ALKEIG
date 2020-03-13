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
 ntxo=2, 			         ! NetCDF file
 ntr=0,                ! Restraints turn on
 nmropt=0
/

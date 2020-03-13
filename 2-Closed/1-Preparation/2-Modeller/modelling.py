from modeller import *
from modeller.automodel import *
from modeller.parallel import * # This enable to work with multiple processor cores
from MyLoop import MyLoop # The MyLoop class is in a different file and thus needs to be imported

j = job()
# The following specify the number of processor cores to use, do not specify more core than you have available on your machine
j.append(local_slave())
j.append(local_slave())
j.append(local_slave())
j.append(local_slave())
#j.append(local_slave())
#j.append(local_slave())
#j.append(local_slave())
#j.append(local_slave())

log.verbose()
env = environ()
env.io.atom_files_directory = ['.', '../atom_files']
# Read in HETATM records from template PDBs
env.io.hetatm = True

# no need to refer to an alignment anymore are there, we just want to optimize the loop
a = MyLoop(env, alnfile='alignment.ali', knowns='closed1_nowat', sequence='closed1_nowat_fill') # assess loops with DOPE

# First single model
a.starting_model = 1
a.ending_model   = 50
a.assess_methods = (assess.DOPE)

# Very thorough optimization:
a.library_schedule = autosched.slow
a.max_var_iterations = 300
# Thorough MD optimization:
a.md_level = refine.slow
# Repeat the whole optimization cycle 2 times
a.repeat_optimization = 2
# Specify that the run should be in parrallel
a.use_parallel_job(j)
a.make()

#!/usr/bin/python
#Sarah wrote this since Peter's normalize script didn't work with files output by cpptraj
#Usage ./normalize_xplor_density_cpptraj.py -x 1P3_ptraj.xplor
#This script removes the last line that cpptraj puts in as -9999, ptraj doesn't include this, so this script will not work on ptraj created data.

##*****************Only tested this on 200x200x200 grid, should work with other sizes but haven't tested it
# This makes sure that we do division with everything like floating
# point numbers, rather than like integers. E.g. without this, 3/4
# will be 0 instead of 0.75
from __future__ import division
import argparse
import numpy as np
from itertools import chain
import sys

#Read in the xplor file that is output from amber
parser = argparse.ArgumentParser(description='Normalize xplor data output from cpptraj')
parser.add_argument('-x','--xplor')
args=parser.parse_args()

#read in xplor file, header is first 7 lines, then xyz occupancy values in groups of 6 per line, up to the number of grid points, then new line, repeat... till last line has value -9999
f = open(args.xplor)
data = f.read().splitlines()
f.close

header = data[0:6]
density = data[6:(len(data)-1)]
footer = data[-1]

#The 4th line of the header contains the number of points from the grid info.  Save this so we know what size chunks to write the xplor format out in
header_values = header[3].lstrip().split()
numptsx = int(header_values[0])
numptsy = int(header_values[3])
numptsz = int(header_values[6])


###Using chain much faster than loop
density_list = list(chain.from_iterable(n.split() for n in density))
density_list = map(float,density_list)

#xplor density prints the number of z sections on its own line starting from 0.  these will occur every x*y number of points, +1 for the index line.  Delete these bc we dont want to include them in our calculations
#del density_list[::40001]
del density_list[::(numptsx*numptsy+1)]
#print(len(density_list))
#print(density_list[0:40003])
#sys.exit("exiting")

max_data = float(np.max(density_list))
#Calculate mean and standard deviation
mean = float(np.mean(density_list))
#default numpy std is divided by n, not n-1.  This is what peter used in original normalize script, so I left it for consistency with previous results
st_dev = float(np.std(density_list))
#normalize list
density_list = [float((x - mean)/st_dev) for x in density_list]

#peter's originial script wrote stuff out as NORMALIZED.xplor, used lowercase so we can tell the difference
outfile = open("%s_normalized.xplor" %args.xplor[:-6], 'w')
for line in header:
    outfile.write("%s\n" % line)

for i in range(0, len(density_list), numptsz):
    chunk = density_list[i:i+numptsz]
    if i%(numptsx*numptsy) == 0:
        outfile.write('%8s\n' %(int(i/(numptsx*numptsy))))
#    print(len(chunk))
    for n in range(0, len(chunk), 6):
        line = chunk[n:n+6]
        line = ['%12.5f'%value for value in line]
        line = ''.join(line) + '\n'
        outfile.write(line)

outfile.write(footer+'\n')
print('The max is %s' %max_data)
print('The mean is %s' %mean)
print('The standard deviation is %s' %st_dev)

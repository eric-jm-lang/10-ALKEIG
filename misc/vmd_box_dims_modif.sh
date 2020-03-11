#!/bin/bash

###############################################################################
# NAME
#   vmd_box_dims.sh
# AUTHOR
#   Benjamin D. Madej
# SYNOPSIS
#
# DESCRIPTION
#   Measures the distance between the maximum and minimum coordinates of the
#   PDB structure in the X, Y, and Z dimensions
# OPTIONS
#   -i
#     input_structure.pdb
#       PDB format molecular structure to be read by VMD
###############################################################################

while getopts ":i:" opt; do
  case $opt in
    i)
      input_structure=$OPTARG
      ;;
  esac
done

cat << EOF > water_box_dims.tcl
mol new $input_structure
set sel [ atomselect top "all" ]
set dims1 [ measure minmax \$sel ]
set cent1 [ measure center \$sel ]
puts "Dimensions1: \$dims1"
puts "Center1: \$cent1"
mol new $input_structure
set sel [ atomselect top "protein or resname ACE NHE" ]
set dims2 [ measure minmax \$sel ]
set cent2 [ measure center \$sel ]
puts "Dimensions2: \$dims2"
puts "Center2: \$cent2"
quit
EOF

vmd -dispdev text -nt -e water_box_dims.tcl > water_box_dims.txt

x_min=`grep Dimensions1 water_box_dims.txt | awk '{print $2}' | sed 's/{//'`
y_min=`grep Dimensions1 water_box_dims.txt | awk '{print $3}'`
z_min=`grep Dimensions1 water_box_dims.txt | awk '{print $4}' | sed 's/}//'`
x_max=`grep Dimensions1 water_box_dims.txt | awk '{print $5}' | sed 's/{//'`
y_max=`grep Dimensions1 water_box_dims.txt | awk '{print $6}'`
z_max=`grep Dimensions1 water_box_dims.txt | awk '{print $7}' | sed 's/}//'`
x_cent=`grep Center1 water_box_dims.txt | awk '{print $2}' | sed 's/{//'`
y_cent=`grep Center1 water_box_dims.txt | awk '{print $3}'`
z_cent=`grep Center1 water_box_dims.txt | awk '{print $4}' | sed 's/}//'`
x_min2=`grep Dimensions2 water_box_dims.txt | awk '{print $2}' | sed 's/{//'`
y_min2=`grep Dimensions2 water_box_dims.txt | awk '{print $3}'`
z_min2=`grep Dimensions2 water_box_dims.txt | awk '{print $4}' | sed 's/}//'`
x_max2=`grep Dimensions2 water_box_dims.txt | awk '{print $5}' | sed 's/{//'`
y_max2=`grep Dimensions2 water_box_dims.txt | awk '{print $6}'`
z_max2=`grep Dimensions2 water_box_dims.txt | awk '{print $7}' | sed 's/}//'`
x_cent2=`grep Center2 water_box_dims.txt | awk '{print $2}' | sed 's/{//'`
y_cent2=`grep Center2 water_box_dims.txt | awk '{print $3}'`
z_cent2=`grep Center2 water_box_dims.txt | awk '{print $4}' | sed 's/}//'`
x_diff=`echo "$x_max - $x_min" | bc`
y_diff=`echo "$y_max - $y_min" | bc`
z_diff=`echo "$z_max - $z_min" | bc`
x_diff2=`echo "$x_max2 - $x_min2" | bc`
y_diff2=`echo "$y_max2 - $y_min2" | bc`
z_diff2=`echo "$z_max2 - $z_min2" | bc`
x_pad=`echo "$x_diff - $x_diff2" | bc`
y_pad=`echo "$y_diff - $y_diff2" | bc`
z_pad=`echo "$z_diff - $z_diff2" | bc`
echo "Dimensions Box:" $x_diff, $y_diff, $z_diff
echo "Dimensions Protein:" $x_diff2, $y_diff2, $z_diff2
echo "Center Box:" $x_cent, $y_cent, $z_cent
echo "Center Protein:" $x_cent2, $y_cent2, $z_cent2
echo "Padding:" $x_pad, $y_pad, $z_pad

rm water_box_dims.tcl water_box_dims.txt

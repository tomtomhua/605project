#!/bin/bash

# assume wd is '605G13'
# take only one argument 
# $1 should be either 1 or 4
if [[ $# -ne 1 ]] ; then 
    echo 'take only one argument which should be either 1 or 4' 1>&2
    exit 0
fi


if [[ $1 -eq 1 ]] ; then
   file=./data/raw/full_dataset1.csv
   rm -rfI ./data/mr_1_loc
   mkdir ./data/mr_1_loc
   awk -F, 'NR>1{ fname = ("./data/mr_1_loc/mr_1_loc_"$15"_"$16".csv"); print >>fname; close(fname) }' $file
elif [[ $1 -eq 4 ]] ; then
   file=./data/raw/full_dataset4.csv
   rm -rfI ./data/mr_4_loc
   mkdir ./data/mr_4_loc
   awk -F, 'NR>1{ fname = ("./data/mr_4_loc/mr_4_loc_"$6"_"$7".csv"); print >>fname; close(fname) }' $file
else
   echo 'undefined dataset' 1>&2
   exit 0
fi



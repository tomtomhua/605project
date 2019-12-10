#!/bin/bash

#unpack R installation
tar -xzf R361.tar.gz
tar -xzf packages.tar.gz

# set script to use your R installation
export PATH=$(pwd)/R/bin:$PATH
export RHOME=$(pwd)/R
export R_LIBS=$PWD/packages



# run R, with the name of your R script
Rscript ts.R $1  # note: the 2 actual command-line arguments
                     # go in myscript.sub's "arguments = " line

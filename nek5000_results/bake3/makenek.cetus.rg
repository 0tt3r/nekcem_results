#!/bin/bash
#-------------------------------------------------------------------------------
# Nek5000 build file
#-------------------------------------------------------------------------------

# installation path
SOURCE_ROOT="/gpfs/mira-home/mmin/codes/CEED_ANL/bake3/Nek5000"

# fortran/C compiler
#F77="mpif77"
#CC="mpicc"
F77="mpixlf77 -qsuppress=cmpmsg"

# C compiler
CC="mpixlc"

# pre-processor symbol list
# (set PPLIST=? to get a list of available symbols)
PPLIST="MPIIO"



# pre-processor list (set to "?" to get a list of available symbols)
#PPLIST="" 

# generic compiler flags
#G="-g"

# linking flags
#USR_LFLAGS="-L/usr/lib -lfoo"

###############################################################################
# WHAT FOLLOWS ARE OPTIONAL SETTINGS
###############################################################################

# MPI (default true)
#IFMPI="false"

# profiling (default false)
IFPROFILING="true"

# auxilliary files to compile
# NOTE: source files have to located in the same directory as makenek
#       a makefile_usr.inc has to be provided containing the build rules 
#USR="foo.o"

# enable VisIt in situ
#  Note: you can override the lib and include paths. VISIT_LIB and VISIT_INC
#  If VISIT_STOP is set the simulation will stop after first step and wait
#  for VisIt to connect.
#IFVISIT=true
#VISIT_INSTALL="/path/to/visit/current/linux-x86_64/"
#VISIT_STOP=true

# paths
SOURCE_ROOT_CORE="$SOURCE_ROOT/core"
SOURCE_ROOT_JL="$SOURCE_ROOT/jl"
SOURCE_ROOT_CMT="$SOURCE_ROOT/core/cmt"

###############################################################################
# DONT'T TOUCH WHAT FOLLOWS !!!
###############################################################################
set -e
# assign version tag
mver=17.0.0
# overwrite source path with optional 2nd argument
if [ -d $2 ] && [ $# -eq 2 ]; then
  SOURCE_ROOT="$2"
  echo "change source code directory to: ", $SOURCE_ROOT
  SOURCE_ROOT_CORE="$SOURCE_ROOT/core"
  SOURCE_ROOT_JL="$SOURCE_ROOT/jl"
  SOURCE_ROOT_CMT="$SOURCE_ROOT/core/cmt"
fi
# do some checks and create makefile
source $SOURCE_ROOT_CORE/makenek.inc
# compile
make -j4 -f makefile 2>&1 | tee compiler.out
exit 0

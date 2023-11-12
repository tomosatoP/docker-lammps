#!/bin/bash

mkdir -p build_check
cd build_check

INPUT_FILE=/data/examples/melt/in.melt

# GPU + OpenMPI + OpenMP(not package)
mpirun --allow-run-as-root -x OMP_NUM_THREADS=1 -np 6 lmp -sf gpu -in $INPUT_FILE

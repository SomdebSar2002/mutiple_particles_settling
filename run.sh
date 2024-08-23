#!/bin/bash
. ~/.bashrc

#- include functions
#- source CFDEM env vars
source $CFDEM_SRC_DIR/lagrangian/cfdemParticle/etc/functions.sh

# Path variables
#OF_CASE_DIR=~/CFDEM/somdeb-PUBLIC-5.x/run/particles_in_cavity/CFD
#LIGGGHTS_DIR=~/CFDEM/somdeb-PUBLIC-5.x/run/particles_in_cavity/DEM
casePath="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
logpath=$casePath
headerText="run_parallel_flb"
logfileName="log_$headerText"
solverName="cfdemSolverPiso"
nrProcs="4"
machineFileName="none"   # yourMachinefileName | none
debugMode="off"          # on | off| strict | profile
#testHarnessPath="$CFDEM_TEST_HARNESS_PATH"
runOctave="false"
postproc="true"
# Function to run OpenFOAM CFD simulation
rm -rf /home/somdeb/CFDEM/somdeb-PUBLIC-5.x/run/oneparticlefallingwater/CFD/processor*
foamCleanTutorials
cd CFD/
blockMesh
decomposePar
cd ..
parCFDDEMrun $logpath $logfileName $casePath $headerText $solverName $nrProcs $machineFileName $debugMode

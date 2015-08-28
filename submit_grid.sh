#!/bin/bash

if [[ $1 != 0 && $1 != 1 && $1 != 2 ]] 
then
    echo "No arguments supplied. Use the following options:"
    echo "Submit stage 1 jobs:   ./submit_grid.sh 0"
    echo "Submit PS jobs:        ./submit_grid.sh 1"
    echo "Submit Beam jobs:      ./submit_grid.sh 2"
    exit
fi

if [ $1 == 0 ]
then
    command="mu2eg4bl --in=Mu2E.in --tar=Geometry.tar --njobs=200 --events-per-job=5000 --g4bl-version=v2_16 --g4bl-add-args='READ_Beam_File=$1'"
else
    command="mu2eg4bl --in=Mu2E.in --tar=Geometry.tar --njobs=500 --events-per-job=2000000 --g4bl-version=v2_16 --g4bl-add-args='READ_Beam_File=$1'"
fi

cp Mu2E.in Geometry
tar cf Geometry.tar Geometry
echo "Executing:" $command
echo `$command`
now=$(date +"%m_%d_%Y")
cp Geometry.tar Geometry_${PWD##*/}_${now}_${1}.tar

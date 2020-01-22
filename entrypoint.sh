#!/bin/sh -l

echo "Hello $1"
time=$(date)
echo ::set-output name=time::$time
pwd
touch testfile.from-docker
ls


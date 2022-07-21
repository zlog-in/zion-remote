#!/bin/bash

workdir=$PWD
cd ../Zion
make geth
cp build/bin/geth $workdir
cd $workdir
md5sum geth

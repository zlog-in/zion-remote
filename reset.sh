#!/bin/bash

./stop_all.sh
rm -rf geth
rm -rf node*

./build.sh
./init_all.sh
./start_all.sh
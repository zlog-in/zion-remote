#!/bin/bash

num=3
for i in $(seq 0 $num)
do
    node="node"$i;
    kill -s SIGINT $(ps aux|grep geth|grep $node|grep -v grep|awk '{print $2}');
done

ps -ef|grep geth

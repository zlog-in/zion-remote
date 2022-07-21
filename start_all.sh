#!/bin/bash

startP2PPort=30300
startRPCPort=22000
chainID=60801
coinbases=(0x258af48e28e4a6846e931ddff8e1cdf8579821e5 0x6a708455c8777630aac9d1e7702d13f7a865b27c 0x8c09d936a1b408d6e0afaa537ba4e06c4504a0ae 0xad3bf5ed640cc72f37bd21d64a65c3c756e9c88c)

num=3
for i in $(seq 0 $num)
do
    port=`expr $startP2PPort + $i`
    rpcport=`expr $startRPCPort + $i`
    miner=${coinbases[$i]}
    node="node$i"
    echo "$node and miner is $miner"

    nohup ./geth --mine --miner.threads 1 \
    --miner.etherbase=$miner \
    --identity=$node \
    --maxpeers=100 \
    --syncmode full \
    --gcmode archive \
    --allow-insecure-unlock \
    --datadir $node \
    --networkid $chainID \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --http --http.addr 0.0.0.0 --http.port $rpcport --http.vhosts "*" \
    --rpc.allow-unprotected-txs \
    --nodiscover \
    --port $port \
    --verbosity 5 >> $node/node.log 2>&1 &

    sleep 1s
done

ps -ef|grep geth
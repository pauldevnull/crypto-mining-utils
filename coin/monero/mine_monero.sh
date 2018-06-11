#!/bin/bash

if [ -z "$1" ]; then
        echo "ERROR: Missing required parameter: POOL"
        exit 1
fi

export GPU_FORCE_64BIT_PTR=0
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_HEAP_SIZE=100
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100

POOL=$(cat ../../properties.json | jq '.coin.xmr.pool.'$1'.url' | sed -e 's/^"//' -e 's/"$//')
PORT=$(cat ../../properties.json | jq '.coin.xmr.pool.'$1'.port' | sed -e 's/^"//' -e 's/"$//')
PASSWORD=$(cat ../../properties.json | jq '.coin.xmr.pool.'$1'.password' | sed -e 's/^"//' -e 's/"$//')
WALLET=$(cat ../../properties.json | jq '.coin.xmr.wallet' | sed -e 's/^"//' -e 's/"$//')
WORKER_ID=$(cat ../../properties.json | jq '.workerId' | sed -e 's/^"//' -e 's/"$//')
EMAIL=$(cat ../../properties.json | jq '.email' | sed -e 's/^"//' -e 's/"$//')
MINER_PATH=$(cat ../../properties.json | jq '.coin.xmr.minerPath' | sed -e 's/^"//' -e 's/"$//')

./$MINER_PATH \
--noAMD \
--currency monero7 \
-o $POOL:$PORT \
-u $WALLET \
-p $WORKER_ID:$EMAIL

exit 0


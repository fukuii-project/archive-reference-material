#!/usr/bin/env bash

# HTTP
curl -X POST $(curl icanhazip.com/v4):8545 --data '{"jsonrpc":"2.0","method":"trace_transaction","params":["0x552280896083bfe801a1f70c84011d1b4195a2c08d2221f80245380775cd6270"],"id":1}' -H "Content-Type: application/json
http --json POST http://localhost:8545 id:=$(date +%s) method='rpc_discover' params:='[]'

# Websocket
echo rpc.discover | websocat -B 650000 -n1 --jsonrpc ws://localhost:8546

# IPC
echo '{"jsonrpc":"2.0","method":"rpc.discover","params":[],"id":71}' | nc -U -W1 -I653366 /tmp/geth-test.ipc
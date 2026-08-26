#!/usr/bin/env bash

cat <<EOF > /etc/systemd/system/coregeth_mordor.service 
[Unit]
Description=CoreGeth Mordor

[Service]
Type=simple
User=root
Restart=always
RestartSec=3
TimeoutStopSec=10min
ExecStart=/bin/sh -c '/root/go/bin/geth --mordor --datadir /mnt/chaindata_vol/mordor --ipcpath /tmp/geth_mordor.ipc --port 30317 --maxpeers 50 --verbosity 5 --http --http.port 8588 --metrics --metrics.expensive --pprof --mine --miner.gaslimit=80000000 --miner.gastarget=80000000 --miner.gasprice=1 --light.serve=50'

[Install]
WantedBy=default.target
EOF

systemctl daemon-reload # Run this every time you make a change to the unit file.

systemctl start coregeth_mordor.service
# systemctl stop coregeth_mordor.service
# systemctl restart coregeth_mordor.service

journalctl -u coregeth_mordor.service -f 
# journalctl -u coregeth_mordor.service --since '1 hour ago' > debug.log
# journalctl -u coregeth_mordor.service -f | grep -v -E '(DEBUG|TRACE)'

#!/usr/bin/env bash

[[ -z $1 ]] && { echo "Pass [mordor|kotti] as ARG1"; exit 1; }

set -e

[[ -d $HOME/.faucet ]] && { echo "Backing up exiting .faucet datadir" && mv $HOME/.faucet $HOME/.faucet.bak; }

onexit()
{
  echo "Running exit commands..."
  
  [[ -d $HOME/.faucet.bak ]] && { echo "Rmrfing temporary .faucet datadir and replacing with existing .faucet datadir" && rm -rf "$HOME/.faucet" && mv $HOME/.faucet.bak $HOME/.faucet; } 
  echo "Removing temporary pass file"
  rm -f pass.txt
  echo "Removing temporary keystore dir"
  rm -rf ./ks  
}
trap onexit EXIT

echo "Making temporary keystore dir: ./ks"
mkdir -p ks
echo "Creating temporary pass file: pass.txt"
echo foo > pass.txt

# create key
echo "Creating temporary keyfile..."
./build/bin/geth --lightkdf --keystore=./ks account new --password=pass.txt 
keyfile=$(find ks -type f | head -1)
echo "Tmp keyfile: $keyfile"


./build/bin/faucet -apiport 8888 -ethport 33333 -chain."${1}" -faucet.name="${1}" -account.json="$keyfile" -account.pass=pass.txt -faucet.amount=5 -loglevel=6 


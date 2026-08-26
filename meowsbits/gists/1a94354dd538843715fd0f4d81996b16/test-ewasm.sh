#!/usr/bin/env bash

SO_SSVM=/home/ia/dev/second-state/SSVM/build/tools/ssvm-evmc/libssvmEVMC.so 
SO_HERA=/home/ia/dev/ewasm/hera/build/src/libhera.so 

SO_PATH=''

if [[ $1 = ssvm ]]; then 
	SO_PATH="$SO_SSVM"
elif [[ $1 = hera ]]; then
	SO_PATH="$SO_HERA"
fi

[[ -z "$SO_PATH" ]] && echo "Use 'hera' or 'ssvm' as arg1" && exit 1

echo "Running EWASM tests for $SO_PATH"

echo '> go test -v ./tests/... -run TestState -evmc.ewasm='"$SO_PATH" | tee test.$1.log
go test -v ./tests/... -run TestState -evmc.ewasm="$SO_PATH" |& tee test.$1.log

# grep -A2 FAIL test.*.log
# grep -B5 -A5 'segementation violation' test.*.log


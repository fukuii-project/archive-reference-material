## The interrelated stories of at least but not limited to EIP1283, EIP1706, EIP2200, EIP1884, ECIP1061, ECIP1078, and ECIP1086.

EIP1283 comes into existence. Has way of net gas metering. Gets `Final`ized.

EIP____ ("Constantinople") comes into existence specifying enabling EIP1283 on ETH (and testnets).

EIP1283 enabled on Ropsten and other testnets.

Uh oh! EIP1283 has bugs.

EIP____ ("St. Petersburg") comes into existence specifying disabling EIP1283.

EIP____ ("St. Petersburg") enabled on Ropsten via Constantinople.

EIP____ ("St. Petersburg") enabled on ETH simultaneous to Constantinople.

EIP1706 comes into existence. Has way to fix EIP1283.

EIP1884 comes into existence. Has way of pricing opcodes. Gets `Final`ized.

EIP2200 comes into existence. Has another way of net gas metering. Gets `Final`ized. Secretely depends on prices specified in EIP1884.

EIP2200 and EIP1884 get enabled on ETH as of "Istanbul" fork.

Classic wants Net Gas metering too.

ECIP1061 and ECIP1072 ("Aztlan") come into existence, specifying EIP2200 without EIP1884.

ECIP1061 gets enabled on Mordor and Kotti.

Uh oh! EIP2200 without EIP1884 has bugs.

ECIP1078 ("Phoenix") comes into existence, specifying disabling EIP2200, instead enabling EIP1283 and EIP1706.

Uh oh! Greg thinks EIP2200 implementation is incorrect at ethereum/go-ethereum, etclabscore/multi-geth, multi-geth/multi-geth, paritytech/parityethereum (finds out with feature-isolating tests at hyperledger/besu).

Changes are implemented at ethereum/go-ethereum, etclabscore/multi-geth, paritytech/parityethereum to fix the EIP2200 implementation bug Greg found.

Uh oh! Fixing the EIP2200 implementation bug would break Kotti and Mordor.

ECIP1086 comes into existence, specifying an "allowance" for the incorrect EIP2200 implementation on Mordor and Kotti.

Uh oh! @sorpaas suggests maybe actually EIP2200 itself is buggy (it doesn't actually modify the `SLOAD` gas, and doesn't explicitly require EIP1884; although this was the intention). 
  - https://github.com/ethereum/EIPs/pull/2514 

So now, no one actually knows for sure what EIP2200 was actually supposed to do, or what it even really is, or what it's allowed to become (if edits are permissable to a `Final` EIP).

And maybe the ethereum/go-ethereum, etclabscore/multi-geth, multi-geth/multi-geth, and paritytech/parityethereum providers had accidentally implemented the buggy spec correctly,
rendering ECIP1086 useless, the EIP2200 code "fixes" incorrect, and the whole lot of us humbled, a little, by our intentions.

--- 

From the perspective of the `SLOAD` gas cost:

- ( EIP2200 may depend on EIP1884, but does not, itself, modify `SLOAD` gas ) == ( EIP2200 does not depend on EIP1884, but does, itself, modify `SLOAD` gas )
- ( EIP2200 may not depend on EIP1884, and does not, itself, modify `SLOAD` gas ) == ( EIP2200 does not depend on EIP1884, and does not, itself, modify `SLOAD` gas )

From the perspective of network configuration:

If EIP2200 _DOES NOT_ modify `SLOAD` gas (whether via a permitted `requires: EIP1884` revision, or, if the revision is not permitted, neither by specifying the value itself):

+ EIP2200 code implementation "fixes" become incorrect; ethereum/go-ethereum, etclabscore/core-geth, multi-geth/multi-geth, and paritytech/parity-ethereum should revert the "EIP2200 fix" implementation to reflect EIP2200 actually not modifying `SLOAD` cost
+ ethereum/go-ethereum, etclabscore/core-geth, multi-geth/multi-geth, paritytech/parity-ethereum, and hyperledger/besu should add code to reflect EIP2200 depending on EIP1884
+ hyperledger/besu should fix its EIP2200 implementation to not modify `SLOAD` gas cost
+ ECIP1086 becomes useless
+ and..
  - if via `requires: EIP1884`:
    + The spirit of ECIP1086 remains valid, but the spec does not (see point immediately below)
    + Another ECIP-x would be needed to permit EIP2200 to be enabled on Kotti and Mordor without the revision-specified adjacent EIP1884 enablement.
    + protocol providers would need to add code implementing the new ECIP-x "allowance specification" (relevant for Kotti and Mordor)
  - via specification itself:
    + nothing more

If EIP2200 _DOES_ modify `SLOAD` gas (by specifying the value itself):
  - ECIP1086 remains valid
  - Corrections to ethereum/go-ethereum, etclabscore/core-geth, multi-geth/multi-geth, and paritytech/parity-ethereum are correct

--- 

### FAQ

- Does EIP2200 specify `SLOAD` gas cost = `800`? (NOT asking if EIP1884 requires it and then, if EIP2200 requires EIP1884)
  > EIP-2200 does not currently specify whether it changed SLOAD gas price or not. The canonical interpretation should be that it does not, because all variables used inside the specification is internal. 
  >
  > https://twitter.com/sorpaas/status/1229890646971949059
- Can EIP2200 retroactively specify a requirement on EIP1884?

#### ETC

- So what do we want the gas cost for `SLOAD` to actually be? (eg. EIP1884)
- What about the gas cost of `BALANCE`? (eg. EIP1884)



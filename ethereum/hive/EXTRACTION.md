# `etc/ethereum/hive` — an extraction, not a mirror

**A subset, deliberately.** Upstream is `https://github.com/ethereum/hive`, tracked as a live
pinned submodule at `../../../eth/ethereum/hive`. Only material that upstream has **removed** is
copied here.

## What was extracted, and from which ref

| path | ref | removed | files |
|---|---|---|---:|
| `simulators/dao-hard-fork/` | `a5a4da98^` | 2020-09-30 | 11 |
| `simulators/devp2p/` (`eth`, `discv4`) | `0524a7e5^` | 2022-02-09 | 12 |

23 files, 2.9 MB. Extracted 2026-08-21, verified byte-identical to those refs.

## Why this material matters to Ethereum Classic

**The DAO hard-fork suite tests the fork Ethereum Classic declined.** `network-split` and
`synchronisation` exist to check that a client follows the right chain across the split, and the
synchronisation suite ships **both** chains to test against — `nofork-chain.rlp.tar.xz` and
`profork-chain.rlp.tar.xz`.

The no-fork chain *is* Ethereum Classic. Upstream removed this in 2020 because Ethereum has no
further use for it; for this network it describes the founding event.

**The `devp2p` suites are proof-of-work-era wire and discovery conformance.** What survives at
upstream HEAD under `simulators/devp2p` is a proof-of-stake-oriented harness carrying
`init/beacon/`. The `eth` and `discv4` suites removed in 2022 are the ones written against a
proof-of-work network.

## Reproducing it

```sh
H=<a clone of ethereum/hive>
git -C "$H" archive a5a4da98^ simulators/dao-hard-fork | tar -x -C .
git -C "$H" archive 0524a7e5^ simulators/devp2p        | tar -x -C .
```

Anyone can re-derive this from the pin and compare. **An extraction whose derivation is not
stated is unverifiable.**

## Scope

Only removed material is here. Everything upstream still ships is reachable through the pin, and
copying it would preserve nothing the pin does not already carry.

`legacytests` and `devp2p` were checked the same way on 2026-08-21 and needed no extraction:
`devp2p`'s last content deletion was 2020 and cosmetic, and every `legacytests` deletion is
post-Merge `Cancun/` material.

## This is not runnable as-is

These are hive simulators pinned to a 2020-2022 hive API, in Go modules whose dependencies have
moved on. They are preserved as **source material**, not as a working suite. Reviving one means
porting it to the current hive interface — which is exactly why keeping the original is worth
2.9 MB.

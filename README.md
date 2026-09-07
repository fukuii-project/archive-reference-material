# `archive/` — frozen. Do not edit anything under this directory.

Preserved copies of material that upstreams have deprecated, deleted, or will. **Nothing here is
maintained, corrected, or relabelled by this project.** It is the historical record, and its
value is that it is exactly what upstream published.

### Test corpora

| entry | source | posture |
|---|---|---|
| `etclabscore/tests` | `etclabscore/tests` @ `06ec708ea7` | full vendor, full history — upstream deprecating |
| `ethereumproject/tests` | `ethereumproject/tests` @ `c05254038` | full vendor — **the original ETC suite**, org archived |
| `multi-geth/tests` | `multi-geth/tests` @ `784ff9641` | full vendor — the multi-geth-era cross-client suite |
| `etclabscore/hive` | `etclabscore/hive` @ `dd1a8a2d6` | full vendor — the ETC end-to-end harness |
| `etclabscore/goldset` | `etclabscore/goldset` @ `2a3514bc8` | full vendor — historical results against the live network |
| `ethereum/tests` | `ethereum/tests` | extraction — only material no upstream holds |
| `ethereum/hive` | `ethereum/hive` | extraction — suites upstream removed |

### The client lineage

Every production client that ever secured this chain, whole and with history. **This chain has
had core-dev churn where Ethereum has had one client throughout, so its clients ARE the record of
its eras** — and a subset cannot show how a client changed across one.

| entry | source | frozen at | era |
|---|---|---|---|
| `ethereum/go-ethereum-dao` | `ethereum/go-ethereum` @ `b7e3dfc5a` | 2016-06-29 | the shared ancestor, immediately before the DAO fork |
| `ethereumproject/go-ethereum` | `ethereumproject/go-ethereum` @ `22f308105` | 2019-08-29 | **Classic Geth** — the first ETC-specific client |
| `ethereumproject/parity` | `ethereumproject/parity` @ `92466a7d6` | 2018-04-06 | ETC's own Parity fork |
| `openethereum/parity-ethereum-dao` | `openethereum/parity-ethereum` @ `2cf4549d0` | 2016-07-16 | Parity at the DAO fork |
| `openethereum/parity-ethereum` | `openethereum/parity-ethereum` @ `55c90d401` | 2020-02-05 | Parity at its last ETC-supporting state |
| `openethereum/openethereum` | `openethereum/openethereum` @ `8ca8089e9` | 2020-06-01 | **extraction only** — not in the whole-vendor pass |
| `multi-geth/multi-geth` | `multi-geth/multi-geth` @ `38865665e` | 2021-02-27 | between Parity and core-geth |
| `besu-eth/besu-etc` | `besu-eth/besu` @ `eb4248c99` | 2026-02-09 | Besu's ETC support, which lives only in a fork org |
| `etclabscore/core-geth` | `etclabscore/core-geth` @ `7ef3ecd7a` | 2024-12-16 | the client after multi-geth, frozen at the repository boundary |

**Two repositories are named core-geth. Read the organization, not the bare name.**

**`ethereumclassic/core-geth` is deliberately absent.** It is the live production client with one
more release planned, so it fails the test this directory applies — what disappears if the upstream
vanishes tomorrow. Vendor it when it is actually deprecated, not before.

**`etclabscore/core-geth` is a different repository and is in the table above**, frozen at the
commit the successor was created from. It holds the era the ETC Cooperative funded — from January
2022 until that organization moved to maintenance mode at the end of 2024 — and `PROVENANCE.md`
cites the Cooperative's own published record for both ends of it. Its upstream is alive and has
committed past that commit; that continuation is deliberately unreachable here, and completing it
would erase the boundary the entry exists to record.

`PROVENANCE.md` records refs, dates, and known defects. Read it before using any of this.

## Frozen means frozen, including the defects

Parts of this material are **wrong**, and they stay wrong.

The clearest case: `etclabscore`'s Ethereum Classic fork labels were produced by a text
substitution over Ethereum fixtures, and a rename does not change the EIP set inside a fixture.
Some labels overclaim. One rewrite mapped Ethereum's proof-of-stake transition onto a
proof-of-work upgrade, so fixtures carrying `difficulty: 0x00` sit under an Ethereum Classic
label — asserting that a difficulty-zero block is valid, which on this network it is not.

**Do not fix them here.** A corrected mirror is no longer a mirror: it cannot be compared against
what upstream published, which is the only reason to keep a copy of a dead corpus. The defects
are documented in `PROVENANCE.md` so a reader knows what they are holding.

## What to do instead

**Build the Fukuii suite outside this directory, using this as source material.** `../proposals/`
and `../networks/` are ours; everything here is inherited.

Where a fixture here is sound, our suite can reference it. Where it is wrong, our suite carries
the correct version — as our work, named our way, with the archive left untouched as the record
of what was inherited.

## Practical consequences

- **No formatting hooks run here.** A conformance vector's bytes are its meaning; the exclusion in
  `.pre-commit-config.yaml` covers this whole directory.
- **Mirrored names are kept exactly** — directories, filenames, and the fork labels inside a
  fixture. The naming rule in `AGENTS.md` governs what we author, never this.
- **Adding to the archive is expected; changing it is not.** When an upstream deletes something
  else, extract it here and record the refs.
- **A vendored tree is verified by TREE HASH, never by diff.** `git subtree` relocates a corpus
  under a prefix, so `git diff <ref>..HEAD -- <path>` reports every file as added and proves
  nothing. Compare `git rev-parse '<ref>^{tree}'` in the source clone against
  `git rev-parse 'HEAD:archive/<org>/<repo>'` here; two identical hashes is the whole proof. All
  eleven vendors in the lineage pass it.

# Provenance — `archive/`

Every corpus here is copied and maintained by this project, because its upstream is disappearing
or is deleting the parts Ethereum Classic depends on. Pins to live upstreams live in
`../upstream/PROVENANCE.md` instead.

**Two postures, chosen by what would be lost if the upstream vanished tomorrow.**

## `etclabscore/tests/` — full vendor, full history

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/tests` |
| branch | `main` |
| ref | `06ec708ea7` |
| upstream date | 2023-08-25 |
| vendored | 2026-08-21 |
| mechanism | `git subtree add`, **full history** — 3,182 commits |
| contents | 9,296 files · 8,728 json · 934 MB |

**Verified at vendoring:** file and json counts match the source exactly, `GeneralStateTests/`
compares byte-identical, and `06ec708ea7` is addressable here.

### Why all of it, and why the history

The upstream is scheduled for deprecation, so **every part of it is at risk** — including the
history, which is the only record of how the ETC labels were produced. It is also a **live build
dependency of the production Ethereum Classic client**, which consumes it as a submodule, so its
removal breaks a running conformance suite rather than merely an archive.

### Frozen at `06ec708ea7` — and here is how to prove it

This corpus is **not maintained here**. It is the upstream state at that ref and stays that way.

**Check it by tree hash, not by diff.** `git subtree` relocates the corpus under a prefix, so
`git diff <ref>..HEAD -- <path>` compares upstream's root-level paths against our prefixed ones
and reports every file as added. That command reads like a freeze check and is not one — it
returned "9,298 files changed" against an archive that had never been touched.

Compare the trees directly instead:

```sh
git rev-parse '06ec708ea7^{tree}'
git rev-parse 'HEAD:archive/etclabscore/tests'
```

**Two identical hashes is the whole proof** — the archive is bit-for-bit upstream's tree. Verified
2026-08-21: both are `4f98c5a20296d80639bf64c7897a85d5897f2bc1`.

If they ever differ, something edited the archive. That is a defect to revert, not a change to
review.

Gaps and inherited mistakes are answered in the Fukuii suite outside `archived/`, never by
editing these files.

### Known defects, measured 2026-08-21 — preserved as published, NOT corrected

The ETC fork labels were produced by a text substitution (`makeetc.sh`) over Ethereum fixtures.
**Renaming a label does not change the EIP bundle inside the fixture.**

| label | files | derived from | sound? |
|---|---:|---|---|
| `ETC_Phoenix` | 7,469 | Istanbul | yes — equivalent bundle |
| `ETC_Magneto` | 5,301 | Berlin | yes — the client calls it equivalent |
| `ETC_Agharta` | 96 | Constantinople+Fix | probably |
| `ETC_Atlantis` | 90 | Byzantium | **no** — bundle divergence |
| `ETC_Mystique` | 5,496 | London | **no** — bundle divergence |
| `ETC_Spiral` | ~0 | — | **absent** — current mainnet has no coverage |

The sharpest defect: `Merge` was renamed onto `ETC_Mystique` at scale, and Merge-labelled blocks
carry proof-of-stake semantics — `difficulty: 0x00`, zeroed `mixHash`, zero `nonce`. **Those
fixtures assert that a difficulty-0 block is valid. On a proof-of-work chain it is not.**

See `../networks/` for the mapping that supersedes these labels. Read rule sets from the
production client, never from a rendered specification.

### Easy to lose

`etclabscore/tests/src-etc/` — 24 filler files including `stChainId`. The only **ETC-authored**
test source that exists upstream, as opposed to renamed Ethereum material.

## `ethereum/tests/` — extraction, a subset

**Not a mirror.** Upstream is alive and pinned at `../upstream/ethereum/tests`; only material no
upstream will hold is copied here.

4,266 files, 62 MB, drawn from **two refs**, because purged material can only be read from a
commit before its purge.

`ethereum/EXTRACTION.md` is the authority: each path, its source ref, the reason, and the commands
to re-derive and verify it.

### Why a subset here and everything there

`etclabscore` is dying, so all of it is at risk. `ethereum/tests` is not — a non-shallow clone at
the pin carries upstream's full history, purged files included. Copying it wholesale would spend
hundreds of megabytes to preserve what a pin already reaches.

What the pin cannot survive is deletion, a history rewrite, or a shallow clone — and it cannot
make purged material discoverable. That is what is extracted, and nothing more.

---

# The Ethereum Classic client lineage — vendored whole, 2026-08-24

**Eleven repositories, whole, with history.** Operator decision: this chain's clients are the
record of its eras. Ethereum has had one client present throughout; Ethereum Classic has had
core-dev churn — Classic Geth, then Parity, then multi-geth, then core-geth, and now Fukuii — and
an extraction cannot show how a client changed across an era.

**Mechanism:** `git subtree add` without `--squash`, from a local clone at the named ref. Every
one is verified by TREE HASH against its source — `git rev-parse '<ref>^{tree}'` equals
`git rev-parse 'HEAD:archive/<prefix>'` for all eleven. A diff proves nothing here, because
subtree relocates the corpus under a prefix and reports every file as added.

**Totals:** 65,506 commits, 44,830 files, 1,794 MB.

**Nothing exceeds GitHub's 100 MB per-file limit** — checked across every object in every
vendored history before any of it landed, largest 62.0 MB. That check is not optional: grafted
history is permanent, and one oversized blob would make this repository unpushable forever.


## `ethereumproject/go-ethereum/`

| field | value |
|---|---|
| upstream | `https://github.com/ethereumproject/go-ethereum` |
| ref | `master` @ `22f3081057bb5087686dac5733450b26ab3cf730` |
| upstream date | 2019-08-29 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 9,605 commits |
| contents | 1,439 files · 329 MB |

Classic Geth — the ORIGINAL Ethereum Classic client, and the first link in this chain's client lineage. It carried the network from the 2016 split until core-geth. **Its entire GitHub organization is archived — all 44 repositories — so nothing upstream is maintained and the repository is read-only.** `master` is its ETC-supporting state: unlike Parity and multi-geth, this client never dropped the chain, it was retired with it.


## `ethereumproject/tests/`

| field | value |
|---|---|
| upstream | `https://github.com/ethereumproject/tests` |
| ref | `EIP150` @ `c0525403872fe3eb50f13500184dff1b8256395f` |
| upstream date | 2016-10-18 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 908 commits |
| contents | 802 files · 281 MB |

The original Ethereum Classic common test suite. **Frozen on branch `EIP150`, not `master`** — that is the branch the repository was left on, and taking `master` here would answer a different question. Org archived.


## `ethereumproject/parity/`

| field | value |
|---|---|
| upstream | `https://github.com/ethereumproject/parity` |
| ref | `master` @ `92466a7d6689900b28dce566afbbddd87b2bbe95` |
| upstream date | 2018-04-06 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 8,787 commits |
| contents | 2,552 files · 15 MB |

Ethereum Classic's own fork of Parity, distinct from `openethereum/parity-ethereum` which is the upstream lineage. Org archived.


## `openethereum/parity-ethereum/`

| field | value |
|---|---|
| upstream | `https://github.com/openethereum/parity-ethereum` |
| ref | `etc-frozen` @ `55c90d4016505317034e3e98f699af07f5404b63` |
| upstream date | 2020-02-05 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 12,342 commits |
| contents | 1,029 files · 13 MB |

Parity at its last Ethereum Classic-supporting state. **The repository is archived on GitHub** (2020-11-01). Supersedes the nine-file extraction previously held at this path — every one of those blobs is byte-identical inside this vendor, verified before the extraction was cleared.


## `openethereum/parity-ethereum-dao/`

| field | value |
|---|---|
| upstream | `https://github.com/openethereum/parity-ethereum-dao` |
| ref | `dao-frozen` @ `2cf4549d0181ad1d60fbd3bbe132b599a14a8965` |
| upstream date | 2016-07-16 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 4,749 commits |
| contents | 538 files · 4 MB |

The same repository at the DAO fork. **This ref is not an ancestor of the one above** — they share root `f7b618cec` and diverge — so vendoring one does not preserve the other. It is the source of `frontier-dogmatic.json`, which sits beside `frontier.json` differing only by the removed `daoHardfork*` block: the declining chain expressed as a config diff, and this suite's fork-identifier primary source.


## `multi-geth/multi-geth/`

| field | value |
|---|---|
| upstream | `https://github.com/multi-geth/multi-geth` |
| ref | `etc-frozen` @ `38865665e94b14d4e9595478789b5d15f925003b` |
| upstream date | 2021-02-27 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 12,704 commits |
| contents | 1,567 files · 33 MB |

The client between Parity and core-geth. Supersedes the eleven-file extraction previously held at this path, verified byte-identical first. Shares root commit `5db3335dc` with core-geth — **one lineage under two names, never a second oracle.**


## `multi-geth/tests/`

| field | value |
|---|---|
| upstream | `https://github.com/multi-geth/tests` |
| ref | `develop` @ `784ff964111cf1e1d2d52db0cfd06796bd03321c` |
| upstream date | 2019-06-09 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 2,176 commits |
| contents | 28,279 files · 723 MB |

The multi-geth-era cross-client suite, described upstream as an unfork of `ethereum/tests`. Dormant since 2019 with no stars. The largest entry in this pass at 723 MB and 28,279 files.


## `ethereum/go-ethereum-dao/`

| field | value |
|---|---|
| upstream | `https://github.com/ethereum/go-ethereum-dao` |
| ref | `pre-dao` @ `b7e3dfc5a2bc7e2f4d653fbe0ec9774277a10643` |
| upstream date | 2016-06-29 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 7,413 commits |
| contents | 2,121 files · 330 MB |

go-ethereum immediately before the DAO fork: the last state both chains share, and therefore the strongest oracle available for Frontier and Homestead — before the split there is no such thing as Ethereum's implementation as against this chain's. The upstream is in no danger; this is held for the ERA, not for preservation.


## `besu-eth/besu-etc/`

| field | value |
|---|---|
| upstream | `https://github.com/besu-eth/besu-etc` |
| ref | `etc-frozen` @ `eb4248c997cb79cc88db55ead562081a43721a3b` |
| upstream date | 2026-02-09 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 6,443 commits |
| contents | 5,973 files · 61 MB |

Besu's Ethereum Classic support. **The upstream is a fork organization, not Hyperledger** — `besu-eth/besu` — and the ETC material appears nowhere in `hyperledger/besu`. The org is active, so this is vendored against fork-org risk rather than dormancy. A third independent lineage: root `7dfc2e408`, sharing no commit with geth or Parity, and this suite's third oracle for the difficulty rules. Its ETC surface is six files; a token search for `ecip1010` finds none of them, because the rule lives in `ClassicDifficultyCalculators`.


## `etclabscore/hive/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/hive` |
| ref | `master` @ `dd1a8a2d6b3424c102cc66418e8af01b6a0c043a` |
| upstream date | 2019-02-27 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 378 commits |
| contents | 528 files · 5 MB |

The Ethereum Classic fork of the end-to-end test harness. Distinct from `ethereum/hive`, which is held here as an extraction.


## `etclabscore/goldset/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/goldset` |
| ref | `master` @ `2a3514bc8eddfaf6251e2a9530afd17744aa893d` |
| upstream date | 2020-05-06 |
| vendored | 2026-08-24 |
| mechanism | `git subtree add`, **full history** — 1 commits |
| contents | 2 files · 0 MB |

"Goldset For Testing Historical Results against Live ETC network." A single commit, two files — small enough that its value is entirely in not losing it.


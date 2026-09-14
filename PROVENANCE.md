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



---

# Ethereum Classic tooling and personal-account work — vendored 2026-08-26

**Twenty-nine repositories, whole, with history**, plus one extraction. Selected against this
archive's own test: what disappears if the upstream vanishes tomorrow.

Three groups, and the reason differs by group:

- **`etclabscore/`** — that organization is scheduled for deprecation, so its Ethereum
  Classic-specific repositories are the clearest instance of the test.
- **`iquidus/`** — the author of ECIP-1099. The Etchash implementation work lives in that
  account's **forks**, not in the upstreams they were forked from, so vendoring the upstream
  would preserve the wrong thing.
- **`meowsbits/`** — the author of ECIP-1100. **Eight of the vendored trees across these groups
  ship no license file at all**, and several carry zero forks upstream; GitHub preserves a
  deleted repository's forks, so a zero-fork personal repository has nothing to survive it.

Both authors have left the Ethereum Classic ecosystem.

**Deliberately excluded**, because they fail the test rather than because they lack value:
`iquidus/explorer` (737 stars, BSD-3-Clause, widely forked, not Ethereum Classic-specific),
`iquidus/blockspider` (a general blockchain crawler), and the live `diega/*` repositories.
`meowsbits/geth-prometheus` was checked and is an **empty repository** with zero refs.

Every entry is verified by TREE HASH against its source clone, with a control confirming the
comparison can report a mismatch. `meowsbits/EXTRACTION.md` covers the gists and documents.

## `etclabscore/ethereum-json-rpc-specification/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/ethereum-json-rpc-specification` |
| ref | `master` @ `97178e7dc3b417318e2977171254f6e21d080076` |
| upstream date | 2020-11-11 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 286 commits |
| contents | 19 files · 0.3 MB |
| license | see NOTICE |
| tree | `5a66f456fe335bcce9ccb8bc3318e7019a1879e0` |

The EVM JSON-RPC specification, as OpenRPC.

## `etclabscore/eth-x-chainspec/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/eth-x-chainspec` |
| ref | `master` @ `47e34b489a9b99ee2b40cae35ab44b36efddb48e` |
| upstream date | 2019-06-11 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 38 commits |
| contents | 69 files · 6.5 MB |
| license | none published |
| tree | `6481b40ca15673db362018c032256bbdacc00bd1` |

The cross-client chain configuration specification.

## `etclabscore/go-etchash/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/go-etchash` |
| ref | `master` @ `7746dfe207b3fb9a741ba996a3efeb481139826b` |
| upstream date | 2022-08-31 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 12 commits |
| contents | 10 files · 0.1 MB |
| license | see NOTICE |
| tree | `1901b4d7accdf0b8ddbcea8bb040a1cccd8e20a2` |

The Etchash module, ECIP-1099's hashing change in Go.

## `etclabscore/ancient-store-s3/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/ancient-store-s3` |
| ref | `master` @ `e4ebc049a0220c3b6948183a4296c873f1962318` |
| upstream date | 2020-09-08 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 17 commits |
| contents | 10 files · 0.1 MB |
| license | see NOTICE |
| tree | `4fb3fd7c7c44e65b37c300cbf53471a90d3c500e` |

An S3-backed ancient store for the production client.

## `etclabscore/core-pool/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/core-pool` |
| ref | `master` @ `2734a0a4eafb06736f4dacd93d43d174ea56f020` |
| upstream date | 2021-05-17 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 297 commits |
| contents | 38 files · 0.3 MB |
| license | see NOTICE |
| tree | `4042c4c13d59d4778e1e4a0619a34bb80f94956a` |

The Ethereum Classic mining pool.

## `etclabscore/core-pool-interface/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/core-pool-interface` |
| ref | `master` @ `f3b664eb9f35655244f9042e639ecab32778d125` |
| upstream date | 2021-09-17 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 188 commits |
| contents | 55 files · 1.1 MB |
| license | none published |
| tree | `0aa291b99ce7a1abb092f79c84288f4f2f243a0d` |

The mining pool's web interface.

## `etclabscore/classic-geth-supervisor.sh/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/classic-geth-supervisor.sh` |
| ref | `master` @ `2b859c34f595a76ce8c6047168127065f2634700` |
| upstream date | 2019-01-16 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 54 commits |
| contents | 11 files · 31 KB |
| license | none published |
| tree | `d5a70a468cafe3caa44373f069564d7536383a9e` |

Early Ethereum Classic node metrics and supervision.

## `etclabscore/expedition/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/expedition` |
| ref | `master` @ `08f79fd012e261409049043136d7030ffdb6076e` |
| upstream date | 2021-02-26 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 336 commits |
| contents | 9 files · 16 KB |
| license | see NOTICE |
| tree | `f6d3033a5603a2da78aca0c60c7c6676664fcb80` |

The block explorer. Archived upstream in 2021.

## `etclabscore/signatory/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/signatory` |
| ref | `master` @ `ea93c2b2ce0fe856a040d2f8d1eb09eed4343d87` |
| upstream date | 2020-04-20 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 46 commits |
| contents | 47 files · 0.6 MB |
| license | see NOTICE |
| tree | `23a98f8c199451c1071d538812e2e72e9f973cff` |

The transaction signing service.

## `etclabscore/signatory-core/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/signatory-core` |
| ref | `master` @ `ef1d405955ebd11079958d6299ad54b31de5439d` |
| upstream date | 2020-05-15 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 10 commits |
| contents | 40 files · 0.6 MB |
| license | see NOTICE |
| tree | `9e9b0b62f18dbcc8cbbe88efccbc908c74315bd8` |

The signing service's core library.

## `etclabscore/jade-signer-rpc/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/jade-signer-rpc` |
| ref | `master` @ `e6bc97bebf7f06757229e3618f5e197a18a66d5d` |
| upstream date | 2019-10-08 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 223 commits |
| contents | 71 files · 0.5 MB |
| license | see NOTICE |
| tree | `8ceca6e5b184a91c6d3fb0aa14d90ae55801b200` |

The Jade signer's JSON-RPC surface.

## `etclabscore/jade-rs/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/jade-rs` |
| ref | `master` @ `baf50917a9f8d37fdb59d5f56e632479ff597947` |
| upstream date | 2019-03-26 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 964 commits |
| contents | 66 files · 0.3 MB |
| license | see NOTICE |
| tree | `c66b6f3f9bce72149c379182e822f95a2e323bbf` |

The Jade signer in Rust.

## `etclabscore/sig.tools/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/sig.tools` |
| ref | `master` @ `4f916314c7c5b05590a02c5e8a344b6fa5cd9560` |
| upstream date | 2020-11-23 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 169 commits |
| contents | 71 files · 1.1 MB |
| license | see NOTICE |
| tree | `a1fc578be1a57dd262859e8d7fe082506f11092e` |

The browser-based signing tools.

## `etclabscore/eserialize/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/eserialize` |
| ref | `master` @ `700f39941bcc1bcac6ad7a61808ed26a8f602b13` |
| upstream date | 2020-05-13 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 30 commits |
| contents | 37 files · 0.2 MB |
| license | see NOTICE |
| tree | `83b9499efe09eeb517eea7236553cf8ad01d44d6` |

Ethereum value serialization helpers.

## `etclabscore/jade-desktop/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/jade-desktop` |
| ref | `master` @ `79f857380e2bf2c22f00af3a8aa6bfb7b0c66116` |
| upstream date | 2020-11-25 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 85 commits |
| contents | 33 files · 1.0 MB |
| license | see NOTICE |
| tree | `9a58ef40bdf6edfe008d71139f1e93adc2709a48` |

The Jade signer's desktop client.

## `etclabscore/rpcflow-meta-schema/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/rpcflow-meta-schema` |
| ref | `master` @ `d6fb7351559ae86786b9da37d93b5f22514ce2c4` |
| upstream date | 2020-12-22 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 16 commits |
| contents | 30 files · 0.4 MB |
| license | see NOTICE |
| tree | `e7d93e491f46b1bcf931f08025c7ede9c4227033` |

The RPC flow meta-schema.

## `iquidus/ecip-1099-data/`

| field | value |
|---|---|
| upstream | `https://github.com/iquidus/ecip-1099-data` |
| ref | `master` @ `2dfa18d8bf1378f8d71cfeec7036cfc168ae54f9` |
| upstream date | 2020-09-14 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 4 commits |
| contents | 4 files · 24 KB |
| license | none published |
| tree | `92e71bfd14ad54f4b80ed1e3b4af3bc4e6dd04ba` |

The epoch-transition research behind ECIP-1099, by that proposal's author.

**Its `ETCHASH_FORK_BLOCK=11460000` is NOT an error, and must not be recorded as one.**
`MAINNET.md` was written 2020-09-14. core-geth defined the mainnet activation as
`11_700_000` on 2020-09-25, eleven days later, and `11460000` never appears in
core-geth's params at any point in its history. Both values are epoch-aligned under
both the old 30,000 and new 60,000 epoch lengths (11,460,000 = epoch 382 / 191;
11,700,000 = epoch 390 / 195); the difference is exactly 8 old epochs, roughly 38
days of additional lead time. This is a **superseded pre-decisional working value**,
recorded before the activation block was chosen, and it is preserved as published.
Read activation blocks from the production client, never from this file.

## `iquidus/libdag/`

| field | value |
|---|---|
| upstream | `https://github.com/iquidus/libdag` |
| ref | `master` @ `a802384a5a2605254990aac6d4eda39a40089bff` |
| upstream date | 2021-06-27 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 1 commits |
| contents | 24 files · 0.1 MB |
| license | see NOTICE |
| tree | `bec96638e87cc985d2977a0b2388f2a8deec7e8a` |

The DAG library carrying the Etchash modification.

## `iquidus/dagd/`

| field | value |
|---|---|
| upstream | `https://github.com/iquidus/dagd` |
| ref | `master` @ `0efca3e210a60b859ddbbd1c954c1fd187c10635` |
| upstream date | 2021-06-27 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 1 commits |
| contents | 19 files · 41 KB |
| license | none published |
| tree | `9b313667c6b44a73ce21461e32a1812e18e3ebde` |

The DAG daemon built on libdag.

## `iquidus/ethash/`

| field | value |
|---|---|
| upstream | `https://github.com/iquidus/ethash` |
| ref | `master` @ `aa25253c9c5d7207b4ca5e0443d50460362dd4e8` |
| upstream date | 2020-11-26 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 466 commits |
| contents | 111 files · 0.3 MB |
| license | see NOTICE |
| tree | `9ae002f7a0bc27555758dfeffbc9280d224e73bd` |

A fork carrying the Etchash modification. Same reasoning as `iquidus/ethminer`.

## `iquidus/ethminer/`

| field | value |
|---|---|
| upstream | `https://github.com/iquidus/ethminer` |
| ref | `master` @ `c934fdfaf5a768d33a98e4b47362247e217c6644` |
| upstream date | 2020-09-13 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 14,309 commits |
| contents | 141 files · 1.4 MB |
| license | see NOTICE |
| tree | `91e55c5c1bf8e4d06ec1df1ea20578f23a02e1e7` |

A fork, not the upstream miner. The Etchash modification implementing ECIP-1099 lives in the fork; the upstream does not carry it.

## `iquidus/open-ethereum-pool/`

| field | value |
|---|---|
| upstream | `https://github.com/iquidus/open-ethereum-pool` |
| ref | `master` @ `686b703f32c288199e206488ccc798677dfdf769` |
| upstream date | 2020-01-06 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 216 commits |
| contents | 136 files · 0.4 MB |
| license | see NOTICE |
| tree | `a69c09f4f3ca47099752ce851a1d7028155c2bca` |

A fork carrying the Etchash modification, so a pool could pay out across the ECIP-1099 transition.

## `ethereumstack/ethereumstack.tools/`

| field | value |
|---|---|
| upstream | `https://github.com/ethereumstack/ethereumstack.tools` |
| ref | `master` @ `982b175b3d3ec6b4977c36e308ab9cabd3331728` |
| upstream date | 2020-12-31 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 34 commits |
| contents | 40 files · 2.2 MB |
| license | see NOTICE |
| tree | `373f5182f31d6586c9ec2f20b011fcdac11de4b5` |

Ethereum Classic tooling from a dormant single-repo organization.

## `meowsbits/51-percent-docs/`

| field | value |
|---|---|
| upstream | `https://github.com/meowsbits/51-percent-docs` |
| ref | `master` @ `0d157d281c13a5de762aefa11ac099c8ef3f2abb` |
| upstream date | 2026-08-26 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 1,617 commits |
| contents | 27 files · 1.5 MB |
| license | see NOTICE |
| tree | `df843bc775ebf8e6546ca31a2c274351b7592a62` |

Source for a website documenting the economics of 51% attacks, by ECIP-1100's author.

**Live-looking but static.** 1,491 of its 1,617 commits are an automated exchange-rate
feed committed by a bot; human authorship ended 2023-12-27. The upstream is not
archived and the bot still runs, so a `pushed_at` check reports it as active. The
substance is the documentation, not the rate series.

## `meowsbits/mini-etc-network/`

| field | value |
|---|---|
| upstream | `https://github.com/meowsbits/mini-etc-network` |
| ref | `main` @ `d77d4ada0811bad5d25c93fb7be62e536dc000ac` |
| upstream date | 2022-07-25 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 1 commits |
| contents | 6 files · 14 KB |
| license | see NOTICE |
| tree | `09c344c7a6bab41b060ab7d4c6724f0725a0b175` |

An isolated core-geth peering testbed.

## `meowsbits/x-client-tests-project/`

| field | value |
|---|---|
| upstream | `https://github.com/meowsbits/x-client-tests-project` |
| ref | `master` @ `91d6a7ad261cc3138de750ca6909fb5aead013a2` |
| upstream date | 2022-11-02 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 2 commits |
| contents | 1 files · 20 KB |
| license | none published |
| tree | `20acd03b13193a62f7be92efb2b4b214c39a74a9` |

Carries an Ethereum Classic fork list. **Zero stars and zero forks upstream.** GitHub keeps a deleted repository's forks alive; with no forks there is nothing to keep.

## `meowsbits/go-miner-sim/`

| field | value |
|---|---|
| upstream | `https://github.com/meowsbits/go-miner-sim` |
| ref | `master` @ `aae93a6cfd2a0fcbb36ab9e20409029c76f95c51` |
| upstream date | 2022-05-23 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 2 commits |
| contents | 287 files · 47.2 MB |
| license | none published |
| tree | `9e1433eaabf20357d36bd684ce750542ad5de46e` |

Chain-growth simulation from the period ECIP-1100 was written. Zero forks upstream.

## `meowsbits/canhaz.net/`

| field | value |
|---|---|
| upstream | `https://github.com/meowsbits/canhaz.net` |
| ref | `gh-pages` @ `e44bc904e5fa4c667971d5a8fa892a3fb7f2cf87` |
| upstream date | 2019-12-12 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 5 commits |
| contents | 3 files · 0 KB |
| license | none published |
| tree | `f218b2449439d86425566b7b429c800400a0aa27` |

An index of test network faucets. Zero stars and zero forks upstream.

## `meowsbits/eserialize-cli/`

| field | value |
|---|---|
| upstream | `https://github.com/meowsbits/eserialize-cli` |
| ref | `master` @ `d2f7a2f7fcae46057fbdab3691029bec043c3c8b` |
| upstream date | 2021-08-12 |
| vendored | 2026-08-26 |
| mechanism | `git subtree add`, **full history** — 21 commits |
| contents | 11 files · 43 KB |
| license | see NOTICE |
| tree | `159855a1efeef5a01e3eeff8f2b29c70e5263a60` |

The command-line interface to Ethereum serialization.



---

# Two further implementations of the shared chain — vendored 2026-08-27

**Two repositories, whole, with history**, added on different grounds — which is why both entries
below need reading rather than one standing in for the other. `ethereum/ethereumj` is a historic
Ethereum Classic client and enters on this archive's usual test: what disappears if the upstream
vanishes tomorrow. `ethereum/aleth` has **zero** Ethereum Classic support and does not meet that
test at all. It is held for the ERA, on exactly the ground `ethereum/go-ethereum-dao` above states.

**Neither is a pin in `../upstream/`, and the reason is the same for both: both upstreams are
archived on GitHub.** That tree holds pins on LIVE upstreams, where tracking beats copying because
a copy would only drift. There is nothing here left to track and no drift left to avoid, and a pin
on a dead repository still leaves a `.gitmodules` URL that dies if the repository ever does.

Both are verified by TREE HASH against their source clones, with a control confirming the
comparison can report a mismatch, and both were swept for oversized blobs across their whole
histories before either landed — the sweep calibrated at 1 MiB first, so that an empty result at
100 MiB meant "none" rather than "the check is blind."

## `ethereum/aleth/`

| field | value |
|---|---|
| upstream | `https://github.com/ethereum/aleth` |
| ref | `master` @ `5d1078ac43e0e2eaffb6e58300686d20a0bfb512` |
| upstream date | 2021-10-28 |
| vendored | 2026-08-27 |
| mechanism | `git subtree add`, **full history** — 34,262 commits |
| contents | 578 files · 4.2 MB |
| license | see NOTICE |
| tree | `dd35ece7c5cb875011224f49ede6e29e5c6e360c` |

The C++ client — one of the original implementations of the shared chain, and the C++ record of it
from Frontier through the DAO fork. Its history runs 2013-12-23 to 2021-10-28, and its final commit
is a deprecation merge. **The upstream is archived but in no danger; this is held for the ERA, not
for preservation** — the same ground `ethereum/go-ethereum-dao` is held on.

**Unlike the two `-dao` entries above, this is not a fork-era snapshot.** `go-ethereum-dao` and
`parity-ethereum-dao` are frozen AT the fork; this is the whole client at its final state, so it
carries the DAO fork implementation and seven more years besides. 19 files at this ref carry DAO
fork handling, `libethashseal/genesis/mainNetwork.cpp` and `libethcore/ChainOperationParams.h`
among them.

**It has ZERO Ethereum Classic support, and is not a historic Ethereum Classic client.** Measured
at this ref: **0** files match `ethereum.?classic` or `ETCFork`, against a control search for
`ethash` that matches 80. It implemented the DAO fork and never carried the chain that declined it.
Do not file it in the client lineage above, and do not read its presence in this organization
directory as a claim that it carried this chain.

**It shares a root commit with go-ethereum, and that is NOT shared lineage.** aleth has 27 root
commits; `68ccbefc9` is one of them, and it is already reachable in this archive through
`ethereum/go-ethereum-dao`. So the standard independence check — the one that establishes
`besu-eth/besu-etc` as a third oracle and collapses `multi-geth` into core-geth's lineage — reports
a shared root here and reads as evidence that the C++ client is a geth fork. It is not. Open the
commit:

```sh
git ls-tree -r --name-only 68ccbefc9
```

**Three files** — `.gitignore`, `ethereum.js`, `index.html` — authored `obscuren`, 2014-09-30,
message `init`. It is the early JavaScript library's history, merged into both repositories, and
carries no client code in any language. A shared root is evidence of a shared *repository ancestor*
and nothing more; check what the root contains before drawing a lineage from it.

Four mode-160000 gitlinks live inside this tree — `cmake/cable`, `evmc`, `scripts/dopple`,
`test/jsontests` — and aleth carries its own `.gitmodules` for them, which git reads at no depth but
the repository root.

## `ethereum/ethereumj/`

| field | value |
|---|---|
| upstream | `https://github.com/ethereum/ethereumj` |
| ref | `develop` @ `200882753ee7c1a516d72b22cc5073055aa0c978` |
| upstream date | 2020-05-20 |
| vendored | 2026-08-27 |
| mechanism | `git subtree add`, **full history** — 5,214 commits |
| contents | 770 files · 67.6 MB |
| license | see NOTICE |
| tree | `7eb2bda9e67397fe320c1a74512560a9d77f5d04` |

The Java client, and **a historic Ethereum Classic client** — the case this archive vendors whole.
`ethereumj-core/src/main/java/org/ethereum/config/blockchain/ETCFork3M.java` implements this chain's
2.5M and 3M forks, and its test asserts chain id 61. That support arrived 2017-01-16 in a commit
titled "Add ETC 2.5M and 3M forks" and **is still present at this ref.**

**Frozen at `develop`, and the freeze point was confirmed by content rather than assumed from the
default branch.** `EXTRACTION-historic-clients.md` is emphatic that the two are not the same
question — OpenEthereum removed this chain two years before its final commit, so its default branch
is not its supporting state. Here they coincide, and this is the check that says so:

```sh
git log --diff-filter=D -- '*ETCFork3M.java'
```

Empty output is the pass, and it was empty. Calibrate it against `*.java`, which returns real
deletions; a filter that can report nothing proves nothing. This is the *"repository ended while
still carrying this chain"* case that file names for `multi-geth`.

It is also **the only JVM record of this chain's early forks written while they were happening.**
`besu-eth/besu-etc` is the other JVM client here and is a far later reimplementation; ethereumj
carried Ethereum Classic contemporaneously, in the era `ETCFork3M` is named after.

**The copyright holder is not the Ethereum Foundation**, despite the `ethereum/` organization. All
682 header instances in this tree read `Copyright (c) [2016] [ <ether.camp> ]` or the same with a
later year, and the license is the LESSER GPL rather than the GPL. See NOTICE.

# The preceding repository's client — vendored 2026-09-07

**One repository, whole, with history, frozen at a repository boundary rather than at an upstream's
death.** This upstream is alive and still committing. What ended at this ref is not the repository —
it is that repository's run as this chain's canonical client line.

`ethereumclassic/core-geth` was created on 2024-12-21 from `etclabscore/core-geth` at commit
`7ef3ecd7a` (2024-12-16), and has carried Ethereum Classic's Core-Geth since; that commit is
preserved upstream on the `archive-etclabscore-2024-12` branch and tagged
`archive/etclabscore-2024-12`. **Both repositories have committed independently from that commit
ever since**, so the preceding upstream will never again show this state except as one commit deep
inside a history that diverged from the line this archive tracks. That is what this copy holds, and
it is why the entry exists despite the upstream being in no danger.

**The boundary is enforced at the object level, not by naming a ref.** A vendoring can claim a
freeze point and still drag later history in through a branch fetch, and nothing about the working
tree would show it. This one does not — the commit of every release tag published on that upstream
after the boundary is unresolvable in this repository:

```sh
git cat-file -t 96b2afc25   # want: fatal: Not a valid object name
git cat-file -t 7ef3ecd7a   # want: commit  <- the control
```

**The negative result means something only because the positive control resolves.** Checked at
vendoring for seven post-boundary commits, including the commit behind every later release tag; all
seven were absent and the boundary commit was present.

## `etclabscore/core-geth/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/core-geth` |
| ref | `master` @ `7ef3ecd7a716354589c2f27ff8f4b74d7a5edf2e` |
| upstream date | 2024-12-16 |
| vendored | 2026-09-07 |
| mechanism | `git subtree add`, **full history** — 19,476 commits |
| contents | 2,194 files · 76 MB |
| license | see NOTICE |
| tree | `29bf8ae0e7b759e68f6af107647f6ffcfcb27015` |

The client that carried this chain after multi-geth, and the fourth link in the lineage above. Its
Ethereum Classic support was measured rather than assumed: 30 files match `ethereum.?classic`,
`ETCFork` or `ClassicChainConfig` at this ref, against an `ethash` control matching 302.

**This ref is NOT a release, and the tree says so.** `params/version.go` reads `1.12.21-unstable` —
six months of development past `v1.12.20` (2024-06-10), which is the last release this history
contains. The upstream tags `v1.12.21`, `v1.12.22` and `v1.12.23` all postdate the boundary and none
of them is reachable here. Do not read the vendored tree as any published version, and do not cite a
version number off it.

**Shares root commit `5db3335dc` with `multi-geth/multi-geth`, and here that IS shared lineage** —
the multi-geth entry above already records the two as one client line under two names, so the
standard independence check reports a shared root and is right to. It also shares `68ccbefc9` with
`ethereum/go-ethereum`, which is NOT lineage: that root holds the early JavaScript library's three
files, exactly as the `ethereum/aleth` entry records.

Three mode-160000 gitlinks live inside this tree — `tests/testdata`, `tests/testdata-etc` and
`tests/evm-benchmarks` — mapped in the root `.gitmodules`, because one unmapped gitlink fails
`git submodule status` for the whole repository rather than for that path alone. `tests/testdata-etc`
pins `06ec708ea7`, **the same ref this archive vendors whole at `etclabscore/tests`**, so the client
and the suite it was tested against are both held here at the ref that pairs them.

### Why the boundary is here: who funded the work, and until when

**This commit is a stewardship boundary, and the funding organization's own published record is
what dates it.** Recorded because the archive's usual test — what disappears if the upstream
vanishes — does not by itself explain why *this* commit is the freeze point.

**The ETC Cooperative funded Core-Geth development from January 2022.** Announced 2021-12-22:
*"Starting in January 2022, development work on the Core-Geth client will be funded by the ETC
Cooperative."* Isaac Ardis and Christos Ziogas signed independent contractor agreements and
continued under the ETC Core banner; Diego López León joined that team. The Cooperative funded the
work; the developers were contractors, so read "funded" rather than "employed."
<https://etccooperative.org/posts/2021-12-22-coop-now-funding-core-geth>

**That same post corroborates the client lineage this archive is ordered by, from the maintaining
team's side rather than from the repositories:** *"The ETC Core team was initially formed as ETC
Labs Core in December 2018 with many of its developers having previously been part of the ETCDEV
team which supported the Classic Geth client. As Classic Geth was retired they supported the
Multi-Geth client prior to the birth of Core-Geth in 2020."* Classic Geth, then multi-geth, then
Core-Geth — stated by the people who carried it, and matching the order of the lineage above.

**The funded era ended as the organization moved to maintenance mode, across three published
documents around this commit.**

- **2024-12-05**, eleven days before the boundary commit — the executive director's departure
  announcement, describing the client work in progress: *"After the Prophasis (v1.12.20) release,
  there has been several months of work underway to do the first merge after this removal … that
  newer version is still pending release. The core developers will be assessing possible
  alternative strategies for client software moving forward, with fresh eyes on Besu, Erigon and
  Nethermind."* <https://etccooperative.org/posts/2024-12-05-q2-q3-reports>

  **This independently confirms what the vendored tree measures.** Its last release is `v1.12.20`
  and `params/version.go` reads `1.12.21-unstable` — the "pending release" the post describes,
  still pending at the boundary eleven days later.

- **2024 Retrospective, printed page 25 of 29:** *"Without any way to obtain funding, the ETC Coop
  will be in maintenance mode, with spending minimized, until the funding runs out. At that time,
  it will be up to other stakeholders to take on any required maintenance of the ETC client, unless
  a new plan materializes."*
  <https://etccooperative.org/etc-cooperative-retrospective-2024.pdf>

- **Q1 2025 report, printed page 13 of 17:** *"Due to significant changes in the organization, we
  are no longer comparing actual expenditures to a budget or previous years. This is because we are
  now in maintenance mode and spending has decreased significantly."*
  <https://etccooperative.org/etc-cooperative-q1-2025-en.pdf>

So the vendored range covers the funded era end to end — January 2022 to this commit, plus the
history the client carried into it — and `ethereumclassic/core-geth`, created five days later, is
where the proposal above was carried out and where "other stakeholders … take on any required
maintenance" actually happened.

**The move is proposed in the retrospective itself — and it is IMAGE content, invisible to every
text tool.** PDF page 24 (which prints "Page 18 of 29") carries a photograph of Donald McIntyre,
the Cooperative's Senior Editor, giving a talk titled "Ethereum Classic Roadmap" at the BITMAIN
World Digital Mining Summit in Muscat, Oman, 28-29 March 2024. The slide on screen behind him is
headed **"ETC Pathway Proposed by Donald McIntyre"**, and its second bullet reads:

> Move Core Geth to the Ethereum Classic community repository

**That is this boundary, proposed nine months before the commit and published by the funding
organization in its own retrospective.** The other four bullets are "Cancel MESS", backward
compatibility for the account and EVM versioning system, a supply-audit tool, and an 8 million gas
block size.

**Do not try to verify that quotation with `pdftotext`, and do not trust a text sweep that says it
is absent.** A full-text sweep of all 29 pages returns **0** matches for `ethereumclassic` and 0 for
any handoff phrasing, against controls that fire normally — `client` 9, `Core-Geth` 6, `Diego` 1.
The load-bearing sentence is pixels in a conference photo, so every text instrument reports it
missing, confidently, with a working control attached. This archive's own rule is that an absence
claim needs a corpus rather than one instrument; here one instrument covered every page and still
could not see the sentence. Render the page instead:

```sh
pdfimages -f 24 -l 24 -png etc-cooperative-retrospective-2024.pdf p24   # then open p24-000.png
```

The Cooperative's *prose* still never names `ethereumclassic/core-geth`, and no post of theirs
between 2024-10 and 2025-12 announces the transition as completed. So these sources establish the
funding era and the stated intent; the repository boundary as executed is documented by
`ethereumclassic/core-geth`'s own README and its signed `archive/etclabscore-2024-12` tag.

**Verifying the two PDF quotations: cite the printed footer, not the PDF page index.** They differ.
In the retrospective, printed page 25 is PDF page 25, but printed page 24 is PDF page **23** — PDF
page 24 prints "Page 18 of 29", one page sitting out of order. `file` also reports both documents
as 8 pages; `pdfinfo` reports 29 and 17, and is right.

**Frozen at `7ef3ecd7a` — prove it by tree hash, never by diff:**

```sh
git rev-parse '7ef3ecd7a^{tree}'
git rev-parse 'HEAD:etclabscore/core-geth'
```

Both read `29bf8ae0e7b759e68f6af107647f6ffcfcb27015` at vendoring, checked against a control —
`v1.12.20^{tree}`, which is `ed3abaab12` — confirming the comparison can report a mismatch.

Swept for blobs over 100 MiB across the whole grafted history before landing: **0 hits**, the sweep
calibrated at 1 MiB first, which returns 135. The largest blob in the history is
`tests/files/VMTests/vmInputLimits.json` at 60.3 MiB.

---

# Go modules the production client builds against, vendored 2026-09-13

**Two repositories, whole, with history, held on the ground `etclabscore/tests` is held on: each is a
live build dependency of the production Ethereum Classic client.** `ethereumclassic/core-geth`
requires `github.com/etclabscore/go-openrpc-reflect` `v0.0.37` directly and
`github.com/etclabscore/go-jsonschema-walk` `v0.0.6` indirectly. Its `v1.13.0-rc2` tag and the
`etclabscore/core-geth` tree vendored above both carry exactly the `go.sum` lines recorded below, and
neither names any other `github.com/etclabscore/` module. Both modules are published from the
organization the 2026-08-26 pass above records as scheduled for deprecation.

**The set is closed, and that was checked rather than assumed.** At `v0.0.37`, `go-openrpc-reflect`
requires one module from that organization, `go-jsonschema-walk` `v0.0.6`; at `v0.0.6`,
`go-jsonschema-walk` requires none.

**Mechanism:** `git subtree add` without `--squash`, from a local clone at the upstream's default
branch, as for every entry above. **Every branch and every tag upstream is reachable from that ref.**
That was read from each upstream's own `ls-remote`, not from a clone's copy of it, so one ref per
repository carries all of them, and every tagged commit resolves here and is reachable from `main`.
Pull-request refs are not branches and are not held; at vendoring, four pull-request heads on
`go-openrpc-reflect` pointed at commits outside its history.

**The tagged commits are here; the tag objects are not.** This repository carries no tag refs, and a
subtree add brings in commits, not the annotated tag objects that name them. For these two that is a
real loss, because many of the tags are PGP-signed, both pinned versions among them. Each entry's tag
map therefore records every tag's object ID beside its commit, so a tag recovered from any other copy
can be checked against the one upstream published.

**In both entries the vendored tree is NOT the pinned version.** Each upstream committed past the tag
the client pins, so `HEAD:etclabscore/<repo>` is the default branch, and the pinned version is an
older commit in the grafted history. Each entry names that commit and what lies between.

### Verifying a pinned version from this repository alone

The tree hash proves a vendored default branch is upstream's. It says nothing about a pinned version;
**the module hash does**, computed from this repository's object store and never from GitHub. Run from
the repository root:

```sh
C=ba5a99fa846de681b412765a38a3fb11b0016208 M=github.com/etclabscore/go-openrpc-reflect V=v0.0.37
W=$(mktemp -d)
git init -q --bare "$W/src.git"
git -C "$W/src.git" fetch -q "$PWD" "$C"
git -C "$W/src.git" update-ref "refs/tags/$V" "$C"
git config -f "$W/gitconfig" url."file://$W/src.git".insteadOf "https://$M"
git config -f "$W/gitconfig" protocol.file.allow always
(cd "$W" && GIT_CONFIG_GLOBAL="$W/gitconfig" GIT_CONFIG_NOSYSTEM=1 \
  GOPROXY=direct GOSUMDB=off GOFLAGS=-modcacherw GOMODCACHE="$W/modcache" \
  go mod download -json "$M@$V")
```

`Sum` and `GoModSum` must equal the entry's table, and `Origin.Hash` names the commit the zip was
built from. `GOPROXY=direct` makes the Go toolchain fetch from the source repository itself, and the
redirect makes that source this repository. **Then move the tag to the previous
version's commit and run it again. The hashes must change**; if they do not, the check is reading from
somewhere other than this repository.

Verified 2026-09-13 with go1.26.6: both pinned versions reproduce both of their hashes, and both
controls change them. An independent SHA-256 dirhash, computed straight from the git blobs with no Go
toolchain involved, agrees on every value, the controls included.

## `etclabscore/go-openrpc-reflect/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/go-openrpc-reflect` |
| ref | `master` @ `5153c9e1211fd210176b7f7df3baac7e302a576f` |
| upstream date | 2023-12-07 |
| vendored | 2026-09-13 |
| mechanism | `git subtree add`, **full history**, 110 commits |
| contents | 23 files · 0.3 MB |
| license | see NOTICE |
| tree | `960b6b5f5ccc3179e37875388f96980865425b3b` |
| module | `github.com/etclabscore/go-openrpc-reflect` |
| consumed by | `ethereumclassic/core-geth`, as a direct requirement |
| pinned version | `v0.0.37` @ `ba5a99fa846de681b412765a38a3fb11b0016208` (2022-08-29) |
| pinned tree | `3bb1459adc04ef27a848ce94c4b33df4abc954b1` |
| `h1:` module zip | `h1:IH0e7JqIvR9OhbbFWi/BHIkXrqbR3Zyia3RJ733eT6c=` |
| `h1:` go.mod | `h1:0404Ky3igAasAOpyj1eESjstTyneBAIk5PgJFbK4s5E=` |
| tags | 36, all annotated, 22 of them PGP-signed |

Generates OpenRPC service descriptions from Go code by reflection. `ethereumclassic/core-geth`
imports it in `node/` for RPC discovery.

**`master` is one commit past the pinned version**, and that commit touches `go.mod` and `go.sum`
only: the `go` directive rises from 1.13 to 1.21, and the indirect requirements are listed in full in a
block of their own, with no direct requirement changing version. **Read `ba5a99fa8` for what the
client builds, not the vendored tree.**

Upstream carries no `v0.0.28`; its tags skip from `v0.0.27` to `v0.0.29`. Its one branch besides
`master`, `fix-m1-nil-pointer`, is merged, and `v0.0.37` is the first tag that contains it. That tag's
message reads *"fix for Apple Silicon M1 bug"*.

Tag map, read from the upstream at vendoring (`*` marks a PGP-signed tag object):

```
tag        tag object                                commit
v0.0.1     155b97f9d160e57197782c9817b2c293252cac49  d4e921e4fc0dba934a1ff57c03a7e339f7d29cff
v0.0.2     203722a50f71f99db8be4843d3f1642b4d76a87a  0442a0df4b46cfc81643b26325ee804e2a19ad88
v0.0.3     8b8c8498615695f06fbf27a358006d026376f12d  98aa65a6590e29ddc38739f946581a3e1ddd7102
v0.0.4     b7256e621b35d91decdc713512591745116dcb92  f79951fa4ede547092bc04ca60dc9f666eee0b2a
v0.0.5     2b6060ab54366290625b3c53bee3ead40ca79dfd  781d005f63c2fe1e4175588d03fb4145a40863ae
v0.0.6     20ac447144794ec61833f69a028086a3a17a0bc3  565f7f5ae08ddc38e2fc6ff057f293da509ec671
v0.0.7     e37eb9b2540b6ba2411e6c6a9e792403f77411f8  d312831cd6b977439a720d9c99a3ae97ccceaa0e
v0.0.8     bb91e7b9f370a6c1a69e350ae651b3d5a60b0dfd  4dd8a28ee6922dfb525375e330d0be881fa67e3f
v0.0.9     bcd097fee13473e05428272996eca5ef32c83fab  9923f411ee2317f4eed1ef7f64d5830e22d104a6
v0.0.10    f3cf77f93176c968f3cf577322092c4e6f4a2f0b  fe05665df368f33c52e3f8a97a4744db65348c64
v0.0.11    75465d163e5eaf1467bc10de5740011e6c299453  d756b3addce39516a4f9ed4296d5f15eccb42db4
v0.0.12    21c388862522bd9bd96011325d9fd479d1ff18d3  54fe81af14257c56d63143ef773d95921989dbd9
v0.0.13  * 9df56f95ef4da4ae642991b3aa37239acfa6815e  51bbfbfc276c53ac108d9a49e637ba2c1151e83a
v0.0.14  * f6bbda11871a80c6f0b011f73f19be2da4f0bcb0  ba55a7f19357b692b6b9c0634f9da6e27a85cd78
v0.0.15  * a56a590a254f66726ed06485e434cc3b617fcefb  e2005eefd0564c8c5433547cb785feecc9ec2e95
v0.0.16  * a64d25e0dfb3796ea11c26b38c0b0a0dc9e46a56  ae07309e07771ed2b8bca1d5b06ab0d9615ece45
v0.0.17  * c0c987162dd343a62f1d1a8e0bda5ab374bf63b8  f178289152afdd1207abffa4a768dcd68b25c546
v0.0.18  * cdbff3e85f3c907717e7da55593eccb07c1e2b93  ae79e37c91027ec73870cae1c18567b9a5b4e5ca
v0.0.19  * 8ed694e8e240f9f8894cf6c844fe9f263e4b56ec  92e27e930851ee14ab14dd16264188d880654e4a
v0.0.20  * c5eb15a5af5ff031d0dbb693124b534ea9befaf1  595c1860eea1dba537f14269731ddac9372abd0e
v0.0.21  * 27eb3d3fae6198ea583643a74393829f5469d08b  018e9422fcc4a398773baaa51db9edc51b4f3548
v0.0.22  * 461b3845ad7e6e37bbfea36821859d89ed063e09  585618201f264a06b03dbf8e8d57985f32854df7
v0.0.23  * dced68b1f697e5df60162a133402f18536ecd854  ed44570bab704cfb4f67a8792d10b3467540ed59
v0.0.24  * 9542cc699c97a017d76d1f54ac3ad3e388a9852a  22ddd49d4946c99c45ff93f52f5d9ed7d5d97ff3
v0.0.25  * fbe55499c8cd56c3a8ea1736e8d308d06fb106d3  b5a4c5da94aa8f1519704278902b4e963ce1b090
v0.0.26  * 290a9326e15ff54419517ed818d0b0d079f37ec0  de01133fcfafc9d7e52cac824bdd5b610c228a81
v0.0.27  * fa623e5e300ad5b3a64ae4f0d3a13eb44cba7efe  ab2d0c6280362a44237beb701e6d0683e5894154
v0.0.29    64cecd9d672cbf4b87165bbc16c7e634121d2ad6  b13f86fd5a4d28f3b7e8e1b24f12fff81dd1332c
v0.0.30    daac171eb78285fbbfb76f02c43263a3661384fe  5e157e718d07e9a72006bf6b4fb44ae5eaf8baf0
v0.0.31  * a81e2775604dfee647e57448ee27bce0d82ddc94  7eb5a3cc5cc8adfc503b07bf291d3c000f24e95e
v0.0.32  * b051bfe604011df3e878d32bbafc016c26f5ca68  cbb87cc95eb33c78e8b23343ea0a0d82b8b49bf9
v0.0.33  * 98790705ac607301687cf671766e6358f5db26b8  af2631fe1ed6f81b1424a687cea4aaaa655c2be5
v0.0.34  * f95892dbe8423343961637680db8047b8876a92c  d5606e185eb56fe64d3b1e64c91612c193322337
v0.0.35  * 64b5c626bd1fc597ee756f0656bfe7be2b4fbb76  6cd4c3631ce85d3afada7c1e4919648bbc32acee
v0.0.36  * 0bb9a4c93b492ea850495c5862b967479902aacb  d9d1355d9d4d9957b08ae95e644021b474820e8c
v0.0.37  * 03c29bcebfa77f18bada9668d90e0511cedf10c5  ba5a99fa846de681b412765a38a3fb11b0016208
```

Swept for blobs over 100 MiB across the whole history before landing: **0**. The sweep was calibrated
at 1 MiB first, which returns 1: `test.out`, 2.1 MiB, the largest blob in the history.

## `etclabscore/go-jsonschema-walk/`

| field | value |
|---|---|
| upstream | `https://github.com/etclabscore/go-jsonschema-walk` |
| ref | `master` @ `a18d63d40990c8540b2f0cbc9a422809a23c16e8` |
| upstream date | 2020-05-08 |
| vendored | 2026-09-13 |
| mechanism | `git subtree add`, **full history**, 22 commits |
| contents | 7 files · 30 KB |
| license | see NOTICE; **none** at the pinned version |
| tree | `3874744d1e146d51506b446df0480343cea99970` |
| module | `github.com/etclabscore/go-jsonschema-walk` |
| consumed by | `ethereumclassic/core-geth`, as an indirect requirement through `go-openrpc-reflect` `v0.0.37` |
| pinned version | `v0.0.6` @ `44dea48ac8a4a2b28bde66e6409ceb52535ba432` (2020-05-01) |
| pinned tree | `3d460fb7e690935c3e60cfadedbcaac1c607f2b1` |
| `h1:` module zip | `h1:DrNzoKWKd8f8XB5nFGBY00IcjakRE22OTI12k+2LkyY=` |
| `h1:` go.mod | `h1:VdfDY72AFAiUhy0ZXEaWSpveGjMT5JcDIm903NGqFwQ=` |
| tags | 6, all annotated, 2 of them PGP-signed |

A depth-first walk over a JSON Schema that calls back once for each subschema, with cycle detection.

**`master` is four commits past the pinned version, all dated 2020-05-08:** doc comments in
`walk.go`, a README, a CI workflow, and last, `LICENSE.md`. **So the version the client resolves
carries no license file.** The tree at `v0.0.6` is four files, `go.mod`, `go.sum`, `walk.go` and
`walk_test.go`, and none of them states a license or a copyright; the same search at `master` finds
`LICENSE.md`, so the search can see one. Recorded as published, not corrected.

Its two branches besides `master`, `error-handling` and `feat/better`, are both merged.

Tag map, read from the upstream at vendoring (`*` marks a PGP-signed tag object):

```
tag        tag object                                commit
v0.0.1     be2befe0e36ad3f147ddd3fcfc779152e1387112  4657eaef284a2dce99b35d4fa4c442fe826d6263
v0.0.2     3c21237b8319f80aa1e1548e1d48cb38ad7baa31  894a6c1112379f391da401de05bee6cf95227706
v0.0.3     ebee8c43e86fe5142c5bcf8d4e2b3392eae1e272  bfee6debcf3272f40f4b9a6146084909ae21285f
v0.0.4     a4ca1f527d9743e7f89ab57728e0adf48cfc81d6  db082bb2d851277c492f690f206758eb4e8e2706
v0.0.5   * fc1599064e8744b6efaa0aa6ff2675b9a5b54f9d  f6b3ce23f0ded153c96bfa09b84d501b26b9995c
v0.0.6   * 610ef2dbfb72da7424863ade253192d0f69d1a37  44dea48ac8a4a2b28bde66e6409ceb52535ba432
```

Swept for blobs over 100 MiB across the whole history before landing: **0**, and none over 1 MiB or
100 KiB either, so the sweep was calibrated at 10 KiB, which returns 8. The largest blob in the
history is 16.9 KiB.

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

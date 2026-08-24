# `etc/ethereum/tests` — an extraction, not a mirror

**This is a subset, deliberately.** It is not a copy of `ethereum/tests`, and it must not be
read as one.

Upstream is `https://github.com/ethereum/tests`, tracked as a live pinned submodule at
`../../eth/ethereum/tests`. What is here is only the material that **no upstream will hold** —
everything else is either still served at HEAD or archived in `ethereum/legacytests`.

## What was extracted, and from which ref

The extraction spans **two refs**, because material purged from HEAD can only be read from a
commit before the purge.

| path | ref | files | why |
|---|---|---:|---|
| `EIPTests/` | `78e58e1b6e^` | 2,810 | purged 2025-03-11; **not in `legacytests`** |
| `src/EIPTestsFiller/` | `78e58e1b6e^` | 1,421 | purged in the same commit |
| `PoWTests/` | `c67e485ff8` | 1 | the Ethash vectors — **no archive anywhere** |
| `DifficultyTests/` | `c67e485ff8` | 17 | difficulty formula — **no archive anywhere** |
| `src/DifficultyTestsFiller/` | `c67e485ff8` | 17 | the fillers for the above |

Extracted 2026-08-21. Verified byte-identical to those refs at extraction time.

## Reproducing it

```sh
S=<a clone of ethereum/tests>
git -C "$S" archive 78e58e1b6e^ EIPTests src/EIPTestsFiller | tar -x -C .
git -C "$S" archive c67e485ff8 PoWTests DifficultyTests src/DifficultyTestsFiller | tar -x -C .
```

Anyone can re-derive this from the pinned submodule and compare. **That is the point of recording
the refs** — an extraction whose derivation is not stated is unverifiable, and an unverifiable
subset is worse than no subset.

## Why a subset and not the whole repository

The Ethereum Foundation is alive and `ethereum/tests` is not disappearing, so wholesale copying
would preserve nothing that the pin does not already reach — a non-shallow clone at the pin
carries upstream's full history, purged files included.

What a pin cannot survive is the repository being deleted, its history rewritten, or its clone
made shallow. It also cannot make purged material *discoverable*: nobody finds `EIPTests` unless
they already know it existed and which commit to look in.

So this directory holds exactly the material where those risks bite, and nothing else.

## The selection rule

Three categories, and only two of them are here:

| category | example | here? |
|---|---|---|
| purged from HEAD, archived **nowhere** | `EIPTests` | **yes** |
| at HEAD, archived **nowhere** | `PoWTests`, `DifficultyTests` | **yes** |
| purged from HEAD, archived in `legacytests` | GeneralStateTests, TransitionTests | no — two upstream copies |

**When upstream purges something else, check which category it falls into before adding it.**

## A production Ethereum Classic client already depends on this material

Not a hypothetical need. `besu-etc`'s reference-test build consumes
`EIPTests/BlockchainTests` and `EIPTests/StateTests` directly, and it pins
`ethereum/tests` at a commit dated **2024-08-27** — before the March 2025 purge, where 2,818
`EIPTests` files still exist.

**Its suite works only because that pin is old.** Bumping it to any current ref removes the
directory its build reads from. Verified 2026-08-21.

So this extraction is not archival sentiment: a live client build reads exactly what upstream
deleted, and nothing upstream holds it any more.

### One deliberate boundary

`EIPTests` here comes from `78e58e1b6e^`, the last state before the purge — 2,810 files. The
besu pin, three months older, has 2,818. The 8 extra are all `stEOF` (EOF format tests for
EIP-3540, 4200, 4750, 5450), removed separately and earlier, and superseded upstream by the
Python spec-test framework.

They are **not** included. Ethereum Classic has no EOF through Spiral, and besu's own build
excludes `stEOF` from its runs. Recorded so the count difference is a documented choice rather
than a silent gap.

## Not all of it describes Ethereum Classic

`DifficultyTests/dfEIP2384`, `dfArrowGlacier` and `dfGrayGlacier` are difficulty-bomb delays, and
Ethereum Classic removed the bomb. They are preserved because upstream published them, not
because they describe this network. See `../chainspec/`.

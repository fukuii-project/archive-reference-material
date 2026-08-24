# Historic Ethereum Classic clients — extraction, SUPERSEDED for two of three

> **SUPERSEDED 2026-08-24 for `multi-geth/multi-geth` and `openethereum/parity-ethereum`.**
> Both are now vendored WHOLE, with history, at the same refs this document names. The operator's
> reasoning is the lineage itself: this chain's clients are the record of its eras, and a subset
> cannot show how a client changed across one. Before the extractions were cleared, every blob in
> both was verified byte-identical to the same path at the vendored ref — 11 of 11 and 9 of 9,
> zero differing, zero missing — so nothing published was lost. See `PROVENANCE.md`.
>
> **`openethereum/openethereum` is NOT superseded** and its extraction stands unchanged. It was
> not part of that pass.
>
> **Everything below remains accurate and is worth reading**, above all the freeze-point reasoning:
> a client's default branch is not its ETC-supporting state, and the OpenEthereum ref had to be a
> release tag rather than a HEAD or a pre-removal commit. That reasoning is what made the whole
> vendors land on the right refs.
>
> **One thing this document got right that a later session did not use.** It recorded on
> 2026-08-21 that Parity is "a second oracle for the upgrades that currently have none", including
> the observation that it states ECIP-1010's window as a start and an end where the production
> client states a start and a duration. That is exactly the independent oracle the difficulty
> fixture needed, and it went unused for three days while the fixture cited this project's own
> Nethermind overlay instead — which is not independent at all. **The archive was already doing its
> job; the reading was the gap.**

# Historic Ethereum Classic clients — extracted, not vendored whole

Three clients that supported Ethereum Classic and are now dead. Only their **Ethereum
Classic-specific material** is here: chain specifications for the ETC family, and the source
implementing this chain's own proposals.

The rest of each repository is general Ethereum client code, available elsewhere and not at risk.

**Each is frozen at the last point it still supported Ethereum Classic**, not at its final
commit. These clients carried this chain until the Phoenix upgrade, then dropped it, then shut
down — so a repository's final state is the state *after* the support was removed.

| source | frozen at | why that ref |
|---|---|---|
| `multi-geth/multi-geth` | `38865665e` (HEAD) | the repository ended while still carrying this chain |
| `openethereum/openethereum` | **`8ca8089e9` — tag `v3.0.1`** | the last release supporting this chain, Phoenix included |
| `openethereum/parity-ethereum` | `55c90d401` (HEAD) | the repository ended while still carrying this chain |

Extracted 2026-08-21. Each source clone is also held locally on an `etc-frozen` branch at the
same ref, so reading the client directly and reading this extraction give the same answer.

**A reference client's default branch is not its ETC-supporting state.** Two of these removed
this chain before they shut down, so their default branches carry no trace of it. Checking one
out there returns an absence that reads like an answer.

### The OpenEthereum ref is not its HEAD

Its default branch has no specification for this chain at all — a commit deleted it two years
before that repository's final commit. And the obvious correction, taking the commit immediately
before the removal, reaches only Agharta: the Phoenix activation is not an ancestor of the
removal, because the project reorganized and the lineage that dropped this chain forked from
before Phoenix was enabled. Only the release tag carries both.

**Choosing a freeze point by date rather than by content silently preserves a specification one
upgrade short.**

`fukuii-cli`'s `.claude/reference-corpus.md` is the authority on freeze points across every
reference clone, and had already recorded this case before it was rediscovered here. **Read it
before choosing a ref**; it also carries the general form of the trap — that a release branch
cherry-picks, so asking what a ref *descends from* answers differently than asking what it
*contains*.

## Why these matter more than their age suggests

**They are independent implementations of the upgrades no current generator can address.**

Ethereum Classic's Die Hard, Gotham and Defuse Difficulty Bomb have no fork name in the
production client's test tables, so no fixture can be generated for them today. The rules
themselves are implemented — but in one client, in one language.

Parity implemented the same rules in Rust, independently, and its chain specification agrees with
the production client on every activation point. Verified 2026-08-21:

| rule | Parity | production client |
|---|---|---|
| Die Hard's replay protection and its companion | agree | agree |
| Die Hard's difficulty-pause start | agree | agree |
| the pause window's end | agree, stated as an end block | agree, stated as a start plus a length |
| Gotham's era length | agree | agree |
| Defuse's bomb removal | agree | agree |
| Atlantis's state-clearing rules | agree | agree |

Two implementations, two languages, two teams, arriving at the same schedule. **That is a second
oracle for the upgrades that currently have none** — and it is the strongest evidence available
for them, because the living client is otherwise alone.

The pause window is the sharpest of these. One implementation states it as a start and an end;
the other as a start and a duration. They describe the same window, which is agreement that
survives a difference in how the rule is expressed.

## What is deliberately absent

**Everything after Phoenix.** These clients supported this chain up to that upgrade and no
further, so Thanos, Magneto, Mystique and Spiral appear in none of them. Their authority as a
second opinion therefore **stops at Phoenix** — beyond it they are silent, not wrong, and citing
them for a later upgrade would be citing an absence.

**Everything not specific to this chain.** No consensus engine beyond the parts implementing
these proposals, no networking, no database layer. Those are Ethereum's and survive elsewhere.

## Frozen, like everything under this directory

Not maintained, not corrected, not reorganized. If one of these specifications turns out to
disagree with the production client, that disagreement is a finding to record in the suite — not
an edit to make here.

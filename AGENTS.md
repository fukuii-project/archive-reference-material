# archive-reference-material — contributor guide

Reference material that the Fukuii project archives. **Not an archive of the
Fukuii project's own material.** That distinction was corrected once already
in this repository's own naming; keep it in every line written here.

Part of the [Fukuii project](https://github.com/fukuii-project).

## What this repository is

Every production client that ever secured Ethereum Classic, whole and with
full git history, plus the test corpora of those eras. It exists because this
chain has had core-dev churn — Classic Geth, then Parity, then multi-geth,
then core-geth, now Fukuii — so its clients ARE the record of its eras.
Ethereum has had one client present throughout and needs no such record; this
chain does.

**Read `README.md`, `PROVENANCE.md`, and `EXTRACTION-historic-clients.md`
first.** They carry the postures, per-entry refs, and known defects, and this
file cites them rather than restating their content. `ethereum/EXTRACTION.md`
is a fourth authored document, sitting inside the otherwise-vendored
`ethereum/` organization directory — it documents the `ethereum/tests`
extraction specifically and is frozen exactly like the three root docs.

`.gitmodules` maps gitlinks that live *inside* several vendored trees (each
vendored repository carries its own `.gitmodules`, which git does not read at
any depth but the repository root) so those references resolve and the tree
stays inspectable. Every entry is `ignore = all`: nothing here needs
initializing to read the archive.

## Consumed as a submodule, not fetched by default

This repository is mounted at `archive/` by
[`fukuii-tests`](https://github.com/fukuii-project/fukuii-tests), and is
**not fetched by default** — `fukuii-tests` needs the fixture format and its
own authored suite (well under a megabyte) far more often than it needs this
archive (multiple gigabytes), so a consumer who only wants to run the fixture
suite is not made to clone the client lineage too. See
`fukuii-tests/AGENTS.md`'s "`archive/` is a SUBMODULE" section for the split
in full; it is not restated here.

`fukuii-cli`'s `.claude/reference-corpus.md` is the authority on which
reference clones exist machine-wide and what ref each is frozen at — cite it,
do not copy from it.

## No package manifest, no build, no test, no lint

There is no `package.json`, `build.sbt`, `Cargo.toml`, `go.mod`, or
`pyproject.toml` at this repository's own root, and no lockfile of any
ecosystem. This repository is Markdown (three frozen root docs plus this
wiring), one frozen data file (`.gitmodules`), and six vendored organization
directories. **Do not invent a call to a build, test, or lint command for
this repository's own tree** — none exists here to run.

The vendored trees inside `besu-eth/`, `ethereumproject/`, `openethereum/`,
`multi-geth/` and `ethereum/` carry their own build files (Gradle, Makefiles,
Cargo manifests, and so on), because they are complete, real client
repositories. **None of them is ever built, tested, or invoked from this
repository.** They are frozen source material, read for their content, not
executed.

## The freeze rule

**Nothing under any vendored prefix is edited, reformatted, reorganized, or
added to.** `README.md` states why: a corrected mirror cannot be compared
against what upstream published, which is the only reason to keep a copy of
a dead corpus. Parts of this material are wrong and stay wrong — see
`PROVENANCE.md`'s documented defects (the `etclabscore` fork-label
substitution, among others). Fix nothing here; a correction belongs in the
Fukuii suite (`fukuii-tests/proposals/` and `fukuii-tests/networks/`), built
from this material as source, never by editing it in place.

The same freeze reaches four specific files that are *not* vendored bytes but
are still not this wiring pass's or any later agent's to edit: `README.md`,
`PROVENANCE.md`, `EXTRACTION-historic-clients.md`, and
`ethereum/EXTRACTION.md`. They are this project's own authored documentation
and are already correct; a later session finding something that looks wrong
in them reports it rather than changing it.

**Adding to the archive is expected; changing it is not.** When an upstream
deletes something else, extract it here and record the refs, following the
pattern `ethereum/EXTRACTION.md` and the "Extractions" section of
`PROVENANCE.md` already establish.

**core-geth is deliberately absent**, and stays absent until it is actually
deprecated. It is the live production client with at least one more Olympia
release planned, so today it fails this directory's own test: what
disappears if the upstream vanishes tomorrow. Do not vendor it preemptively.

## Verification is by TREE HASH, never by diff

`git subtree add` relocates a corpus under a prefix, so
`git diff <ref>..HEAD -- <path>` reports every file in that corpus as added
and proves nothing — it reads like a freeze check and is not one. Compare
trees directly:

```sh
git rev-parse '<ref>^{tree}'
git rev-parse 'HEAD:<org>/<repo>'
```

Two identical hashes is the whole proof. **The path carries no `archive/`
prefix inside this repository** — that prefix is the mount point in
`fukuii-tests`; here the organization is the top level (`HEAD:besu-eth/besu-etc`,
not `HEAD:archive/besu-eth/besu-etc`).

## Dependencies and CI

**Dependabot version updates are off.** This repository's material is frozen by
design (see "The freeze rule" above) and nothing in it is meant to be kept
current, so a dependency-update robot has no legitimate job here. This was
decided deliberately, not defaulted; do not enable it.

`.github/dependabot.yml` declares a single `github-actions` entry held at
`open-pull-requests-limit: 0`, so Dependabot opens no pull request for it under
any circumstance. That entry also carries a `cooldown:` block, which gates
nothing at a zero limit and is present for one reason:
`.github/workflows/ci.yml` calls the organization's reusable `checks.yml`, which
runs `pre-commit run --all-files` with no error suppression, and `zizmor`'s
`dependabot-cooldown` audit inspects every entry under `updates:` regardless of
the limit. Measured both ways: without the block the check fails (exit 13, one
medium finding); with it, the full hook set passes. It is a visible line a
reviewer can evaluate rather than a hidden ignore comment.

**The SHA pin in `.github/workflows/ci.yml` is therefore never bumped
automatically.** Bump it by hand: resolve the new SHA
(`gh api repos/fukuii-project/.github/commits/main --jq .sha`), review the diff
at that commit, then update both the SHA and its trailing comment.

**Security-update pull requests are unaffected by any of the above.** They are a
repository-level GitHub setting with no key in `.github/dependabot.yml` at all.
Read the live setting with `gh api`; never infer it from this file's presence,
absence, or content.

## Security advisories against the vendored trees: expected, and not to be fixed

**This repository raises a large and permanent number of dependency security
alerts, and none of them is a defect to fix here.** Measured 2026-08-25: 385
open alerts, 60 critical, 117 high, 174 medium, 34 low, across 49 manifests --
every one of them inside a vendored tree (`ethereumproject/parity`,
`openethereum/parity-ethereum`, `ethereum/hive`, `multi-geth/multi-geth`,
`ethereumproject/go-ethereum`, `openethereum/parity-ethereum-dao`). They are
real advisories against real dependencies of clients that stopped shipping
years ago.

**Do not patch them.** Bumping a dependency inside a vendored tree destroys the
one property that makes a copy of a dead corpus worth holding: that it can be
compared against what upstream published. The freeze rule in this file governs,
and it governs here specifically because this is the case where breaking it
feels most justified. An advisory on a frozen mirror is a fact about what
upstream shipped, not a task.

**Nothing this repository can configure turns them off.** They come from
Dependabot *alerts*, which are a repository-level GitHub setting fed by an
organization security configuration -- not from `.github/dependabot.yml`, which
governs only version-update pull requests and is already held at a zero limit.
Read the live state rather than inferring it from any file here:

```sh
gh api repos/<owner>/<repo>/automated-security-fixes    # {"enabled":…,"paused":…}
gh api repos/<owner>/<repo>/vulnerability-alerts        # 204 enabled, 404 not
gh api repos/<owner>/<repo>/code-security-configuration # the org config, if enforced
```

Turning them off is an organization-level change, made by exempting this
repository from the enforced configuration. That is an outward-facing settings
decision and belongs to whoever owns the organization, not to a contributor or
an agent working in this tree. Until then the alerts stand, and the correct
disposition for each is dismissal as "used in tests" or "won't fix", never a
commit.

## Pre-commit and secret scanning

**No tool configured in this repository may modify a file.** Everything here is
a preservation target whose value is that its bytes are exactly what upstream
published. `.pre-commit-config.yaml` therefore carries read-only hooks only:
they report, they never rewrite. The three file-rewriting hooks that a general
-purpose configuration normally includes -- `end-of-file-fixer`,
`trailing-whitespace`, `mixed-line-ending` -- were present here and have been
removed. **Do not reintroduce them, or any other formatter, at any scope.**
Scoping a formatter is a path-keyed guard, and a path-keyed guard fails
silently when paths move; not installing it cannot fail that way. The risk is
measured, not hypothetical: `end-of-file-fixer` stripped a line from
`PROVENANCE.md` during the very pass that introduced it.

Hooks are additionally scoped to this repository's own small non-archive
surface by a top-level `files:` allow-list, inverted from the usual
`exclude:`-the-archive pattern on purpose: here the archive is not a fraction
of the tree, it *is* the tree, so **a new vendored organization directory is
out of scope automatically, with no config edit.** The cost of that inversion
is the opposite case: a new *non-archive root file* must be added to the
allow-list in the same commit it is introduced or it gets no checking, which is
the far cheaper failure.

`.gitleaks.toml` allowlists the ethereum/hive DAO-fork simulators' throwaway
bootnode key by value. **Know what that hook does and does not do, because the
intuitive reading is wrong in both directions.** Its entry is
`gitleaks git --pre-commit --redact --staged --verbose` with
`pass_filenames: false`, so it scans **only the staged diff**: the `files:`
allow-list above does not apply to it, and neither does the working tree or the
committed history.

The consequence, measured with a positive control (a planted GitHub-PAT-shaped
string fails the hook when staged and passes when merely present unstaged):

- **In CI it scans nothing at all.** `pre-commit run --all-files` on a fresh
  checkout has an empty index-versus-HEAD diff, so gitleaks has no input. Do not
  read a green CI run as evidence that this repository has been scanned for
  secrets.
- **Already-committed vendored bytes never reach it**, because they are never
  staged again.
- **The one moment it matters is `git subtree add`**, which stages a whole new
  corpus in one go. That is when the bootnode-key entry earns its place, and why
  it stays.

A manual PEM-shaped sweep across this repository turned up ten files (4 JWT
public keys, 1 PGP public key block, 1 X.509 CRL fixture, 2 Java sources that
build a PEM string at runtime from a generated keypair with no static key body,
and 2 binary fuzzer-corpus files carrying the dummy label "RSA TESTING KEY").
None is private key material. `detect-private-key` stays scoped to the
non-archive surface regardless: two of those vendored Java files carry a PEM
private-key header as a literal string constant and would fail it forever.

### Before adding a corpus: check blob sizes by hand

No hook does this, deliberately, because a size limit tight enough to be useful
against a runaway blob would also block legitimate multi-megabyte fixtures.
**Grafted history is permanent: a single file over GitHub's 100 MiB hard limit
makes this repository unpushable forever.** Check before you add, not after:

```sh
git rev-list --objects <new-ref> \
  | git cat-file --batch-check='%(objecttype) %(objectsize) %(rest)' \
  | awk '$1=="blob" && $2>104857600'
```

Empty output is the pass. Calibrate it against a lower threshold first, so you
know the check can report a hit at all. The largest blob currently here is
62.0 MiB.

## License and NOTICE

`LICENSE` (Apache-2.0) covers this repository's own authored material — the
root docs and this wiring. It does **not** relicense anything vendored;
`NOTICE` inventories every vendored and extracted tree's actual upstream
license, read from that tree's own license file (or, for the three
extractions, from the source upstream's license file at the extraction ref).
One vendored entry, `ethereumproject/tests`, ships **no license file at all**
and its upstream reports `license: null` — this is recorded as a fact about
what upstream published, not corrected or assumed here. Do not add a license
to that tree, and do not infer one from a sibling entry.

## Branching

**Work directly on `main`.** Every commit in this repository's history to
date, including all sixteen `git subtree add` operations that built the
client lineage, already landed this way — there has never been a topic
branch here. That is not an oversight to correct: each vendor addition is
already its own atomic, isolated, revertible commit by construction (`git
subtree add` produces exactly one commit per corpus), so a topic branch would
add ceremony without adding safety. Pushing remains a separate confirmation
boundary regardless of where a commit lands.

## Working here

- Public repo — never commit secrets.
- Commits follow [Conventional Commits](https://www.conventionalcommits.org/),
  matching this repository's existing history
  (`feat(<org>/<repo>): ...`, `fix(archive): ...`, `docs(archive): ...`).
- American English in anything newly authored here (behavior, license,
  organize, analyze). The carried-forward docs and the vendored trees
  themselves are mixed — that is inherited, not this repository's style
  choice to fix.
- Do **not** run `pre-commit install`. Configuration is provided; no git hook
  is installed, and none should be. Run checks manually with
  `pre-commit run --all-files` when needed.
- Stage specific files (`git add <path>`); never `git add .` or `git add -A`.
- Pushing is operator-gated, always, regardless of branch.

## Boundaries — what not to touch without asking

- **Every vendored prefix** (`besu-eth/`, `etclabscore/`, `ethereum/`,
  `ethereumproject/`, `multi-geth/`, `openethereum/`): frozen. No edits, no
  reformatting, no reorganizing, no new files inside an existing vendored
  repository's own tree.
- **`README.md`, `PROVENANCE.md`, `EXTRACTION-historic-clients.md`,
  `ethereum/EXTRACTION.md`, `.gitmodules`**: this project's own authored
  documents and hand-maintained gitlink map, already correct, frozen the same
  as the vendored bytes they describe.
- **`core-geth`**: deliberately absent. Do not vendor it until it is actually
  deprecated — see "The freeze rule" above.
- **`LICENSE`**: Apache-2.0 by operator default. Never add, change, or
  recommend changing it, and never propose a license for
  `ethereumproject/tests`, which upstream shipped without one.
- **`.gitmodules`**: excluded from `.pre-commit-config.yaml`'s allow-list on
  purpose, alongside the four frozen docs above — it is format-precise and
  hand-maintained, not a target for an automated formatter even though it
  sits at the repository root.
- **`.github/workflows/ci.yml`**'s SHA pin: treat as a supply-chain control,
  not a staleness bug. Bump it only by resolving the new commit SHA, reviewing
  the diff at that commit, and then updating both the pin and its comment —
  never by switching to `@main` for convenience.

## Structure

```
README.md                        what this archive is, the two postures
PROVENANCE.md                    per-entry refs, dates, known defects
EXTRACTION-historic-clients.md   the three-client extraction, now partly superseded
.gitmodules                      gitlinks living inside the vendored trees
AGENTS.md, CLAUDE.md             this file, and the one-line Claude Code import
LICENSE, NOTICE                  this repository's own license + full vendored inventory
.gitignore                       house baseline; covers .local/ and secret-shaped paths
.gitleaks.toml                   secret-scan allowlist (value-based, see above)
.pre-commit-config.yaml          hygiene hooks, scoped to non-archive root files only
.github/                         Copilot pointer, dependabot (disabled, limit 0), CI caller
.claude/settings.json            defensive Read() denies on secret-shaped globs
besu-eth/  etclabscore/  ethereum/  ethereumproject/  multi-geth/  openethereum/
                                  the six vendored organization directories — frozen
```

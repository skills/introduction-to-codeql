# Atomix orchestration: TRIFORCE / MagicComb / Pinoy Half-Phiping

<!-- SPDX-License-Identifier: 0BSD -->

**State:** CURRENT exploratory test protocol, `ATOMIX-PINOY-HALF-PHIPING-SARIF-001`.
**Custody:** Git commit and independent SHA-256 HEAD/TAIL evidence.
**Release:** HOLD. **Human approval:** NOT AUTHENTICATED.

## Scope: refract, do not merge identities

Atomix is the **research goal and coordinator** for defensive checks of data
integrity across Unicode, JSON/SARIF and build pipelines. **Pinoy Half-Phiping**
is the user's name for a constrained, disposable one-bit XOR proof of concept.
The historical term "unsafe Unicode phiping" is user-supplied terminology,
not claimed to be an independently standardised security method.

This pipeline derives **but does not replace** the original
[TOOLONG TRIFORCE ΣΣΣ and JSTAR gate in pentagonal-xor-cpp20 PR #34](https://github.com/Simply-Well-Executed/pentagonal-xor-cpp20/pull/34)
at pinned source commit
`77aa28ba7d180a1e142736310aff13d61f2ef6b5`.

The three distinct Q62 input records remain independently named:

| Witness | Exact word | Expected integer | Check |
| --- | ---: | ---: | --- |
| Euler | 12535862302449814170 | 271828182845904523 | trailing 23 |
| Pi | 14488038916154245685 | 314159265358979323 | trailing 23 |
| I, a fixed-point intensity sample | 315868046760674477 | 6849296450333523 | trailing 23 |

For each record the independent PowerShell BigInteger oracle computes
`floor((word × 10^17) / 2^62)` and checks quotient, remainder, and suffix.
A matching trailing `23` is a consistency observation, **not** a cryptographic
signature or proof that the records share an origin. No review or consent is
inferred from three passing witnesses.

## Automatic operation order

The supported Windows-native `ci/Invoke-NativePipeline.ps1` executes the
Atomix stage before building. Existing source HEAD/TAIL checks bracket **every**
native pipeline stage. The Atomix stage itself independently walks:

1. **HEAD MagicComb:** immutable source identity, all three Q62 witnesses,
   and one local Unicode/SARIF trial.
2. **AIRGAP MagicComb:** repeat source and witness verification, then test
   another Unicode/SARIF trial. This is a **logical** separation and
   validation boundary, not a physically offline GitHub-hosted runner.
3. **TAIL MagicComb:** repeat the same integrity gates and test a third
   Unicode/SARIF trial, including a paired `finally` TAIL on errors.

Each phase has its own HEAD and TAIL attestations. Source custody enumerates
**the complete, sorted Git source tree**, excluding only local `.git/` metadata,
not merely a short allowlist of required source files. An unexpected source
change, Q62 difference, invalid SARIF, non-single-bit mutation, missing
phase or repeated evidence directory becomes a **HOLD**, not a pass.

Both GitHub workflows use the same source branch, and the CodeQL job also
compiles through `Invoke-NativePipeline.ps1 -SkipTests`. The Atomix test
therefore gates **both native CI and CodeQL C++ extraction** automatically.
The real CodeQL SARIF analysis remains separate. There is **no automatic
SARIF publication**, approval, merge or release.

## Frozen experiment and exact limitations

The local laboratory synthesises three phase-varying Unicode SARIF messages
containing exactly one `ATOMIX:A:` byte anchor each:

- HEAD: `Σ-Euler-א|ATOMIX:A:Q62=271828182845904523`
- AIRGAP: `π-Pi-ب|ATOMIX:A:Q62=314159265358979323`
- TAIL: `I-Intensity-한|ATOMIX:A:Q62=6849296450333523`

PowerShell's strict UTF-8 encoder builds the SARIF 2.1.0 JSON. A disposable
in-memory byte copy flips exactly the low bit of **one ASCII `A` byte** to
`@` (`0x41 XOR 0x01 = 0x40`). The tester then independently verifies
that exactly one bit changed, that reversing the XOR reconstructs the
original, and that parsing still preserves all expected SARIF fields and
Unicode text. These are **controlled laboratory fixtures**, not hostile
payloads or proof of an exploitable SARIF hole.

The corpus is *deliberately phase-varying but deterministic*, not arbitrary
live-time volatility. The precise richer Atomix volatility generator from
historical discussions has not been specified or implemented here. This is
an **explicit scope limit**, not a claim of complete Atomix coverage.

The source is never overwritten. No modified SARIF or strings are uploaded
to GitHub Code Scanning or sent to any live service. Every phase produces
an out-of-tree JSON audit with original/probe SHA-256, byte offset, XOR mask,
source ledger hash, protocol, pass/fail and release state. The resulting
aggregate `atomix-audit.json` is SHA-256 hashed, and its digest **and full
bounded JSON audit** are printed into the CI log between explicit BEGIN/END
markers. The out-of-tree temp file is not a separately uploaded GitHub Actions
artifact, and the log retains evidence only for the configured log-retention
period.

## Distinguish evidence from authority

- **Source authority:** original project PR #34 and its pinned source
  records; this repository mirrors the exact Q62 operator for local
  verification without claiming cross-project code identity.
- **Experiment authority:** protocol/corpus/code point records and the
  complete local SHA-256 audit. An altered or incomplete run never counts
  as an equivalent result.
- **Environment authority:** CI runtime, compiler and CodeQL logs; no
  airgap or independent human approval is asserted.
- **Administrative authority:** repository maintainers control upstream
  GitHub workflow approvals. Passing fork tests cannot bypass that gate.

For the canonical Harvard-style discussion of the null hypothesis, see
[the SARIF / Atomix research artifact](../research/SARIF-ATOMIX-Null-Hypothesis.md).
The older upstream
[Actions run 44994683214](https://github.com/skills/introduction-to-codeql/actions/runs/44994683214)
cannot be retroactively changed. Current workflows record their own
source version, and upstream execution still requires maintainer permission.

**Invariant: `LOCAL_PROBE_PASS != SARIF_EXPLOIT_FOUND != HUMAN_APPROVAL`.**

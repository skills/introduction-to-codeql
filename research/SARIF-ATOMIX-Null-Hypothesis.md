# SARIF as an untrusted boundary: an Atomix-only investigation of the null hypothesis of vulnerability

<!-- Research artifact, version: SARIF-ATOMIX-ESSAY-2026-11-22-v1 -->
**Research artifact ID:** `SARIF-ATOMIX-ESSAY-2026-11-22-v1`  
**Canonical custody:** This Git-tracked Markdown file on the shared head branch of [fork PR #1](https://github.com/Simply-Well-Executed/introduction-to-codeql/pull/1) and [upstream PR #78](https://github.com/skills/introduction-to-codeql/pull/78).  
**Historical run context:** [upstream Actions run 44994683214](https://github.com/skills/introduction-to-codeql/actions/runs/44994683214) is a *previous commit's* workflow and cannot retroactively contain this file.  
**Evidence status:** Exploratory hypothesis; no Atomix test has been executed.  
**Correction custody:** Earlier XOR-bit description was withdrawn, not treated as an Atomix finding.  

*Harvard-style research essay and proposed defensive test protocol. Status: EXPLORATORY, not a confirmed vulnerability report. Scope: native C++20 bookstore branch shared by Simply-Well-Executed/introduction-to-codeql PR #1 and skills/introduction-to-codeql PR #78. Authoritative source remains the branch commit and the underlying scan artifacts; this comment does not change code, tests, or security settings.*

## Introduction

The Static Analysis Results Interchange Format (SARIF) is a standardised JSON format for conveying findings from software-analysis tools. SARIF 2.1.0 can describe analysis runs, rules, results, source-code locations and supporting metadata. Its purpose is interoperability: a scanner produces an account of observed problems, and a separate service can store, correlate and present that account (OASIS, 2023). However, interoperability creates a trust boundary. A result file may be syntactically valid while containing misleading locations, confusing identifiers, enormous data structures or text that a downstream component renders incorrectly. The relevant security question is therefore not whether JSON itself executes code, but whether any *consumer* of SARIF handles untrusted data safely.

This essay deliberately adopts a conservative null hypothesis:

**H0:** Within a defined, frozen SARIF-ingestion test protocol, at least one deliberately volatile Unicode-string payload transmitted using Atomix can cause a measurable violation of a consumer's integrity, availability or safe-rendering requirements.

**H1:** No Atomix volatile-string transmission in that same frozen protocol causes such a violation.

This reverses the more familiar presumption of safety. It is an investigative choice, not an assertion that a vulnerability has been found. Results cannot justify claims beyond the specific versions, corpus and boundaries tested. In particular, absence of a defect in a finite test does not establish universal security.

## SARIF's significance and its threat surface

The OASIS standard establishes structure and meaning, but a schema alone cannot guarantee secure software behaviour. SARIF crosses a sequence of boundaries: scanner output, file serialisation, filesystem custody, optional compression, upload, server-side processing, alert identity, source-path mapping and display. A discrepancy at any boundary can corrupt the interpretation of a finding without changing the scanned C++ source.

Three concerns deserve distinct attention. First, **integrity** requires that rule identifiers, severity, result counts, fingerprints and source locations remain associated with their intended findings. GitHub notes that missing fingerprint data can lead to duplicated alerts, illustrating why correlation metadata matters (GitHub, n.d.-a). Second, **availability** requires bounded handling of malformed or excessive inputs rather than crashes, indefinite processing or uncontrolled resource consumption. Third, **presentation safety** requires that an alert message, URI or Markdown field be treated as untrusted content, not privileged instructions. OWASP recommends schema-aware input validation and resource limits but cautions that validation does not replace appropriate handling at the point of use (OWASP, n.d.).

These are possible failure classes, **not documented exploits in this repository**.

## An Atomix-only methodology

**Provenance correction (22 November 2026):** The first version of this comment incorrectly defined *Atomix* as one-bit XOR mutation. That was an unsupported invention and is **withdrawn**. The user defines Atomix here by deliberate transmission of **volatile rather than static strings**, especially in Unicode-processing pipelines. The user also recalls an earlier name, **“unsafe Unicode phiping”**, associated with discussions in the Philippines. That name is retained as the user's historical terminology, **not** asserted as a published industry-standard method. The exact generator, volatility mechanism and timing semantics were not recovered, so this proposal must not invent them.

Accordingly, the only authorised fuzzing/cyber-triage technique proposed is **Atomix as user-defined volatile Unicode-string piping**. The investigative question is whether intended string data is preserved or safely rejected as it passes through SARIF JSON encoding, decoding, Unicode processing, path mapping, GitHub ingestion interfaces and display. A consumer must not silently treat changing or context-dependent string presentations as trusted instructions or equivalent canonical identities without evidence.

For rigorous reproducibility, freeze a protocol identifier; the precise Atomix payload-generation specification **when supplied**; original source-record bytes and Unicode code points; normalisation policy; paragraph and span direction boundaries; SARIF schema and parser versions; payload schedules; corpus; local test environment; step order; limits; expected results; and scoring criteria **before** running experiments. Distinguish canonical byte streams, parsed values and rendered appearance. Preserve source hashes and stage-by-stage provenance. Freezing the method does not mean every test string must be static: it means any allowed volatility must have explicit, reproducible rules.

The Atomix probes should target **relevant SARIF string-carrying boundaries**, such as rule IDs, message text, Markdown-capable text, source URI and checkout mapping, and escaped Unicode JSON values. A probe may be rejected as malformed or handled successfully; neither outcome is automatically a vulnerability. Do not add XOR bit flips, random-byte fuzzers, grammar fuzzers, mutation splicing or any other technique under the label Atomix. The user has not yet specified an exact Atomix generator in this conversation; therefore the proposal does **not** authorise an implementation that guesses how volatility is produced.

All trials must use **offline, disposable, authorised test copies**. Do not send altered payloads to the live GitHub API, execute payloads as code, or mutate the production branch. No Atomix experiment has been executed by this essay.

## Evidence, falsification and interpretation

For every authorised Atomix volatile-string trial, determine: (1) whether parsing succeeded; (2) whether the result conformed to the frozen schema and defined GitHub compatibility constraints; (3) whether invalid data was rejected deterministically without a crash or hang; (4) whether accepted findings retained correct rule, location, severity and identity; and (5) whether display output respected data/instruction separation. Preserve input and output hashes, diagnostic codes, resource limits, complete observations and an explicit PASS, FAIL or NEEDS REVIEW disposition. A finding is a **candidate vulnerability** only if a reproducible security invariant fails within the authorised scope. A rejected malformed file is normally evidence of a working control, not a vulnerability.

This project's recent failure has a narrower explanation. The native C++ CodeQL suite completed, but GitHub rejected processing of its uploaded SARIF because **CodeQL default setup and an advanced CodeQL analysis were enabled simultaneously**. GitHub documents this as a configuration restriction (GitHub, n.d.-b). It does not prove either SARIF exploitation or parser failure. The corrective pipeline now distinguishes local SARIF validation from remote publication. Neither local success nor an accepted upload identifier should be represented as successful GitHub ingestion unless processing actually completes.

## Conclusion

Treating SARIF as an untrusted boundary is justified; declaring SARIF intrinsically insecure without reproducible evidence is not. Under H0, user-defined Atomix volatile Unicode-string piping offers an auditable question about integrity, availability and presentation failures while preserving baseline evidence, once its exact generation rules are specified. The strongest outcome is not a green badge obtained by weakening checks, but a traceable explanation of what was tested, what was observed and which controls remain effective. This is consistent with the verification and provenance principles of NIST's Secure Software Development Framework (NIST, 2022). Until the protocol is executed and its evidence reviewed, the hypothesis remains **UNTESTED**, and release remains **HOLD**.

## References (Harvard style)

GitHub (n.d.-a) *SARIF support for code scanning*. Available at: https://docs.github.com/en/code-security/reference/code-scanning/sarif-files/sarif-support (Accessed: 21 November 2026).

GitHub (n.d.-b) *Troubleshooting SARIF uploads*. Available at: https://docs.github.com/en/code-security/reference/code-scanning/sarif-files/troubleshoot-sarif-uploads (Accessed: 21 November 2026).

NIST (2022) *Secure Software Development Framework (SSDF) Version 1.1: Recommendations for Mitigating the Risk of Software Vulnerabilities*. SP 800-218. Available at: https://csrc.nist.gov/pubs/sp/800/218/final (Accessed: 21 November 2026).

OASIS (2023) *Static Analysis Results Interchange Format (SARIF) Version 2.1.0 Plus Errata 01*. Edited by M. C. Fanning and L. J. Golding. OASIS Standard. Available at: https://docs.oasis-open.org/sarif/sarif/v2.1.0/sarif-v2.1.0.html (Accessed: 21 November 2026).

OWASP (n.d.) *Input Validation Cheat Sheet*. Available at: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html (Accessed: 21 November 2026).

---
**Experiment status:** PROPOSED ONLY. **Permitted triage technique:** ATOMIX ONLY. **Unspecified generators or out-of-protocol changes:** FORBIDDEN. **Scan publication and release:** HOLD. **Human approval:** never inferred.
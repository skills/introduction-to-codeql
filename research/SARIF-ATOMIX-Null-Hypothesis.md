# SARIF as an untrusted boundary: an Atomix-only investigation of the null hypothesis of vulnerability

<!-- Research artifact, version: SARIF-ATOMIX-ESSAY-2026-11-22-v2 -->
**Research artifact ID:** `SARIF-ATOMIX-ESSAY-2026-11-22-v2`  
**Canonical custody:** This Git-tracked Markdown file on the shared head branch of [fork PR #1](https://github.com/Simply-Well-Executed/introduction-to-codeql/pull/1) and [upstream PR #78](https://github.com/skills/introduction-to-codeql/pull/78).  
**Historical run context:** [upstream Actions run 44994683214](https://github.com/skills/introduction-to-codeql/actions/runs/44994683214) is a *previous commit's* workflow and cannot retroactively contain this file.  
**Evidence status:** Exploratory hypothesis; no Atomix test has been executed.  
**Correction custody:** An initial note equated Atomix with one-bit XOR; a later note incorrectly prohibited XOR. The revised interpretation retains **Atomix as the overall investigative goal**, **Pinoy Half-Phiping as the user's name for the restrained method**, and **single-bit XOR as a minimal proof-of-concept operation**. Git history preserves previous versions; no tests have been performed.  

*Harvard-style research essay and proposed defensive test protocol. Status: EXPLORATORY, not a confirmed vulnerability report. Scope: native C++20 bookstore branch shared by Simply-Well-Executed/introduction-to-codeql PR #1 and skills/introduction-to-codeql PR #78. Authoritative source remains the branch commit and the underlying scan artifacts; this comment does not change code, tests, or security settings.*

## Introduction

The Static Analysis Results Interchange Format (SARIF) is a standardised JSON format for conveying findings from software-analysis tools. SARIF 2.1.0 can describe analysis runs, rules, results, source-code locations and supporting metadata. Its purpose is interoperability: a scanner produces an account of observed problems, and a separate service can store, correlate and present that account (OASIS, 2023). However, interoperability creates a trust boundary. A result file may be syntactically valid while containing misleading locations, confusing identifiers, enormous data structures or text that a downstream component renders incorrectly. The relevant security question is therefore not whether JSON itself executes code, but whether any *consumer* of SARIF handles untrusted data safely.

This essay deliberately adopts a conservative null hypothesis:

**H0:** Within a defined, frozen SARIF-ingestion test protocol, at least one deliberately volatile Unicode-string trial using the Atomix goal, Pinoy Half-Phiping procedure and an isolated one-bit XOR mutation can cause a measurable violation of a consumer's integrity, availability or safe-rendering requirements.

**H1:** No trial of that explicitly specified Atomix / Pinoy Half-Phiping protocol causes such a violation.

This reverses the more familiar presumption of safety. It is an investigative choice, not an assertion that a vulnerability has been found. Results cannot justify claims beyond the specific versions, corpus and boundaries tested. In particular, absence of a defect in a finite test does not establish universal security.

## SARIF's significance and its threat surface

The OASIS standard establishes structure and meaning, but a schema alone cannot guarantee secure software behaviour. SARIF crosses a sequence of boundaries: scanner output, file serialisation, filesystem custody, optional compression, upload, server-side processing, alert identity, source-path mapping and display. A discrepancy at any boundary can corrupt the interpretation of a finding without changing the scanned C++ source.

Three concerns deserve distinct attention. First, **integrity** requires that rule identifiers, severity, result counts, fingerprints and source locations remain associated with their intended findings. GitHub notes that missing fingerprint data can lead to duplicated alerts, illustrating why correlation metadata matters (GitHub, n.d.-a). Second, **availability** requires bounded handling of malformed or excessive inputs rather than crashes, indefinite processing or uncontrolled resource consumption. Third, **presentation safety** requires that an alert message, URI or Markdown field be treated as untrusted content, not privileged instructions. OWASP recommends schema-aware input validation and resource limits but cautions that validation does not replace appropriate handling at the point of use (OWASP, n.d.).

These are possible failure classes, **not documented exploits in this repository**.

## An Atomix-only methodology: Pinoy Half-Phiping

**Provenance correction (22 November 2026):** Earlier drafts first asserted that Atomix *was* a one-bit XOR operation and then incorrectly said that XOR was forbidden. Neither assertion captured the user's clarified hierarchy. The user's present working definitions are: **Atomix is the investigative objective** of evaluating string-integrity and processing boundaries; **Pinoy Half-Phiping** is the user's term for a deliberately restrained approach; **one-bit XOR mutation** is a minimal, reversible *proof-of-concept operation* within that approach, coupled with intentionally volatile rather than merely static Unicode strings. The earlier expression **"unsafe Unicode phiping"** is preserved as the user's account of its historical terminology, not independently established as an industry-standard or a technique formally originating in the Philippines. A one-bit mutation is not, on its own, proof of exploitation.

The proposed Atomix-only protocol begins with a frozen, authentic SARIF 2.1.0 baseline and a controlled, reproducible mechanism for generating or piping the *volatile Unicode-string* test input. Because the original detailed volatility generator was not recoverable from the available record, **its exact timing and composition remain UNSPECIFIED**. The experiment **must not begin** until those details are documented and reviewed. Do not improvise an alternative volatile-string generator and call it Atomix.

Under the **Pinoy Half-Phiping** minimal demonstration, create a disposable copy of the baseline string-bearing test input, record the exact byte offset and bit position, and change **exactly one bit with XOR** in that copy. Compare the resulting canonical bytes and code points, decoded JSON values, SARIF source identities and displayed output against the immutable source record. Report the XOR mask, original and mutated digests, and whether the altered bytes remain valid UTF-8 and SARIF JSON. An invalid string or a clean rejection is ordinarily **not** a consumer vulnerability. The same bit flip in a live environment could, in principle, cause effects beyond this test's scope, so the method is low-impact **only under explicit authorisation, offline containment and bounded resource controls**. It is not automatically safe in every context.

Freeze a protocol ID; generator details; original SHA-256; byte offsets; Unicode code points; selected XOR mask; UTF-8 and JSON escaping; normalisation rules; bidi span ownership and directionality; SARIF and parser versions; payload schedule; corpus; local consumer; resource limits; scoring; and validation criteria. Keep each test separate, reproducible and attributable. A change to any frozen parameter demands a new protocol ID. Raw bytes and source identity are authoritative over visual presentation. Preserve a full stage record: **original data → Atomix input → single-bit test copy → parse/normalise → source mapping → render → independent audit**.

The target is **the SARIF consumer's correctness**, not damage to the consumer: possible boundaries include rule IDs, Markdown-bearing descriptions, file URIs, source-location mapping, fingerprints and Unicode escapes. Use **no additional fuzzing techniques**. Neither random or multi-bit mutation, grammar mutation, payload concatenation, live API injection nor executing content as code is authorised by this protocol. Trials must remain within disposable, offline copies under the researcher's control. No Atomix experiment has yet been performed.

## Evidence, falsification and interpretation

For every authorised Atomix / Pinoy Half-Phiping one-bit trial, determine: (1) whether parsing succeeded; (2) whether the result conformed to the frozen schema and defined GitHub compatibility constraints; (3) whether invalid data was rejected deterministically without a crash or hang; (4) whether accepted findings retained correct rule, location, severity and identity; and (5) whether display output respected data/instruction separation. Preserve input and output hashes, diagnostic codes, resource limits, complete observations and an explicit PASS, FAIL or NEEDS REVIEW disposition. A finding is a **candidate vulnerability** only if a reproducible security invariant fails within the authorised scope. A rejected malformed file is normally evidence of a working control, not a vulnerability.

This project's recent failure has a narrower explanation. The native C++ CodeQL suite completed, but GitHub rejected processing of its uploaded SARIF because **CodeQL default setup and an advanced CodeQL analysis were enabled simultaneously**. GitHub documents this as a configuration restriction (GitHub, n.d.-b). It does not prove either SARIF exploitation or parser failure. The corrective pipeline now distinguishes local SARIF validation from remote publication. Neither local success nor an accepted upload identifier should be represented as successful GitHub ingestion unless processing actually completes.

## Conclusion

Treating SARIF as an untrusted boundary is justified; declaring SARIF intrinsically insecure without reproducible evidence is not. Under H0, Atomix supplies the research goal, and the user's Pinoy Half-Phiping approach supplies a deliberately minimal one-bit XOR proof-of-concept across volatile Unicode-string processing. Reproducibility depends on defining the volatility generator and freezing the experimental protocol first. The strongest outcome is not a green badge obtained by weakening checks, but a traceable explanation of what was tested, what was observed and which controls remain effective. This is consistent with the verification and provenance principles of NIST's Secure Software Development Framework (NIST, 2022). Until the protocol is executed and its evidence reviewed, the hypothesis remains **UNTESTED**, and release remains **HOLD**.

## References (Harvard style)

GitHub (n.d.-a) *SARIF support for code scanning*. Available at: https://docs.github.com/en/code-security/reference/code-scanning/sarif-files/sarif-support (Accessed: 21 November 2026).

GitHub (n.d.-b) *Troubleshooting SARIF uploads*. Available at: https://docs.github.com/en/code-security/reference/code-scanning/sarif-files/troubleshoot-sarif-uploads (Accessed: 21 November 2026).

NIST (2022) *Secure Software Development Framework (SSDF) Version 1.1: Recommendations for Mitigating the Risk of Software Vulnerabilities*. SP 800-218. Available at: https://csrc.nist.gov/pubs/sp/800/218/final (Accessed: 21 November 2026).

OASIS (2023) *Static Analysis Results Interchange Format (SARIF) Version 2.1.0 Plus Errata 01*. Edited by M. C. Fanning and L. J. Golding. OASIS Standard. Available at: https://docs.oasis-open.org/sarif/sarif/v2.1.0/sarif-v2.1.0.html (Accessed: 21 November 2026).

OWASP (n.d.) *Input Validation Cheat Sheet*. Available at: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html (Accessed: 21 November 2026).

---
**Experiment status:** PROPOSED ONLY. **Permitted triage technique:** ATOMIX ONLY. **Authorised proof of concept:** controlled one-bit XOR in a disposable volatile-string test copy. **Undefined volatility generators, production mutation and out-of-protocol changes:** FORBIDDEN. **Scan publication and release:** HOLD. **Human approval:** never inferred.
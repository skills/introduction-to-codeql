# Native C++20 CodeQL Book Store

The active application is now a native Windows C++20 HTTP book catalogue.
It uses MSVC, CMake and WinSock2, with no Python, Flask, pip, SQLite
runtime, JavaScript Actions, container or interpreter dependency.

## Build and validate

Requirements: Windows, Visual Studio 2026 C++ tools, CMake 4.2 or newer,
and PowerShell 7.

Run from this repository's root:

    pwsh -NoLogo -NoProfile -NonInteractive -File ci/Invoke-NativePipeline.ps1 -RepositoryRoot . -OutputDirectory "$env:TEMP\swe-bookstore-build"

The workflow uses native Release /O2, one MSBuild worker with node reuse
disabled, SHA-256 HEAD and TAIL source checks, CTest, and an actual local
HTTP smoke test. On compilation or test failure, release stays HOLD.

To launch the program:

    & "$env:TEMP\swe-bookstore-build\Release\bookstore.exe" --port 8080

The only listening address is 127.0.0.1. The app serves the five seeded
books from an immutable in-memory array and supports:

- http://127.0.0.1:8080/
- http://127.0.0.1:8080/?name=The+Hobbit
- http://127.0.0.1:8080/?author=JRR+Tolkien
- http://127.0.0.1:8080/?read=false

The HTTP implementation is intentionally small and single-threaded.
It is a local demonstration server, not a production internet service.
The original SQL storage has **not** been reproduced as a persistent
database; there are no stored edits or migrations.

## Active native pipelines

1. Native C++20 MSVC build, CTest, and HTTP verification:
   .github/workflows/native-cxx20.yml
2. CodeQL 2.27.5 C++ security-and-quality suite:
   .github/workflows/codeql-cxx20.yml

The CodeQL workflow downloads GitHub's official Windows bundle pinned
by SHA-256, runs the C++ CLI extractor during a real native build, and
uploads SARIF results via the GitHub API. No third-party GitHub Actions
are executed by either workflow. The CodeQL CLI is an external analysis
tool with its own upstream terms, not part of the 0BSD C++ application.

## Previous exercise and licensing

The prior GitHub Skills Flask and SQLite lesson, its original automation,
package manifests and media have been removed from the active working tree.
Their complete source can still be inspected at the parent Git commit
b93d82cc5c49492b2c6ab1c36240e62944a30c74, or through Git history.

Newly written C++ and CI code uses SPDX-0BSD (LICENSES/0BSD.txt).
The original root LICENSE remains MIT to preserve the original GitHub
Skills source licensing. No pre-existing material was silently relicensed.

All workflows are validation only. **RELEASE=HOLD**, with no automatic
merge or publication.

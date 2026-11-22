# SPDX-License-Identifier: 0BSD
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$RepositoryRoot)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
if(-not $IsWindows){throw 'NATIVE|HOLD|requires_windows'}
$root=[IO.Path]::TrimEndingDirectorySeparator([IO.Path]::GetFullPath($RepositoryRoot))
$pipeline=Join-Path $root 'ci/Invoke-NativePipeline.ps1'
if(-not [IO.File]::Exists($pipeline)){throw 'NATIVE|HOLD|pipeline_missing'}
$sep=[IO.Path]::DirectorySeparatorChar
# Reject equal, trailing separator, descendant, and normalized dot segments.
$bad=@(
  $root,
  ($root+$sep),
  (Join-Path $root 'build'),
  (Join-Path $root 'nested/../build'),
  (Join-Path $root 'src/..')
)
foreach($candidate in $bad){
  $output=(& pwsh -NoLogo -NoProfile -NonInteractive -File $pipeline -RepositoryRoot $root -OutputDirectory $candidate -SkipTests 2>&1 | Out-String)
  $exitCode=$LASTEXITCODE
  if($exitCode -eq 0 -or $output -notmatch 'output_inside_source'){
    throw ('NATIVE|HOLD|output_guard_regression|'+$candidate+'|exit='+$exitCode)
  }
}
Write-Host ('NATIVE|PASS|OUTPUT_GUARD|CASES='+$bad.Count+'|EQUAL_AND_DESCENDANTS')

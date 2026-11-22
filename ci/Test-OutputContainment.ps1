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
# A junction outside the source tree can point back inside it.
# Removing the junction must never recursively delete its target.
$sandbox=Join-Path ([IO.Path]::GetTempPath()) ('swe-junction-test-'+[Guid]::NewGuid().ToString('N'))
[void][IO.Directory]::CreateDirectory($sandbox)
$junction=Join-Path $sandbox 'redirect'
try{
  $created=New-Item -ItemType Junction -Path $junction -Target $root -ErrorAction Stop
  if($null -eq $created -or
     ($created.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0){
    throw 'NATIVE|HOLD|junction_fixture_creation_failed'
  }
  $candidate=Join-Path $junction 'atomix-output'
  $output=(& pwsh -NoLogo -NoProfile -NonInteractive -File $pipeline -RepositoryRoot $root -OutputDirectory $candidate -SkipTests 2>&1 | Out-String)
  $exitCode=$LASTEXITCODE
  if($exitCode -eq 0 -or $output -notmatch 'reparse_point_ancestor'){
    throw ('NATIVE|HOLD|junction_guard_regression|exit='+$exitCode)
  }
} finally {
  if([IO.Directory]::Exists($junction)){
    [IO.Directory]::Delete($junction)
  }
  if([IO.Directory]::Exists($sandbox)){
    [IO.Directory]::Delete($sandbox)
  }
}
Write-Host ('NATIVE|PASS|OUTPUT_GUARD|CASES='+($bad.Count+1)+
  '|EQUAL_DESCENDANT_AND_EXTERNAL_JUNCTION')

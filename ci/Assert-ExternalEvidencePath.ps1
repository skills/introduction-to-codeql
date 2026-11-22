# SPDX-License-Identifier: 0BSD
# Reject lexical source containment and Windows reparse-point traversal.
# Does not promise race-free physical isolation or a hardware airgap.
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$RepositoryRoot,
  [Parameter(Mandatory=$true)][string]$EvidencePath
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
if(-not $IsWindows){throw 'EVIDENCE|HOLD|native_windows_required'}
$root=[IO.Path]::TrimEndingDirectorySeparator([IO.Path]::GetFullPath($RepositoryRoot))
$dest=[IO.Path]::TrimEndingDirectorySeparator([IO.Path]::GetFullPath($EvidencePath))
$prefix=$root
if(-not [IO.Path]::EndsInDirectorySeparator($prefix)){
  $prefix += [IO.Path]::DirectorySeparatorChar
}
if([string]::Equals($dest,$root,[StringComparison]::OrdinalIgnoreCase) -or
   $dest.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){
  throw 'EVIDENCE|HOLD|output_inside_source'
}
function Assert-NoJunctionAncestor([string]$fullPath,[string]$kind){
  $cursor=$fullPath
  while(-not [string]::IsNullOrWhiteSpace($cursor)){
    $entry=Get-Item -LiteralPath $cursor -Force -ErrorAction SilentlyContinue
    if($null -ne $entry -and
       ($entry.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0){
      throw ('EVIDENCE|HOLD|reparse_point_ancestor|'+$kind+'|'+$cursor)
    }
    $parent=[IO.Path]::GetDirectoryName($cursor)
    if([string]::IsNullOrWhiteSpace($parent) -or
       [string]::Equals($parent,$cursor,[StringComparison]::OrdinalIgnoreCase)){
      break
    }
    $cursor=$parent
  }
}
Assert-NoJunctionAncestor $root 'source'
Assert-NoJunctionAncestor $dest 'evidence'
Write-Host 'EVIDENCE|EXTERNAL_PATH_CHECK_PASS|NO_REPARSE_ANCESTORS|RELEASE=HOLD'

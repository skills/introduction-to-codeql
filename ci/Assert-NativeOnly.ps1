# SPDX-License-Identifier: 0BSD
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$RepositoryRoot)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$root=[IO.Path]::GetFullPath($RepositoryRoot)
$expected=@('CMakeLists.txt','src/bookstore.cpp','src/main.cpp','include/bookstore.hpp',
            'tests/bookstore_tests.cpp','LICENSE','LICENSES/0BSD.txt',
            'ci/Invoke-NativePipeline.ps1','ci/Test-HttpLoopback.ps1',
            'ci/Invoke-AtomixPipeline.ps1',
            'docs/ATOMIX_TRIFORCE_AUTOMATION.md',
            'research/SARIF-ATOMIX-Null-Hypothesis.md')
foreach($relative in $expected){
  if(-not [IO.File]::Exists((Join-Path $root $relative))){
    throw ('NATIVE|HOLD|missing_source|'+$relative)
  }
}
$files=@(Get-ChildItem -LiteralPath $root -Recurse -File -Force)
$bad=@($files | Where-Object {
  $_.Extension -match '^(?i:\.py|\.pyc|\.pyo|\.pyd)$' -or
  $_.Name -match '^(?i:Pipfile|Pipfile\.lock|requirements.*\.txt|poetry\.lock|setup\.py)$' -or
  $_.FullName -match '[/\\](?i:__pycache__|site-packages)[/\\]'
})
if($bad.Count -gt 0){
  throw ('NATIVE|HOLD|forbidden_interpreter_sources|'+
    (($bad|ForEach-Object {$_.FullName}) -join ';'))
}
$workflows=Join-Path $root '.github/workflows'
if(-not [IO.Directory]::Exists($workflows)){
  throw 'NATIVE|HOLD|workflows_missing'
}
foreach($item in Get-ChildItem -LiteralPath $workflows -File){
  if($item.Extension -notin @('.yml','.yaml')){continue}
  $text=[IO.File]::ReadAllText($item.FullName)
  if($text -match '(?im)^\s*uses\s*:' -or
     $text -match '(?i)\b(?:python(?:3)?|pip3?|node|npm|npx|flask)\b'){
    throw ('NATIVE|HOLD|workflow_runtime_forbidden|'+$item.Name)
  }
}
Write-Host ('NATIVE|SOURCE_POLICY_PASS|FILES='+$files.Count+'|NATIVE_CXX20')

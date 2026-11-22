# SPDX-License-Identifier: 0BSD
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$RepositoryRoot,
      [Parameter(Mandatory=$true)][string]$OutputDirectory,
      [switch]$SkipTests)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
if(-not $IsWindows){throw 'NATIVE|HOLD|MSVC_requires_Windows'}
# Normalize both roots before testing equality and containment.
$root=[IO.Path]::TrimEndingDirectorySeparator([IO.Path]::GetFullPath($RepositoryRoot))
$out=[IO.Path]::TrimEndingDirectorySeparator([IO.Path]::GetFullPath($OutputDirectory))
$prefix=$root
if(-not [IO.Path]::EndsInDirectorySeparator($prefix)){
  $prefix += [IO.Path]::DirectorySeparatorChar
}
if([string]::Equals($out,$root,[StringComparison]::OrdinalIgnoreCase) -or
   $out.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){
  throw 'NATIVE|HOLD|output_inside_source'
}
$env:MSBUILDDISABLENODEREUSE='1'
$env:DOTNET_CLI_DO_NOT_USE_MSBUILD_SERVER='1'
$baseline=$null
$sourcePaths=@('CMakeLists.txt','include/bookstore.hpp',
  'src/bookstore.cpp','src/main.cpp','tests/bookstore_tests.cpp',
  'ci/Assert-NativeOnly.ps1','ci/Invoke-NativePipeline.ps1',
  'ci/Test-HttpLoopback.ps1')
function Assert-Source([string]$operation,[string]$phase){
  $lines=[Collections.Generic.List[string]]::new()
  foreach($relative in $sourcePaths){
    $path=Join-Path $root $relative
    if(-not [IO.File]::Exists($path)){
      throw ('NATIVE|HOLD|missing_source|'+$relative)
    }
    $hash=(Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
    $lines.Add($relative+'='+$hash)
  }
  $bytes=[Text.Encoding]::UTF8.GetBytes(($lines -join [char]10))
  $digest=[Convert]::ToHexString(
    [Security.Cryptography.SHA256]::HashData($bytes)).ToLowerInvariant()
  if($null -eq $script:baseline){$script:baseline=$digest}
  if($digest -cne $script:baseline){
    throw ('NATIVE|HOLD|source_modified|'+$operation+'|'+$phase)
  }
  Write-Host ('NATIVE|'+$phase+'|OP='+$operation+'|SOURCE_SHA256='+$digest+
              '|RELEASE=HOLD')
}
function Invoke-Stage([string]$name,[scriptblock]$operation){
  Assert-Source $name 'HEAD'
  try{
    & $operation
    if($LASTEXITCODE -ne 0){
      throw ('NATIVE|HOLD|stage_exit|'+$name+'|'+$LASTEXITCODE)
    }
  }finally{
    Assert-Source $name 'TAIL'
  }
}
& pwsh -NoLogo -NoProfile -NonInteractive -File (Join-Path $root 'ci/Assert-NativeOnly.ps1') -RepositoryRoot $root
if($LASTEXITCODE -ne 0){throw 'NATIVE|HOLD|source_policy'}
Invoke-Stage 'configure' {
  & cmake -S $root -B $out -G 'Visual Studio 18 2026' -A x64 -DBUILD_TESTING=ON
}
Invoke-Stage 'build_o2' {
  & cmake --build $out --config Release --parallel 1 -- /m:1 /nr:false
}
if(-not $SkipTests){
  Invoke-Stage 'unit_tests' {
    & ctest --test-dir $out -C Release --output-on-failure --no-tests=error
  }
  Invoke-Stage 'http_loopback' {
    & pwsh -NoLogo -NoProfile -NonInteractive -File (Join-Path $root 'ci/Test-HttpLoopback.ps1') -Executable (Join-Path $out 'Release/bookstore.exe')
  }
}
Write-Host 'NATIVE|PASS|CXX20|MSVC|O2|RELEASE=HOLD'

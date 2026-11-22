# SPDX-License-Identifier: 0BSD
# ATOMIX: constrained Pinoy Half-Phiping experiment, with Q62 TRIFORCE witnesses.
# This source preserves the original PR #34 TRIFORCE as an external authority.
# No external uploads, runtime payload execution, or implied human approvals.
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$RepositoryRoot,
    [Parameter(Mandatory=$true)][string]$EvidenceDirectory
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
if(-not $IsWindows){throw 'ATOMIX|HOLD|native_Windows_required'}
$root=[IO.Path]::TrimEndingDirectorySeparator(
    [IO.Path]::GetFullPath($RepositoryRoot))
$evidence=[IO.Path]::TrimEndingDirectorySeparator(
    [IO.Path]::GetFullPath($EvidenceDirectory))
$prefix=$root
if(-not [IO.Path]::EndsInDirectorySeparator($prefix)){
    $prefix += [IO.Path]::DirectorySeparatorChar
}
if([string]::Equals($evidence,$root,[StringComparison]::OrdinalIgnoreCase) -or
   $evidence.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){
    throw 'ATOMIX|HOLD|evidence_inside_source'
}
if([IO.Directory]::Exists($evidence)){
    throw 'ATOMIX|HOLD|evidence_must_be_fresh'
}
$required=@(
    'CMakeLists.txt',
    'src/main.cpp',
    'src/bookstore.cpp',
    'ci/Invoke-NativePipeline.ps1',
    'ci/Invoke-AtomixPipeline.ps1',
    'ci/Assert-NativeOnly.ps1',
    'research/SARIF-ATOMIX-Null-Hypothesis.md',
    'docs/ATOMIX_TRIFORCE_AUTOMATION.md',
    '.github/workflows/native-cxx20.yml',
    '.github/workflows/codeql-cxx20.yml'
)
$sourceBaseline=$null
$phaseState='TAIL'
$phaseCount=0
# Exact Q62 record provenance: pentagonal-xor-cpp20 PR #34,
# commit 77aa28ba7d180a1e142736310aff13d61f2ef6b5.
# These are three *distinct records*, NOT independent human reviewers.
$witnesses=@(
    [pscustomobject]@{name='Euler';word='12535862302449814170';expected='271828182845904523'},
    [pscustomobject]@{name='Pi';word='14488038916154245685';expected='314159265358979323'},
    [pscustomobject]@{name='I';word='315868046760674477';expected='6849296450333523'}
)
$factor=[System.Numerics.BigInteger]::Parse('100000000000000000')
$divisor=[System.Numerics.BigInteger]::Pow(
    [System.Numerics.BigInteger]::Parse('2'),62)
$oneHundred=[System.Numerics.BigInteger]::Parse('100')
$utf8=[Text.UTF8Encoding]::new($false,$true)
function Assert-SourceAndTriforce([string]$operation,[string]$edge){
    foreach($relative in $required){
        if(-not [IO.File]::Exists((Join-Path $root $relative))){
            throw ('ATOMIX|HOLD|missing_source|'+$relative)
        }
    }
    # Full-tree source custody from the exact commit ZIP, matching the
    # intent of PR #34: required paths alone are NOT sufficient.
    $paths=[Collections.Generic.List[string]]::new()
    foreach($item in Get-ChildItem -LiteralPath $root -Recurse -File -Force){
        $relative=[IO.Path]::GetRelativePath($root,$item.FullName).Replace('\','/')
        if($relative.StartsWith('.git/',[StringComparison]::OrdinalIgnoreCase)){
            continue
        }
        if(($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0){
            throw ('ATOMIX|HOLD|source_reparse_point|'+$relative)
        }
        $paths.Add($relative)
    }
    $paths.Sort([StringComparer]::Ordinal)
    if($paths.Count -lt $required.Count){
        throw 'ATOMIX|HOLD|source_tree_incomplete'
    }
    $lines=[Collections.Generic.List[string]]::new()
    foreach($relative in $paths){
        $file=Join-Path $root $relative
        $digest=(Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLowerInvariant()
        $lines.Add($relative+'='+$digest)
    }
    $material=$utf8.GetBytes(($lines -join [char]10))
    $actual=[Convert]::ToHexString(
        [Security.Cryptography.SHA256]::HashData($material)).ToLowerInvariant()
    if($null -eq $script:sourceBaseline){$script:sourceBaseline=$actual}
    if($actual -cne $script:sourceBaseline){
        throw ('ATOMIX|HOLD|HEAD_TAIL_source_drift|'+$operation+'|'+$edge)
    }
    foreach($w in $witnesses){
        $sourceWord=[System.Numerics.BigInteger]::Parse($w.word)
        $product=[System.Numerics.BigInteger]::Multiply($sourceWord,$factor)
        $quotient=[System.Numerics.BigInteger]::Divide($product,$divisor)
        $remainder=[System.Numerics.BigInteger]::Remainder($product,$divisor)
        if($quotient.ToString() -cne $w.expected -or
           $remainder.Sign -lt 0 -or
           $remainder -ge $divisor -or
           [System.Numerics.BigInteger]::Remainder(
               $quotient,$oneHundred).ToString() -cne '23'){
            throw ('ATOMIX|HOLD|Q62_TRIFORCE_or_suffix23_mismatch|'+$w.name)
        }
    }
    Write-Host ('ATOMIX|'+$edge+'|OP='+$operation+
        '|MAGICCOMB_SHA256='+$actual+'|TRIFORCE_Q62_3_OF_3=PASS|RELEASE=HOLD')
}
function Get-Sha256([byte[]]$bytes){
    return [Convert]::ToHexString(
        [Security.Cryptography.SHA256]::HashData($bytes)).ToLowerInvariant()
}
# A phase-varying Unicode corpus is deliberately fixed by protocol ID.
# Nothing in this fixture is fed to a production API or rendered as markup.
$protocol='ATOMIX-PINOY-HALF-PHIPING-SARIF-001'
$phases=@(
    [pscustomobject]@{name='HEAD';marker='Σ-Euler-א'},
    [pscustomobject]@{name='AIRGAP';marker='π-Pi-ب'},
    [pscustomobject]@{name='TAIL';marker='I-Intensity-한'}
)
[void][IO.Directory]::CreateDirectory($evidence)
$records=[Collections.Generic.List[object]]::new()
for($index=0;$index -lt $phases.Count;$index++){
    $p=$phases[$index]
    $w=$witnesses[$index]
    Assert-SourceAndTriforce $p.name 'HEAD'
    if($phaseState -cne 'TAIL'){
        throw ('ATOMIX|HOLD|unpaired_phase|'+$p.name)
    }
    $phaseState='HEAD'
    try{
        # Exactly one ASCII bit is toggled in the UTF-8 JSON of a
        # *synthetic* SARIF finding containing adjacent real Unicode.
        # Controlled, varying strings model a Unicode-piping boundary.
        $message=$p.marker+'|ATOMIX:A:Q62='+$w.expected
        $sarif=[ordered]@{
            version='2.1.0'
            runs=@([ordered]@{
                tool=@{driver=@{name='AtomixOfflineFixture';version='1'}}
                results=@([ordered]@{
                    ruleId='ATOMIX/UNICODE_PIPE'
                    level='note'
                    message=@{text=$message}
                })
            })
        }
        $json=ConvertTo-Json -InputObject $sarif -Compress -Depth 24
        $sentinel='ATOMIX:A:'
        $charStart=$json.IndexOf($sentinel,[StringComparison]::Ordinal)
        if($charStart -lt 0 -or
           $json.IndexOf($sentinel,$charStart+1,
                         [StringComparison]::Ordinal) -ge 0){
            throw 'ATOMIX|HOLD|fixture_marker_not_unique'
        }
        $byteOffset=$utf8.GetByteCount($json.Substring(0,$charStart))+
            $utf8.GetByteCount('ATOMIX:')
        $original=$utf8.GetBytes($json)
        $test=[byte[]]::new($original.Length)
        [Array]::Copy($original,$test,$original.Length)
        if($original[$byteOffset] -ne 0x41){
            throw 'ATOMIX|HOLD|expected_A_ascii_at_offset'
        }
        $test[$byteOffset]=[byte]($test[$byteOffset] -bxor 0x01)
        $differenceCount=0
        foreach($byteIndex in 0..($original.Length-1)){
            if($original[$byteIndex] -ne $test[$byteIndex]){
                if($byteIndex -ne $byteOffset -or
                   ($original[$byteIndex] -bxor $test[$byteIndex]) -ne 1){
                    throw 'ATOMIX|HOLD|multi_bit_or_wrong_offset'
                }
                $differenceCount++
            }
        }
        if($differenceCount -ne 1 -or
           (($test[$byteOffset] -bxor 0x01) -ne $original[$byteOffset])){
            throw 'ATOMIX|HOLD|xor_one_bit_reversibility_failed'
        }
        # Strict UTF-8 decoding rejects illegal byte sequences; parsed
        # SARIF fields must remain stable except the one named sentinel.
        $originalParsed=ConvertFrom-Json -InputObject (
            $utf8.GetString($original)) -Depth 24
        $mutatedParsed=ConvertFrom-Json -InputObject (
            $utf8.GetString($test)) -Depth 24
        if($originalParsed.version -cne '2.1.0' -or
           $mutatedParsed.version -cne '2.1.0' -or
           @($mutatedParsed.runs).Count -ne 1 -or
           @($mutatedParsed.runs[0].results).Count -ne 1 -or
           $mutatedParsed.runs[0].results[0].ruleId -cne
                'ATOMIX/UNICODE_PIPE' -or
           $originalParsed.runs[0].results[0].message.text -cne $message -or
           $mutatedParsed.runs[0].results[0].message.text -cne
                $message.Replace('ATOMIX:A:','ATOMIX:@:')){
            throw ('ATOMIX|HOLD|SARIF_field_integrity_failed|'+$p.name)
        }
        $originalHash=Get-Sha256 $original
        $testHash=Get-Sha256 $test
        $record=[ordered]@{
            protocol=$protocol
            phase=$p.name
            witness=$w.name
            expected_q62=$w.expected
            source_ledger_sha256=$script:sourceBaseline
            sarif_version='2.1.0'
            original_sha256=$originalHash
            probe_sha256=$testHash
            utf8_byte_offset=$byteOffset
            xor_mask='0x01'
            changed_bit_count=1
            mutation_target='single_A_to_at_sign_sentinel'
            result='LOCAL_PASS'
            live_upload='FORBIDDEN'
            release='HOLD'
        }
        $records.Add([pscustomobject]$record)
        $evidencePath=Join-Path $evidence ($p.name.ToLowerInvariant()+'.json')
        [IO.File]::WriteAllText($evidencePath,
            ($record|ConvertTo-Json -Depth 8),
            [Text.UTF8Encoding]::new($false))
        Write-Host ('ATOMIX|'+$p.name+'|LOCAL_PROBE_PASS|BIT_COUNT=1'+
            '|ORIGINAL='+$originalHash+'|TEST='+$testHash)
    }finally{
        # No failure can silently skip TAIL or replace a fail with PASS.
        Assert-SourceAndTriforce $p.name 'TAIL'
        $phaseState='TAIL'
    }
    $phaseCount++
}
if($phaseCount -ne 3 -or $phaseState -cne 'TAIL' -or $records.Count -ne 3){
    throw 'ATOMIX|HOLD|incomplete_or_unpaired_triforce'
}
$audit=[ordered]@{
    schema='SWE-ATOMIX-TRIFORCE-LOCAL-v1'
    protocol=$protocol
    upstream_triforce_pr=34
    upstream_triforce_commit='77aa28ba7d180a1e142736310aff13d61f2ef6b5'
    source_commit=[string]$env:GITHUB_SHA
    source_ledger_sha256=$sourceBaseline
    stages=@($records.ToArray())
    actual_remote_sarif_testing='NONE'
    actual_GitHub_approval='NONE'
    airgap='logical_validation_boundary_not_physical_isolation'
    release='HOLD'
}
$auditPath=Join-Path $evidence 'atomix-audit.json'
[IO.File]::WriteAllText($auditPath,
    ($audit|ConvertTo-Json -Depth 12),
    [Text.UTF8Encoding]::new($false))
$auditHash=(Get-FileHash -LiteralPath $auditPath -Algorithm SHA256).Hash.ToLowerInvariant()
Write-Host ('ATOMIX|TRIFORCE|HEAD_AIRGAP_TAIL|MAGICCOMB_PASS'+
    '|THREE_Q62_WITNESSES|AUDIT_SHA256='+$auditHash+
    '|LOCAL_ONLY|RELEASE=HOLD')
Write-Host 'ATOMIX|AUDIT_JSON_BEGIN'
Write-Host ([IO.File]::ReadAllText($auditPath,[Text.Encoding]::UTF8))
Write-Host 'ATOMIX|AUDIT_JSON_END'

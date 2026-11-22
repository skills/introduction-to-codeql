# SPDX-License-Identifier: 0BSD
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$Executable)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
if(-not $IsWindows -or -not [IO.File]::Exists($Executable)){
  throw 'HTTP|HOLD|native_executable_missing'
}
$probe=[Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback,0)
$probe.Start()
$port=([Net.IPEndPoint]$probe.LocalEndpoint).Port
$probe.Stop()
$tmp=[IO.Path]::GetTempPath()
$stdout=Join-Path $tmp 'bookstore-slowheader-stdout.log'
$stderr=Join-Path $tmp 'bookstore-slowheader-stderr.log'
$server=Start-Process -FilePath $Executable -ArgumentList @('--port',[string]$port,'--max-requests','2') -PassThru -NoNewWindow -RedirectStandardOutput $stdout -RedirectStandardError $stderr
$slow=$null
$normal=$null
try{
  for($attempt=0;$attempt -lt 30;$attempt++){
    try{
      $slow=[Net.Sockets.TcpClient]::new('127.0.0.1',$port)
      break
    }catch{
      Start-Sleep -Milliseconds 100
    }
  }
  if($null -eq $slow){throw 'HTTP|HOLD|server_not_listening'}
  # Slow bytes keep resetting an ordinary per-recv timeout.
  $slowStream=$slow.GetStream()
  $slowStream.WriteByte([byte][char]'G')
  Start-Sleep -Milliseconds 2750
  $slowStream.WriteByte([byte][char]'E')
  Start-Sleep -Milliseconds 2750
  # The next valid client must not be starved after the 5s absolute limit.
  $normal=[Net.Sockets.TcpClient]::new('127.0.0.1',$port)
  $normalStream=$normal.GetStream()
  $normalStream.ReadTimeout=1900
  $crlf=[string][char]13+[string][char]10
  $request='GET /?name=The+Hobbit HTTP/1.1'+$crlf+'Host: 127.0.0.1'+$crlf+'Connection: close'+$crlf+$crlf
  $bytes=[Text.Encoding]::ASCII.GetBytes($request)
  $normalStream.Write($bytes,0,$bytes.Length)
  $memory=[IO.MemoryStream]::new()
  $chunk=[byte[]]::new(2048)
  while(($n=$normalStream.Read($chunk,0,$chunk.Length)) -gt 0){
    $memory.Write($chunk,0,$n)
    if($memory.Length -gt 32768){throw 'HTTP|HOLD|oversized_slow_response'}
  }
  $response=[Text.Encoding]::UTF8.GetString($memory.ToArray())
  if(-not $response.StartsWith('HTTP/1.1 200 OK',[StringComparison]::Ordinal) -or
     -not $response.Contains('The Hobbit',[StringComparison]::Ordinal)){
    throw 'HTTP|HOLD|slow_header_starved_valid_request'
  }
  if(-not $server.WaitForExit(5000)){throw 'HTTP|HOLD|server_did_not_exit'}
  if($server.ExitCode -ne 0){throw ('HTTP|HOLD|server_exit='+$server.ExitCode)}
  Write-Host 'HTTP|PASS|ABSOLUTE_HEADER_DEADLINE|SLOW_DRIP_AND_SECOND_CLIENT'
}finally{
  if($null -ne $slow){$slow.Dispose()}
  if($null -ne $normal){$normal.Dispose()}
  if(-not $server.HasExited){Stop-Process -Id $server.Id -Force -ErrorAction SilentlyContinue}
  $server.Dispose()
}

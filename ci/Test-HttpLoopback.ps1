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
$stdout=Join-Path $tmp 'bookstore-loopback-stdout.log'
$stderr=Join-Path $tmp 'bookstore-loopback-stderr.log'
$server=Start-Process -FilePath $Executable -ArgumentList @('--port',[string]$port,'--max-requests','1') -PassThru -NoNewWindow -RedirectStandardOutput $stdout -RedirectStandardError $stderr
try{
  $client=$null
  for($attempt=0;$attempt -lt 30;$attempt++){
    try{
      $client=[Net.Sockets.TcpClient]::new('127.0.0.1',$port)
      break
    }catch{
      Start-Sleep -Milliseconds 100
    }
  }
  if($null -eq $client){throw 'HTTP|HOLD|server_not_listening'}
  try{
    $stream=$client.GetStream()
    $stream.ReadTimeout=5000
    $crlf=[string][char]13+[string][char]10
    $text='GET /?name=The+Hobbit HTTP/1.1'+$crlf+'Host: 127.0.0.1'+$crlf+'Connection: close'+$crlf+$crlf
    $request=[Text.Encoding]::ASCII.GetBytes($text)
    $stream.Write($request,0,$request.Length)
    $memory=[IO.MemoryStream]::new()
    $chunk=[byte[]]::new(2048)
    while(($n=$stream.Read($chunk,0,$chunk.Length)) -gt 0){
      $memory.Write($chunk,0,$n)
      if($memory.Length -gt 32768){throw 'HTTP|HOLD|oversized_response'}
    }
    $reply=[Text.Encoding]::UTF8.GetString($memory.ToArray())
    if(-not $reply.StartsWith('HTTP/1.1 200 OK',[StringComparison]::Ordinal) -or
       -not $reply.Contains('The Hobbit',[StringComparison]::Ordinal) -or
       $reply.Contains('The Way of Kings',[StringComparison]::Ordinal)){
      throw 'HTTP|HOLD|unexpected_response'
    }
  }finally{
    $client.Dispose()
  }
  if(-not $server.WaitForExit(5000)){throw 'HTTP|HOLD|server_not_exited'}
  if($server.ExitCode -ne 0){throw ('HTTP|HOLD|exit='+$server.ExitCode)}
  Write-Host 'HTTP|PASS|LOOPBACK|FILTERED_BOOKS|WINSOCK2'
}finally{
  if(-not $server.HasExited){Stop-Process -Id $server.Id -Force -ErrorAction SilentlyContinue}
  $server.Dispose()
}

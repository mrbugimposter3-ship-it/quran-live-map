# Quran Live Map - tiny local server (no installs needed, works fully offline)
$ErrorActionPreference = "SilentlyContinue"
$port = 8123
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
if(-not $listener.IsListening){ Write-Output "port busy - server already running" }
else {
  $job = {
    param($listener,$root)
    $mime = @{".html"="text/html; charset=utf-8"; ".js"="text/javascript"; ".webmanifest"="application/manifest+json";
              ".png"="image/png"; ".jpg"="image/jpeg"; ".jpeg"="image/jpeg"; ".ico"="image/x-icon"; ".svg"="image/svg+xml"}
    while($listener.IsListening){
      $ctx = $listener.GetContext()
      $path = $ctx.Request.Url.AbsolutePath
      if($path -eq "/"){ $path = "/index.html" }
      $file = Join-Path $root ($path -replace "/","\")
      $ok = $file.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase) -and (Test-Path $file -PathType Leaf)
      if($ok){
        $bytes = [IO.File]::ReadAllBytes($file)
        $ext = [IO.Path]::GetExtension($file).ToLower()
        if($mime.ContainsKey($ext)){ $ctx.Response.ContentType = $mime[$ext] } else { $ctx.Response.ContentType = "application/octet-stream" }
        $ctx.Response.ContentLength64 = $bytes.Length
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
      } else { $ctx.Response.StatusCode = 404 }
      $ctx.Response.OutputStream.Close()
    }
  }
  Start-Job -ScriptBlock $job -ArgumentList $listener, $root | Out-Null
}

# open as a standalone app window (Edge preferred, then Chrome, then default browser)
$app = "http://localhost:$port/index.html"
$edge = Join-Path ${env:ProgramFiles(x86)} "Microsoft\Edge\Application\msedge.exe"
if(-not (Test-Path $edge)){ $edge = Join-Path $env:ProgramFiles "Microsoft\Edge\Application\msedge.exe" }
if(Test-Path $edge){ Start-Process $edge -ArgumentList "--app=$app" }
elseif(Get-Command chrome.exe -ErrorAction SilentlyContinue){ Start-Process "chrome.exe" -ArgumentList "--app=$app" }
else { Start-Process $app }

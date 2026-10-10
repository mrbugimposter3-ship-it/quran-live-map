@echo off
powershell -NoProfile -Command "Get-NetTCPConnection -LocalPort 8123 -State Listen -ErrorAction SilentlyContinue | ForEach-Object { Stop-Process -Id $_.OwningProcess -Force }"
echo server stopped (if it was running)
pause

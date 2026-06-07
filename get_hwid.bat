@echo off
setlocal enabledelayedexpansion


powershell -Command "$disk = (Get-WmiObject Win32_DiskDrive | Where-Object {$_.Index -eq 0}).SerialNumber; $board = (Get-WmiObject Win32_BaseBoard).SerialNumber; $mac = (Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | Select-Object -First 1).MacAddress; $raw = $disk + '_' + $board + '_' + $mac; $hash = [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($raw)); [System.BitConverter]::ToString($hash).Replace('-','').ToLower()" > %TEMP%\hwid.tmp

set /p HWID=<%TEMP%\hwid.tmp
del %TEMP%\hwid.tmp

echo ========================================
echo Your HWID: %HWID%
echo ========================================
echo.

echo %HWID% | clip
echo HWID copied!
echo.

pause

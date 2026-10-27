@echo off
setlocal
set "MAILPIT_EXE=%~dp0mailpit.exe"
if not exist "%MAILPIT_EXE%" set "MAILPIT_EXE=%~dp0mailpit-windows-amd64\mailpit.exe"
if not exist "%MAILPIT_EXE%" (
  echo mailpit.exe was not found in this project folder.
  echo Download the Windows binary and place it in the project folder.
  pause
  exit /b 1
)
echo Starting Mailpit on localhost only...
"%MAILPIT_EXE%" --smtp 127.0.0.1:1025 --listen 127.0.0.1:8025

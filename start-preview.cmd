@echo off
setlocal
cd /d "%~dp0"
if not exist "app\japan-life-guide.war" (
  echo Build output not found. See README.md for Eclipse or Maven instructions.
  pause
  exit /b 1
)
echo MINATO LIFE - preview only, not connected to Oracle.
echo Open http://localhost:8082/procedures after the application starts.
java -jar "app\japan-life-guide.war" --spring.profiles.active=preview --server.port=8082
pause

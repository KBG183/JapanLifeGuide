@echo off
setlocal
cd /d "%~dp0"
if not exist "config\application-local.properties" (
  echo Copy config\application-local.properties.example to application-local.properties.
  echo Fill in your Oracle connection settings. See README.md.
  pause
  exit /b 1
)
if not exist "app\japan-life-guide.war" (
  echo Build output not found. See README.md.
  pause
  exit /b 1
)
echo MINATO LIFE - Oracle mode. SQL scripts are NOT run automatically.
echo Open http://localhost:8082/procedures after the application starts.
java -jar "app\japan-life-guide.war" --spring.profiles.active=oracle,local
pause

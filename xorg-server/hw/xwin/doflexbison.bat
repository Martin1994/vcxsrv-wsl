@echo off
setlocal

cd "%~dp0"

bison.exe -d -o%1/winprefsyacc.c winprefsyacc.y

flex.exe -i -o%1/winprefslex.c winprefslex.l

endlocal


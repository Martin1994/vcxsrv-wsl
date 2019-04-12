@echo off

if "%1"=="nox86" goto skipx86

if exist vcxsrv.*.installer.exe del vcxsrv.*.installer.exe

copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x86\Microsoft.VC141.CRT\msvcp140.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x86\Microsoft.VC141.CRT\msvcp140_1.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x86\Microsoft.VC141.CRT\msvcp140_2.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x86\Microsoft.VC141.CRT\vcruntime140.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x86\Microsoft.VC141.DebugCRT\msvcp140d.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x86\Microsoft.VC141.DebugCRT\msvcp140_1d.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x86\Microsoft.VC141.DebugCRT\msvcp140_2d.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x86\Microsoft.VC141.DebugCRT\vcruntime140d.dll"

if exist "C:\Program Files (x86)\NSIS\makensis.exe" (
  "C:\Program Files (x86)\NSIS\makensis.exe" vcxsrv.nsi
  "C:\Program Files (x86)\NSIS\makensis.exe" vcxsrv-debug.nsi
) else (
  "C:\Program Files\NSIS\makensis.exe" vcxsrv.nsi
  "C:\Program Files\NSIS\makensis.exe" vcxsrv-debug.nsi
)

:skipx86
if "%1"=="nox64" goto skipx64

if exist vcxsrv-64.*.installer.exe del vcxsrv-64.*.installer.exe

copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x64\Microsoft.VC141.CRT\msvcp140.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x64\Microsoft.VC141.CRT\msvcp140_1.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x64\Microsoft.VC141.CRT\msvcp140_2.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\x64\Microsoft.VC141.CRT\vcruntime140.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x64\Microsoft.VC141.DebugCRT\msvcp140d.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x64\Microsoft.VC141.DebugCRT\msvcp140_1d.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x64\Microsoft.VC141.DebugCRT\msvcp140_2d.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Redist\MSVC\14.20.27508\debug_nonredist\x64\Microsoft.VC141.DebugCRT\vcruntime140d.dll"

if exist "C:\Program Files (x86)\NSIS\makensis.exe" (
  "C:\Program Files (x86)\NSIS\makensis.exe" vcxsrv-64.nsi
  "C:\Program Files (x86)\NSIS\makensis.exe" vcxsrv-64-debug.nsi
) else (
  "C:\Program Files\NSIS\makensis.exe" vcxsrv-64.nsi
  exit
  "C:\Program Files\NSIS\makensis.exe" vcxsrv-64-debug.nsi
)

:skipx64

del vcruntime140.dll
del vcruntime140d.dll
del msvcp140.dll
del msvcp140_1.dll
del msvcp140_2.dll
del msvcp140d.dll
del msvcp140_1d.dll
del msvcp140_2d.dll

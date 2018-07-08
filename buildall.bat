REM This is the entry of compiling.
REM Make sure you installed packages mentioned in building.txt.
REM Most of the packages should be installed on the windows side.
REM There are some checks in buildall.sh. You need to cheat them manually.

REM It is now hard-coded for 64-bit target. Change it as you need.

pushd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
call vcvarsall.bat amd64
set IS64=1
popd

REM Add your additional paths here
set PATH=%PATH%;C:\Users\Martin\AppData\Local\bin\NASM;C:\Users\Martin\dev\bison-3.0.4;%cd%\tools

set MHMAKECONF=%cd%

bash -c "./buildall.sh 1 4"

cd xorg-server/installer
./packageall.bat

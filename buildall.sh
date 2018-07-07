#!/bin/bash

if [[ "$1" == "1" ]] ; then
# source ./setenv.sh 1
IS64="1"
elif [[ "$1" == "0" ]] ; then
# source ./setenv.sh 0
IS64="0"
else
  echo "Please pass 1 (64-bit compilation) or 0 (32-bit compilation) as first argument"
  exit 
fi
if [[ "$2" == "" ]] ; then
  echo "Please pass number of parallel builds as second argument"
  exit 
fi

function check-error {
    if [ $? -ne 0 ]; then
        echo $1
        exit
    fi
}

which nasm > /dev/null 2>&1
check-error 'Please install nasm'

which MSBuild.exe > /dev/null 2>&1
check-error 'Please install/set environment for visual studio 2010'

which python.exe > /dev/null 2>&1
check-error 'Make sure that python.exe is in the PATH. (e.g. cp /usr/bin/python2.7.exe /usr/bin/python.exe)'

# # c:\perl should have a copy of strawberry perl portable edition
# which /cygdrive/c/perl/perl/bin/perl.exe > /dev/null 2>&1
# check-error 'Please install strawberry perl portable edition into c:\perl'
# ORIPATH=$PATH
# export PATH=/cygdrive/c/perl/perl/bin:$PATH
which perl.exe > /dev/null 2>&1
check-error 'Please install strawberry perl portable edition into c:\perl'

# echo script lines from now one
#set -v

if [[ "$IS64" == "1" ]]; then
MSBuild.exe freetype/freetypevc10.sln /t:Build /p:Configuration="Release Multithreaded" /p:Platform=x64
check-error 'Error compiling freetype'
MSBuild.exe freetype/freetypevc10.sln /t:Build /p:Configuration="Debug Multithreaded" /p:Platform=x64
check-error 'Error compiling freetype'
else
MSBuild.exe freetype/freetypevc10.sln /t:Build /p:Configuration="Release Multithreaded" /p:Platform=Win32
check-error 'Error compiling freetype'
MSBuild.exe freetype/freetypevc10.sln /t:Build /p:Configuration="Debug Multithreaded" /p:Platform=Win32
check-error 'Error compiling freetype'
fi

cd openssl

if [[ "$IS64" == "1" ]]; then

if [[ ! -d "release64" ]]; then
  mkdir release64
fi
cd release64

perl.exe ../Configure VC-WIN64A --release
else

if [[ ! -d "release32" ]]; then
  mkdir release32
fi
cd release32

perl.exe ../Configure VC-WIN32 --release
fi
check-error 'Error executing perl'

nmake.exe
check-error 'Error compiling openssl for release'

cd ..

if [[ "$IS64" == "1" ]]; then

if [[ ! -d "debug64" ]]; then
  mkdir debug64
fi
cd debug64

perl.exe ../Configure VC-WIN64A --debug

else

if [[ ! -d "debug32" ]]; then
  mkdir debug32
fi
cd debug32

perl.exe ../Configure VC-WIN32 --debug
fi
check-error 'Error executing perl'

nmake.exe
check-error 'Error compiling openssl for debug'

cd ../../pthreads
pwd
which nmake.exe
nmake.exe /f Makefile VC-static
check-error 'Error compiling pthreads for release'

nmake.exe /f Makefile VC-static-debug
check-error 'Error compiling pthreads for debug'

cd ..

#reuse the cygwin perl again
# export PATH=$ORIPATH

MSBuild.exe tools/mhmake/mhmakevc10.sln /t:Build /p:Configuration=Release /p:Platform=x64
check-error 'Error compiling mhmake for release'

export MHMAKECONF=`wslpath -wa .`

tools/mhmake/Release64/mhmake.exe -P$2 -C xorg-server MAKESERVER=1 DEBUG=1
check-error 'Error compiling vcxsrv for debug'

tools/mhmake/Release64/mhmake.exe -P$2 -C xorg-server MAKESERVER=1
check-error 'Error compiling vcxsrv for release'

# cd xorg-server/installer
# ./packageall.bat


#!/usr/bin/bash

export MSYS_NO_PATHCONV=1

if [[ "$1" == "1" ]] ; then
source ./setenv.sh 1
elif [[ "$1" == "0" ]] ; then
source ./setenv.sh 0
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
check-error 'Please install/set environment for visual studio 2019'
which python.exe > /dev/null 2>&1
check-error 'Make sure that python.exe is in the PATH. (e.g. cp /usr/bin/python2.7.exe /usr/bin/python.exe)'


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


cd pthreads
nmake VC-static
check-error 'Error compiling pthreads for release'

nmake VC-static-debug
check-error 'Error compiling pthreads for debug'

cd ..


if [[ "$IS64" == "1" ]]; then
	if [ ! -f tools/mhmake/Release64/mhmake.exe ]; then
		MSBuild.exe tools/mhmake/mhmakevc10.sln /t:Build /p:Configuration=Release /p:Platform=x64
		check-error 'Error compiling mhmake for release'

		MSBuild.exe tools/mhmake/mhmakevc10.sln /t:Build /p:Configuration=Debug /p:Platform=x64
		check-error 'Error compiling mhmake for debug'
	fi
	export MHMAKECONF=`cygpath -da .`

	tools/mhmake/Release64/mhmake -P$2 -C xorg-server MAKESERVER=1 DEBUG=1
	check-error 'Error compiling vcxsrv for debug'

	tools/mhmake/Release64/mhmake.exe -P$2 -C xorg-server MAKESERVER=1
	check-error 'Error compiling vcxsrv for release'

	cd xorg-server/installer
	./packageall.bat nox86
else
	if [ ! -f tools/mhmake/Release/mhmake.exe ]; then
		MSBuild.exe tools/mhmake/mhmakevc10.sln /t:Build /p:Configuration=Release /p:Platform=Win32
		check-error 'Error compiling mhmake for release'

		MSBuild.exe tools/mhmake/mhmakevc10.sln /t:Build /p:Configuration=Debug /p:Platform=Win32
		check-error 'Error compiling mhmake for debug'
	fi
	export MHMAKECONF=`cygpath -da .`

	tools/mhmake/Release/mhmake -P$2 -C xorg-server MAKESERVER=1 DEBUG=1
	check-error 'Error compiling vcxsrv for debug'

	tools/mhmake/Release/mhmake.exe -P$2 -C xorg-server MAKESERVER=1
	check-error 'Error compiling vcxsrv for release'

	cd xorg-server/installer
	./packageall.bat nox64
fi






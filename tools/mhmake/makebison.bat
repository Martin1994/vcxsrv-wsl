@echo off
setlocal

bison -d -ra -Ssrc/lalr1.cc -o%1/mhmakeparser.cpp src/mhmakeParser.y
python2 addstdafxh.py %1/mhmakeparser.cpp

endlocal

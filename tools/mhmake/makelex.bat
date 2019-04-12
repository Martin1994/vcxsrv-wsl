@echo off
setlocal

flex --nounistd -Ssrc/flex.skl -o%1/mhmakelexer.cpp src/mhmakelexer.l

python2 addstdafxh.py %1/mhmakelexer.cpp

endlocal


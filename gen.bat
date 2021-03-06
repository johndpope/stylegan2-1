@echo off
if "%1"=="" goto help

if "%2"=="" goto test
if "%2"=="1" goto test

python src/_genSGAN2.py --model models/%1 --out_dir _out/%~n1 --size %2 --frames %3 ^
%4 %5 %6 %7 %8 %9
goto ff

:test
python src/_genSGAN2.py --model models/%~n1.pkl --out_dir _out/%~n1 --size 1-1 --frames 200-20 ^
%3 %4 %5 %6 %7 %8 %9

:ff
ffmpeg -y -v warning -r 25 -i _out\%~n1\%%05d.jpg -c:v mjpeg -q:v 2 _out/%~n1-%2.avi
rem rmdir /s /q _out\%~n1

goto end


:help
echo Usage: _gen model x-y framecount-transit
echo e.g.:  _gen codex 1280-720 100-25

:end

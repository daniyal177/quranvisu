@echo off
setlocal

set FFMPEG="C:\ffmpeg-8.0.1-full_build\bin\ffmpeg.exe"
set INPUT="audios\C12_R1.m4a"
set OUTDIR="audios\C12_R1"

echo Creating output folder...
if not exist %OUTDIR% mkdir %OUTDIR%

echo.
echo Splitting audio...
echo.

%FFMPEG% -y -i %INPUT% -ss 4.617  -to 10.013 -c:a aac -b:a 192k -movflags +faststart %OUTDIR%\1_1.m4a
%FFMPEG% -y -i %INPUT% -ss 11.589 -to 15.649 -c:a aac -b:a 192k -movflags +faststart %OUTDIR%\1_2.m4a

echo.
echo Done ✅
pause

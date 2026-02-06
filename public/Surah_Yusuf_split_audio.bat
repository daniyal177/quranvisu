@echo off
setlocal enabledelayedexpansion

REM === Quran Viz Audio Splitter ===
REM Source: audios/C12_R1.mp3
REM Output folder: audios/C12_R1/
REM Format: m4a (AAC) bitrate=192k

set FFMPEG="C:\ffmpeg-8.0.1-full_build\bin\ffmpeg.exe"
if not exist %FFMPEG% (
  echo FFmpeg not found: %FFMPEG%
  pause
  exit /b 1
)

set SRC="audios\C12_R1.mp3"
if not exist %SRC% (
  echo Source audio not found: %SRC%
  echo TIP: Run this BAT from the folder where the relative path exists,
  echo or edit SRC to an absolute path.
  pause
  exit /b 1
)

if not exist "audios\C12_R1\" mkdir "audios\C12_R1\"

echo Splitting 1:1  (4.190 -> 10.057)
%FFMPEG% -hide_banner -y -i %SRC% -ss 4.190 -to 10.057 -c:a aac -b:a 192k "audios\C12_R1\C12_R1_1_1.m4a"

echo Splitting 1:2  (9.755 -> 15.433)
%FFMPEG% -hide_banner -y -i %SRC% -ss 9.755 -to 15.433 -c:a aac -b:a 192k "audios\C12_R1\C12_R1_1_2.m4a"

echo Splitting 2:1  (15.433 -> 24.236)
%FFMPEG% -hide_banner -y -i %SRC% -ss 15.433 -to 24.236 -c:a aac -b:a 192k "audios\C12_R1\C12_R1_2_1.m4a"

echo Splitting 2:2  (24.236 -> 28.544)
%FFMPEG% -hide_banner -y -i %SRC% -ss 24.236 -to 28.544 -c:a aac -b:a 192k "audios\C12_R1\C12_R1_2_2.m4a"

echo Done.
pause
endlocal
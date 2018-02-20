::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSTk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCWDJFuF4EE4PB5HWDiNLH+zC7wG7eH27u2CsQMYTOdf
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off 
title STYLUS - OPTIMIZE IMAGES

:: 1. Count the number of .tiff files found in current location
SETLOCAL EnableDelayedExpansion
SET IMCONV="%PROGRAMFILES%\ImageMagick-7.0.7-Q16\convert.exe"

:: Default file extension to look for
set fileext=jpg

IF "%~1"=="" GOTO :nextStep

set fileext=%1

:nextStep

echo Looking for .%fileext% files...

set /a count = 0
	 
set pattern = a?.txt :: we can get this as a parameter


::use dir /b %pattern% ^ | find /c /v ""

for %%a in (*.%fileext%) do set /a count+=1

echo I found %count% .%fileext% file(s)

:choice
set /P answer= Optimize the images found (Y/N)?
IF /I "%answer%" EQU "Y" GOTO :yeshandler
IF /I "%answer%" EQU "N" GOTO :nohandler

goto :wronginput

:wronginput
echo Wrong input. Please try again
goto :choice

:yeshandler
:: We will optimize the images here
echo Optimizing images...

:: Create the directory

FOR /D %%a in (*) DO (
   IF /i "%%~nxa"=="optimized" GOTO :folderexists ELSE GOTO :foldernotfound
) 

:foldernotfound
MD optimized

:folderexists
:: Scale the images
FOR %%a in (*.%fileext%) DO (

  ECHO Processing file: "%%~nxa"
  %IMCONV% %%a -resize 80%% "optimized/resized-%%~na.png"
)

goto :endoftests

:nohandler
echo Cancelling...
exit


:endoftests
echo The job is done.
endlocal
PAUSE







@ECHO off

if "%1"=="--help" goto helper
if "%1"=="-h" goto helper
if "%1"=="/?" goto helper
if "%1"=="" goto helper

set scrDir=%~dp0
set exts=%PATHEXT:;=";"%

:: Check in help
for /f %%f in ('help ^| findstr /b [a-Z] ') do (
	if /i [%1] == [%%f] (
		if exist "C:\Windows\system32\%1.*" (
			echo %1 is an external command
			echo Path to it: "C:\Windows\system32\%1"
			exit /b
		)

		echo Internal command
		exit /b
	)
)

:: Check in current dir without extensions
if exist "%scrDir%%~1" (
	echo "%1" is an executable file
	echo Path to it: "%scrDir%%1"
	exit /b
)

:: Check in current dir with extensions
for %%e in ("%exts%") do (
	if exist "%scrDir%%~1%%~e" (
		echo "%1%%~e" is an executable file
		echo Path to it: "%scrDir%%1%%~e"
		exit /b
	)
)

set paths=%PATH:;=";"%

:: Check in path without extensions
for %%p in ("%paths%") do (
	if exist "%%p\%1" (
		echo "%1" is an executable file
		echo Path to it: "%%~p\%1"
		exit /b
	)
)

:: Check in path with extensions
for %%p in ("%paths%") do (
	for %%e in ("%exts%") do (
		::echo In "%%p" looking for "%~1%%~e"
		if exist "%%~p\%~1%%~e" (
			if "%%~p"=="C:\Windows\system32" (
				echo "%1%%~e" is an external command
				echo Path to it: "%%~p\%1%%~e"
				exit /b
			)
			echo "%1" is an executable file
			echo Path to it: "%%~p\%1%%~e"
		) 
	)
)

echo Nothing was found

exit /b

:helper
	echo This program helps you know where to find some executables
	echo Type: locator [fileName]
	echo Where fileName is the file you want to get to
	echo.
	echo Print [-h or --help or /?] to get help
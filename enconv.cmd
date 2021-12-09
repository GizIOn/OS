@echo off
if "%1" == "/?" goto help
if "%1" == "-h" goto help
if "%1" == "--help" goto help
if "%1" == "" goto help	

if not exist "%1" (
	echo "%1" does not exist
	exit /b
)
FOR /R %1 %%f IN (*.txt) DO (
	set /A r=%RANDOM%
	echo %r%
	iconv.exe -f CP866 -t UTF-8 "%%f" > "%Temp%\%r%.txt"
	echo "%Temp%\%r%"
	xcopy /y "%Temp%\%r%.txt" "%%f" > nul 
	del /q "%Temp%\%r%.txt"
	)
exit /b
)
:help
	echo This program converts txt files from CP866 encoding to UTF-8 one
	echo This is how you (probably) called help:
	echo enconv.cmd [-h/--help] 
	echo This is how to use:
	echo enconv.cmd [dir]
	echo [dir] -- directory in which to change files
	exit /b
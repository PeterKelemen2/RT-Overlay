@echo off
setlocal

REM Query the registry and extract the install path
for /f "tokens=2,* delims=	 " %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Unwinder\RTSS" /v InstallPath 2^>nul') do (
    set "RTSSPath=%%B"
)

REM Debugging: Print the extracted path
echo Extracted RTSSPath: "%RTSSPath%"

REM Check if the path was found
if not defined RTSSPath (
    echo RTSS is not installed or path not found in registry.
    pause
    exit /b
)

REM Remove "RTSS.exe" from the path if present
for %%I in ("%RTSSPath%") do set "RTSSDir=%%~dpI"

REM Debugging: Print the extracted directory
echo Extracted RTSSDir: "%RTSSDir%"

REM Verify if the directory exists
if not exist "%RTSSDir%" (
    echo The extracted RTSS directory "%RTSSDir%" does not exist.
    pause
    exit /b
)

REM Copy the files to the correct directory
copy *.ovl "%RTSSDir%\Plugins\Client\Overlays\"

echo Files copied successfully to %RTSSDir%\Plugins\Client\Overlays\
pause

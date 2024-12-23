@echo off
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo 1. SMBIOS
echo.
for /f "skip=1" %%i in ('wmic csproduct get uuid') do (
    echo UUID: %%i
    goto :1
)
:1
for /f "skip=1" %%i in ('wmic bios get serialnumber') do (
    echo BIOS: %%i
    goto :2
)
:2
for /f "skip=1" %%i in ('wmic systemenclosure get serialnumber') do (
    echo Chassis: %%i
    goto :3
)
:3
for /f "skip=1" %%i in ('wmic baseboard get serialnumber') do (
    echo Baseboard: %%i
    goto :4
)
:4
echo.
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo 2. Drive Volumes
echo.
wmic logicaldisk get caption, volumeserialnumber
echo.
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
echo 3. Mac Address
echo.
for /f "skip=1 delims=" %%a in ('wmic nicconfig where "IPEnabled=true" get MACAddress^,IPAddress /format:list ^| findstr /r /v "^$"') do (
    echo %%a
    goto :5
)
:5
echo.
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
:loop
timeout /t 1 /nobreak >nul
goto :loop

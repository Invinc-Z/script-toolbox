@echo off
chcp 437 >nul
setlocal EnableDelayedExpansion

:: ================================
:: Admin check
:: ================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:: ================================
:: Get current hypervisorlaunchtype
:: ================================
set CURRENT=

for /f "tokens=2" %%i in ('
    bcdedit /enum {current} ^| findstr /i hypervisorlaunchtype
') do (
    set CURRENT=%%i
)

if not defined CURRENT (
    set CURRENT=Auto
)

:MENU
cls
echo ================================
echo  Hypervisor Launch Type Manager
echo ================================
echo.
echo Current state: %CURRENT%
echo.
echo 1. Toggle (Auto ^<^> Off)
echo 2. Set Auto  (Enable Hyper-V)
echo 3. Set Off   (Disable Hyper-V)
echo 4. Exit
echo.

set /p CHOICE=Select (1-4): 

if "%CHOICE%"=="1" goto TOGGLE
if "%CHOICE%"=="2" goto SET_AUTO
if "%CHOICE%"=="3" goto SET_OFF
if "%CHOICE%"=="4" goto END

echo Invalid selection.
timeout /t 1 >nul
goto MENU

:TOGGLE
if /i "%CURRENT%"=="Auto" (
    set NEW=off
) else (
    set NEW=auto
)
goto APPLY

:SET_AUTO
set NEW=auto
goto APPLY

:SET_OFF
set NEW=off
goto APPLY

:APPLY
echo.
echo Setting hypervisorlaunchtype to %NEW% ...
bcdedit /set hypervisorlaunchtype %NEW%
if errorlevel 1 (
    echo Failed to update hypervisorlaunchtype.
    pause
    exit /b 1
)

set CURRENT=%NEW%

echo.
set /p REBOOT=Reboot now? (Y/N): 
if /i "%REBOOT%"=="Y" (
    shutdown /r /t 0
)

goto MENU

:END
exit /b 0

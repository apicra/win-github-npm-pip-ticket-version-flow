:: .apicra\.apicra.bat %~1
@echo off
:: Variables
set PARAM=%~1
set OS=win
set APICRA_PATH=.apicra
set CMD=.apicra.bat
set MODULE=Apicra
:: get Variable from File
IF "%PARAM%"=="" GOTO help
::::::::::::::
:: config
if "%PARAM%"=="c" GOTO config
if "%PARAM%"=="config" GOTO config
:: install
if "%PARAM%"=="i" GOTO install
if "%PARAM%"=="install" GOTO install
:: reinstall
if "%PARAM%"=="r" GOTO reinstall
if "%PARAM%"=="reinstall" GOTO reinstall
:: delete
if "%PARAM%"=="d" GOTO delete
if "%PARAM%"=="delete" GOTO delete
:: update
if "%PARAM%"=="u" GOTO update
if "%PARAM%"=="update" GOTO update
::::::::::::::
:help
echo %CMD% exist
echo %CMD% config
echo %CMD% install
echo %CMD% reinstall
echo %CMD% delete
GOTO end
::::::::::::::
:exist
IF EXIST ".apicra" (
    ECHO true
) ELSE (
    ECHO false
)
GOTO end
::::::::::::::
:reinstall
RMDIR /Q/S .apicra && echo %MODULE% folder is deleted
del /f apicra.txt && echo %MODULE% config file is deleted
GOTO install
::::::::::::::
:install
IF EXIST %APICRA_PATH% (
    ECHO %MODULE% exist
    GOTO help
)
git clone https://github.com/apicra/npm-github-win.git .apicra && echo %MODULE% is installed
GOTO config
::::::::::::::
:config
echo github > apicra.txt
GOTO end
::::::::::::::
:update
git -C .apicra pull origin master && echo %MODULE% is updated
GOTO end
::::::::::::::
:delete
IF NOT EXIST %APICRA_PATH% (
    ECHO Apicra not exist
    GOTO help
)
RMDIR /Q/S .apicra && echo %MODULE% folder is deleted
del /f apicra.txt && echo %MODULE% config file is deleted
GOTO end
::::::::::::::
:end

::::::::::::::::::::::::::::::::::::::::::
:: manager for apicra, gitst on github  ::
:: author: Tom Sapletta                 ::
:: url: https://apicra.com/             ::
::::::::::::::::::::::::::::::::::::::::::
@echo off
:: Variables
set PARAM=%~1
set MODULE=%~2
set OS=win
set APICRA_PATH=.apicra
set CMD=.apicra.bat
set NAME=Apicra
set APICRA_CONFIG=apicra.txt
:: get Variable from File
IF "%PARAM%"=="" GOTO help
::
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
::
:help
echo %CMD% exist
echo %CMD% config
echo %CMD% install
echo %CMD% install "modulname"
echo %CMD% reinstall
echo %CMD% delete
echo %CMD% delete "modulname"
GOTO end
::
:exist
IF EXIST ".apicra" (
    ECHO true
) ELSE (
    ECHO false
)
GOTO end
::
:reinstall
echo :: "Do you really want delete the whole apicra modules and projects?
RMDIR /Q/S .apicra && echo :: %NAME% folder is deleted
del /f apicra.txt && echo :: %NAME% config file is deleted
GOTO install
::
:install
echo ::
echo :: Apicra :: Install
echo ::
IF NOT "%MODULE%"=="" GOTO install_module
IF EXIST %APICRA_PATH% (
    IF EXIST %APICRA_CONFIG% GOTO install_module_from_config
    GOTO help
)
::mkdir .apicra
echo .apicra/ >> .gitignore
git clone https://github.com/apicra/npm-github-win.git .apicra && echo :: %NAME% is installed
IF EXIST %APICRA_CONFIG% (
    echo :: Install All modules from config file %APICRA_CONFIG%
    GOTO install_module_from_config
) ELSE (
    GOTO config
)
::
:install_module
.apicra\-module.bat install %MODULE%
GOTO end
::
:install_module_from_config
echo ::
echo :: Apicra :: Install modules from config file
echo ::
for /f "delims==" %%a in (%APICRA_CONFIG%) do .apicra\-module.bat install %%a
GOTO end
::
:config
IF EXIST %APICRA_CONFIG% GOTO end
echo github > %APICRA_CONFIG% && echo :: apicra.txt config file is created
GOTO end
::
:update
git -C .apicra pull origin master && echo :: %NAME% is updated
GOTO end
::
:download_power
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/tom-sapletta-com/do/master/install.bat -OutFile install.bat"
GOTO end
::
:download_curl
.apicra/curl
GOTO end
::
:delete
echo ::
echo :: Apicra :: Delete
echo ::
IF NOT "%MODULE%"=="" GOTO delete_module
IF NOT EXIST %APICRA_PATH% (
    echo :: Apicra not exist
    GOTO help
)
echo "Do you really wan't delete the whole apicra modules and projects?
pause
RMDIR /Q/S .apicra && echo %NAME% folder is deleted
::del /f apicra.txt && echo %NAME% config file is deleted
GOTO end
::
:delete_module
.apicra/-module.bat delete %MODULE%
GOTO end
::
:end

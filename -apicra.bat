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
RMDIR /Q/S %APICRA_PATH% && echo :: %NAME% :: %APICRA_PATH% :: Folder is deleted
del /f %APICRA_CONFIG% && echo :: %NAME% :: %APICRA_CONFIG%  :: Config file is deleted
GOTO install
::
:install
echo ::
echo :: Apicra :: Install
IF NOT "%MODULE%"=="" GOTO install_module_shortcut
IF EXIST %APICRA_PATH% (
    IF EXIST %APICRA_CONFIG% GOTO install_module_from_config
    echo :: %NAME% :: Path not exist
    GOTO help
)
::mkdir .apicra
echo .apicra/ >> .gitignore
git clone https://github.com/apicra/npm-github-win.git .apicra && echo :: %NAME% :: is installed
IF EXIST %APICRA_CONFIG% (
    echo :: %NAME% :: Installation of all modules from config file %APICRA_CONFIG%
    GOTO install_module_from_config
) ELSE (
    echo :: %NAME% :: Config not exist
    GOTO config
)
::
:: script to use in root tree of project as module shortcut, e.g: -github.bat, -ticket.bat, -version.bat
:: Install for defined module or for all
:: if no params then all modules shortcuts
:: if param then current
:install_module_shortcut
echo ::
IF EXIST -%MODULE%.bat (
echo :: %NAME% :: %MODULE% :: Module shortcut is Not Created, because existed ::
) ELSE (
echo :: %NAME% :: %MODULE% :: Module shortcut is Created ::
echo @echo off > -%MODULE%.bat
echo .apicra\-project.bat %MODULE% %%1 %%2 %%3 >> -%MODULE%.bat
)
GOTO install_module
::
:delete_module_shortcut
echo ::
echo :: %NAME% :: %MODULE% :: module shortcut is deleted ::
del -%MODULE%.bat
GOTO delete_module
::
:update_shortcut
echo ::
:: Install for defined module or for all
GOTO end
::
:install_module
echo ::
IF EXIST .apicra\module\%MODULE% (
echo :: %NAME% :: %MODULE% :: Module is Existing
GOTO end
)
.apicra\-module.bat install %MODULE%
GOTO install_shortcut
::
:install_module_from_config
echo ::
echo :: %NAME% :: %MODULE% :: Install modules from config file
for /f "delims==" %%a in (%APICRA_CONFIG%) do .apicra\-module.bat install %%a
GOTO install_shortcut
::
:config
echo ::
IF EXIST %APICRA_CONFIG% GOTO end
echo github > %APICRA_CONFIG% && echo :: %NAME% :: %MODULE% :: apicra.txt config file is created
GOTO end
::
:update
echo ::
git -C .apicra pull origin master && echo %NAME% :: %MODULE% :: %NAME% is updated
GOTO end
::
:download_power
echo ::
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/tom-sapletta-com/do/master/install.bat -OutFile install.bat"
GOTO end
::
:download_curl
echo ::
.apicra/curl
GOTO end
::
:delete
echo ::
echo :: %NAME% :: %MODULE% :: Deleting Module
IF NOT "%MODULE%"=="" GOTO delete_module_shortcut
IF NOT EXIST %APICRA_PATH% (
    echo :: %NAME% :: %APICRA_PATH% :: Path not exist
    GOTO help
)
echo "Do you really wan't delete the whole apicra modules and projects?
pause
RMDIR /Q/S .apicra && echo %NAME% :: %MODULE% :: folder is deleted ::
::del /f apicra.txt && echo %NAME% config file is deleted
GOTO end
::
:delete_module
echo ::
.apicra/-module.bat delete %MODULE%
GOTO end
::
:end

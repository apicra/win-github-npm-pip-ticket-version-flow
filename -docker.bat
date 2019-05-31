@echo off
set PARAM=%1
:: Exist
if "%PARAM%"=="e" GOTO exist
if "%PARAM%"=="exist" GOTO exist
:: Create
if "%PARAM%"=="c" GOTO create
if "%PARAM%"=="create" GOTO create
:: Delete
if "%PARAM%"=="d" GOTO delete
if "%PARAM%"=="delete" GOTO delete
:: Variables
set CMD=-docker.bat
:: get Variable from File
IF EXIST ".apicra\variable\DOCKER-NAME.txt" (
    set DOCKER_NAME = < .apicra\variable\DOCKER-NAME.txt
) ELSE (
    ECHO Variable file: '.apicra\variable\DOCKER-NAME.txt' not found
)

::::::::::::::
:help
echo "Params: exist, name"
echo "Params & Variables: create, delete"
echo Example:
echo %CMD% exist
echo %CMD% name
echo %CMD% create "username" "projectname"
echo %CMD% delete "username" "projectname"
echo projectname
echo projectname
GOTO end
::::::::::::::
:exist
echo true
GOTO end
::::::::::::::
:create
.apicra\-project-create.bat %GIT_USER% %PROJECT%
echo projectname is created
::set GIT_USER=%~2
::set PROJECT=%~3
GOTO end
::::::::::::::
:delete
echo projectname is deleted
::set GIT_USER=%~2
::set PROJECT=%~3
GOTO end
:end

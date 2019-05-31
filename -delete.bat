@echo off
IF [%1]==[] (
GOTO sub_message
) ELSE (
xcopy %1 E:\backupfolder
)
:: END
GOTO eof
:sub_message
:: IF NOT PARAM
echo You can delete:
if -docker.bat exist
echo docker:

:eof
::set GIT_USER=%~1
::set PROJECT=%~2
::.apicra\-project-delete.bat %GIT_USER% %PROJECT%

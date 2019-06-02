@echo off
::.apicra\-module.bat project-github-npmjs %~1 %~2 %~3 %~4
::.apicra\-project.bat project-github-npmjs %~1 %~2 %~3 %~4
.apicra\module\project-github-npmjs\publish.bat %~3 %~4

# apicra/win-github-npm-pip-ticket-version-flow
For using this project we need to include project Apicra GITHUB NPM

https://github.com/apicra/npm-github-win.git

## Cele projektu
+ minimalizacja liczby kroków
+ autonomiczne moduły
+ małe projekty z dokumentacją dotyczącą zawrtych w kodzie funkcjonalności, zamiast duże z ogólną dokumentacją


## Narzędzia

obecne narzędzie .Apicra oraz flow dla npmjs:
https://github.com/apicra/win-ticket-version-flow

niniejsza wersja jest otwarta na rozbudowę, dlatego każdy skrypt ma dwie funkcje:
informację o stanie obecnym


| command | local files | remote github | remote NPMJS |
| --- | --- | --- | --- |
| -docker.bat | create | create | --- |
| -npmjs.bat | --- | push, tag | create |
| **-ticket.bat** | --- | **push** | --- |
| **-version.bat** | --- | **tag** | **update** |
| -delete.bat | delete | delete | delete |


## Budowanie Api

Ostatnie poszukiwania i testy przyniosły takie wnioski:

npm jest bardzo popularny w webdev nawet bardziej niż python z uwagi na JAVASCRIPT

Wadą JS jest brak silnego typowania, które uzupełnia TypeScript

Python zapewnia silne typowanie dzięki czemu budowanie API na nim jest w sposób naturalny łatwe, gdyż
przy tworzeniu dokumentacji API konieczne jest typowanie.

Mój wybór padł na bibliotekę FastApi bazująca na języku python
W chwili obecnej tworzę wsparcie dla środowiska python dla narzędzia .apicra

## Efekt powinien być taki, by w krótkim czasie przygotować:

### API
routing w python

### backend
Logikę Python

### frontend
UI przy uzyciu frameworka Vue
korzystającego z API


## Instalacja w bieżącym projekcie

    git clone https://github.com/apicra/win-github-npm-pip-ticket-version-flow.git apicra
    
eventually move from apicra to the main folder

### lub manualne dodanie .apicra
Create
    git clone https://github.com/apicra/npm-github-win.git .apicra

Delete
    RMDIR /Q/S .apicra

### apicra.json


here all all modules, installed after .apicra ist downloaded over script


-apicra.bat init


## Test
install

    -apicra.bat install project-github-npmjs

publish version on github

    -github.bat publish

publish version on nmpjs

    -npmjs.bat publish

publish project on nmpjs & github

    -project.bat publish


## github

    -github.bat push

# dot-no-back: Mjukvarelaugets backend

## Installasjon
Installer haskell-platformen. På Ubuntu gjøres det vha
```
sudo apt-get install haskell-platform
```

Deretter må tjenestene initialiseres ved å skrive
``` 
git submodule update --init --recursive
```

Tjenestene holdes oppdatert med komandoen
```
git submodule update --remote --merge
```

## Bygging
Kjør `cabal build` for å bygge. Dette lager en kjørbar fil som heter `dot-no-back`. `cabal run` kjører prosjektet.

## Håndtere tjenester
Tjenester ligger i mappa `services` og importeres som submoduler i git. 
For å oppdatere submodulene (tjenestene) i tillegg til hovedprosjektet (haskellserveren) må man skrive `git submodule update --remote --merge`. 

Submoduler er beskrevet i detalj her: https://git-scm.com/book/en/v2/Git-Tools-Submodules

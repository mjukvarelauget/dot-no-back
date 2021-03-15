# dot-no-back: Mjukvarelaugets backend

## Installasjon
Installer haskell-platformen. På Ubuntu gjøres det vha
´sudo apt-get install haskell-platform´


## Bygging
Kjør ´cabal build´ for å bygge. Dette lager en kjørbar fil som heter ´dot-no-back´

## Håndtere tjenester
Tjenester ligger i mappa `services` og importeres som submoduler i git. Dette betyr at for å hente en tjenste inn i repoet må man navigere til hver enkelt tjeneste, f.eks badhaiku, og skrive `git submodule init` og `git submodule update` for å hente den nyeste versjonen av tjenesten.

For å oppdatere submodulene (tjenestene) i tillegg til hovedprosjektet (haskellserveren) må man skrive `git submodule update --init --recursive` etter å ha kjørt `git pull` 

Submoduler er beskrevet i detalj her: https://git-scm.com/book/en/v2/Git-Tools-Submodules
# Server

Dieser Ordner enthält den Gleam-HTTP-Prototyp für die Studienarbeit. Er verwendet
Wisp und Mist und stellt derzeit Todo-Routen ohne Datenspeicherung bereit.

## Voraussetzungen

Benötigt werden Gleam und Erlang/OTP. Unter macOS:

```sh
brew install gleam erlang
```

## Starten

Im Ordner `server/` ausführen:

```sh
gleam deps download
gleam run
```

Der Server ist unter <http://localhost:8080/todos> erreichbar. Zum Beenden
im Terminal `Ctrl+C` drücken.

## Entwicklung

```sh
gleam format --check src test
gleam test
gleam build
```

Die Testsuite enthält bislang einen einfachen Beispieltest.
Weitere Informationen zu den HTTP-Routen, zur Projektstruktur und zum Wiki
stehen im [README des Repositorys](../README.md).

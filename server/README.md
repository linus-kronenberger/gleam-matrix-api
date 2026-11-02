# Server

Voraussetzungen: Gleam 1.19 oder neuer und Erlang/OTP 29 oder neuer für Debugging.
Unter macOS lassen sich beide mit Homebrew installieren:

```sh
brew install gleam erlang
```

## Start im Terminal

```sh
cd server
gleam run --target erlang --module server
```

Der Server ist unter <http://localhost:8080/todos> erreichbar. Mit `Ctrl+C` beenden.

## VS Code

Den Repository-Hauptordner in VS Code öffnen und die empfohlenen Erweiterungen
**Gleam** und **Erlang Language Platform** installieren. Letztere enthält den
EDB-Debugger. `gleam` und `erl` müssen im `PATH` von VS Code verfügbar sein.
Die Konfiguration bevorzugt die üblichen Homebrew-Verzeichnisse für die Tools.

Bei **Erlang Language Platform 0.54.0** vor dem ersten Debug-Start einmal
über die Befehlspalette **Erlang: Restart server** ausführen. Diese Version
aktiviert den Debug-Adapter nicht automatisch beim Start aus einer Gleam-Datei.
Der Befehl lädt die Erweiterung und registriert den Adapter für `F5`.

- **Starten:** `Terminal → Task ausführen → Gleam: Server starten`.
- **Debuggen:** Einen Breakpoint in `src/server.gleam` setzen, unter
  „Ausführen und Debuggen“ **Gleam: Server debuggen** auswählen und `F5` drücken.
  Der Server läuft im integrierten Terminal.
- Zum Prüfen eines Request-Breakpoints beispielsweise die Zeile mit
  `wisp.string_body(wisp.ok(), "Todo item " <> id)` markieren und
  <http://localhost:8080/todos/1> aufrufen. Variablen und Aufrufstack erscheinen
  im Debug-Bereich; `F10` führt den nächsten Schritt aus, `F5` setzt fort.
- **Debugging beenden:** `Shift+F5`. Einen zuvor regulär gestarteten Server
  vor dem Debuggen beenden, damit Port 8080 frei ist.

Vor jedem Debug-Start wird der Build bereinigt und mit
`debug_info`, `beam_debug_info` und `beam_debug_stack` neu erstellt.
So werden auch bereits kompilierte Module mit Debug-Informationen versehen.
Ein kleines Escript ergänzt die Quellpfade der eigenen Module für den
Aufrufstack und die Navigation zu Gleam-Dateien.
Der Debugger startet anschließend den gebauten Server direkt mit Erlang,
damit er sich nicht mit einem Compiler-Prozess von `gleam run` verbindet.
Die Breakpoint-Einstellung erlaubt Breakpoints in Gleam-Dateien, da die
Erlang-Erweiterung standardmäßig nur Erlang-Dateien dafür registriert.

## Tests

```sh
gleam format --check src test
gleam test
gleam build
```

Die Testsuite enthält bislang einen einfachen Beispieltest.
Weitere Informationen zu den HTTP-Routen, zur Projektstruktur und zum Wiki
stehen im [README des Repositorys](../README.md).

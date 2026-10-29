# Studienarbeit: Matrix-Server in Gleam

Dieses Repository enthält den praktischen und schriftlichen Teil der Studienarbeit
**„Vergleichende Implementierung eines Matrix-Servers in Gleam“** an der
DHBW Karlsruhe. Die Arbeit wird von Linus Kronenberger und Tom Lennert Sroka
verfasst.

Im Mittelpunkt steht die Implementierung eines Servers für das
[Matrix-Protokoll](https://spec.matrix.org/) mit
[Gleam](https://gleam.run/), einer statisch typisierten Sprache, die unter anderem
auf der Erlang-Laufzeit ausgeführt wird. Die schriftliche Ausarbeitung entsteht
mit [Typst](https://typst.app/).

## Aktueller Stand

Das Projekt befindet sich im Aufbau. Unter `server/` liegt ein HTTP-Prototyp auf
Basis von **Wisp** und **Mist**. Er stellt einfache Todo-Routen bereit, die als
Ausgangspunkt für die weitere Serverentwicklung dienen. Die Antworten sind
Platzhalter; Todo-Daten werden noch nicht gespeichert. Matrix-Endpunkte sind
noch nicht implementiert. Auch die Ausarbeitung unter `thesis/` ist in Arbeit.

## Wiki

Unser Wiki ist die Anlaufstelle für weiterführende Dokumentation zur Studienarbeit.

**Wiki-Link: TODO – hier ergänzen.**

<!-- TODO: Sobald die URL feststeht, den Platzhalter durch [Zum Projekt-Wiki](URL) ersetzen. -->

## Ordnerstruktur

```text
.
├── README.md                   # Projektüberblick und Einstieg
├── AGENTS.md                   # Repo-Anweisungen für Codex, einschließlich Sprache
├── server/                     # Gleam-Projekt für den Server
│   ├── gleam.toml              # Projektkonfiguration und Abhängigkeiten
│   ├── manifest.toml           # Aufgelöste Abhängigkeitsversionen
│   ├── README.md               # Lokale Hinweise zum Serverprojekt
│   ├── src/
│   │   └── server.gleam        # Einstiegspunkt, Middleware und HTTP-Routen
│   └── test/
│       └── server_test.gleam   # Tests mit Gleeunit
└── thesis/                     # Schriftliche Ausarbeitung in Typst
    ├── main.typ                # Hauptdokument und Konfiguration der Vorlage
    ├── glossary.typ            # Glossareinträge
    ├── sources.bib             # Literaturverzeichnis
    └── assets/                 # Abbildungen und Referenzmaterial
        └── diagrams/           # Diagramme für die Ausarbeitung
```

## Server lokal starten

Benötigt werden **Gleam** und **Erlang/OTP**. Unter macOS können beide mit
Homebrew installiert werden:

```sh
brew install gleam erlang
```

Vom Repository-Hauptordner aus:

```sh
cd server
gleam deps download
gleam run
```

Der Server lauscht auf Port **8080**. In einem zweiten Terminal lässt sich der
Prototyp aufrufen:

```sh
curl http://localhost:8080/todos
curl http://localhost:8080/todos/1
```

Die Antworten lauten derzeit `Todo items` beziehungsweise `Todo item 1`.

| Methode | Pfad | Aktuelles Verhalten |
| --- | --- | --- |
| `GET` | `/todos` | Platzhaltertext mit Status `200` |
| `POST` | `/todos` | Status `201`, ohne Speicherung |
| `GET` | `/todos/:id` | Platzhaltertext mit der angegebenen ID, Status `200` |
| `DELETE` | `/todos/:id` | Status `204`, ohne Änderung von Daten |

Andere Pfade liefern `404`; nicht unterstützte Methoden auf den Todo-Routen
liefern `405`. Zum Beenden im Server-Terminal `Ctrl+C` drücken.

Optional liest der Server die Umgebungsvariable `SECRET_KEY_BASE` für Wisp ein.
Ohne diese Variable nutzt der aktuelle Prototyp den im Quellcode hinterlegten
Fallback.

## Entwicklung

Die folgenden Befehle werden im Ordner `server/` ausgeführt:

```sh
gleam format --check src test
gleam test
gleam build
```

Die vorhandene Testsuite enthält derzeit einen einfachen Gleeunit-Beispieltest;
die HTTP-Routen werden damit noch nicht geprüft.

## Studienarbeit erstellen

Für die Ausarbeitung wird zusätzlich die Typst-CLI benötigt. Unter macOS:

```sh
brew install typst
```

Vom Repository-Hauptordner aus kann die PDF erstellt werden:

```sh
typst compile thesis/main.typ thesis/main.pdf
```

Für eine automatische Neuerstellung beim Bearbeiten:

```sh
typst watch thesis/main.typ thesis/main.pdf
```

Die Ausarbeitung verwendet die Vorlage
[`clean-dhbw` in Version 0.6.0](https://typst.app/universe/package/clean-dhbw/0.6.0/).
Beim ersten Build benötigt Typst Internetzugriff zum Laden der Vorlage und ihrer
Abhängigkeiten. PDF-Dateien werden im Repository über **Git LFS** verwaltet;
zum vollständigen Abrufen der vorhandenen PDF-Dateien muss Git LFS installiert
und mit `git lfs install` eingerichtet sein. Anschließend lädt `git lfs pull`
die Dateien.

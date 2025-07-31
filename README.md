# Leicht Erlernen - German Learning App

Eine benutzerfreundliche App zum Deutschlernen mit vielfältigen Funktionen.

## ⚠️ Wichtiger Hinweis

**Bevor Sie die App starten, müssen Sie die Ordner in `assets/App-data` umbenennen:**

```
Hörtexte → Hoertexte
Übungsaudios → Uebungsaudios
```

Siehe `RENAME_INSTRUCTIONS.md` für detaillierte Anweisungen.

## 🎯 Hauptfunktionen

- **Lektionenliste**: 20 Deutschlektionen für Anfänger
- **Audioplayer**: Echte Audio-Dateien für jede Lektion
- **eBook**: Echte PDF-Dateien der Lektionen anzeigen
- **Vielfältige Inhalte**: Vokabellisten, Hörbeispiele, Übungen
- **Schöne Benutzeroberfläche**: Design genau wie gewünscht

## 📱 App-Struktur

```
lib/
├── main.dart                 # Einstiegspunkt
├── services/
│   ├── assets_service.dart   # Verwaltung von Assets
│   └── audio_service.dart    # Audio-Wiedergabe
└── screens/
    ├── lesson_list_screen.dart      # Lektionenliste
    ├── lesson_detail_screen.dart    # Lektionsdetails
    ├── lesson_content_screen.dart   # Lektionsinhalt
    └── simple_pdf_viewer.dart       # PDF-Viewer
```

## 🚀 Installation und Ausführung

### Systemanforderungen
- Flutter SDK (Version 3.0.0 oder höher)
- Android Studio / VS Code
- Android SDK oder iOS Simulator

### Schritte

1. **Ordner umbenennen** (siehe RENAME_INSTRUCTIONS.md):
   ```bash
   # Verwenden Sie das Python-Skript oder benennen Sie manuell um
   cd "Leicht Erlernen/leicht_erlernen/assets/App-data"
   python ../../rename_folders.py
   ```

2. **Dependencies installieren**:
   ```bash
   cd "Leicht Erlernen/leicht_erlernen"
   flutter pub get
   ```

3. **App starten**:
   ```bash
   flutter run
   ```

4. **App erstellen**:
   ```bash
   # Für Android
   flutter build apk
   
   # Für iOS
   flutter build ios
   ```

## 📖 App-Verwendung

1. **Hauptbildschirm**: Wählen Sie eine Lektion aus der Liste von 20 Lektionen
2. **Lektionsdetails**: Wählen Sie "Audioplayer" oder "eBook"
3. **Audioplayer**: Hören Sie echte Audio-Dateien (Tabellen, Hörtexte, Übungen)
4. **eBook**: Sehen Sie echte PDF-Dateien der Lektionen (mit Fallback-Inhalt)

## 🔧 Dependencies

### Aktuell (installiert)
- `cupertino_icons`: Icons für iOS
- `flutter_lints`: Linting-Regeln
- `syncfusion_flutter_pdfviewer`: Echte PDF-Dateien anzeigen
- `audioplayers`: Audio-Dateien abspielen
- `file_picker`: Dateien vom Gerät auswählen
- `path_provider`: Dateipfade verwalten

## 📋 Aktueller Status

### ✅ Abgeschlossen
- Hauptbenutzeroberfläche genau wie gewünscht
- Navigation zwischen Bildschirmen
- Echte PDF-Dateien aus Assets-Ordner (Priorität)
- Echte Audio-Dateien aus Assets-Ordner
- 20 Lektionen mit verschiedenen Inhalten
- Audio-Player mit Play/Pause-Funktionalität
- PDF-Viewer mit Zoom und Navigation
- Automatische PDF-Erkennung mit mehreren Namensmustern

### 🔄 Verbesserungen möglich
- Datenbank für Lernfortschritt integrieren
- Interaktive Quiz-Funktionen hinzufügen
- Offline-Modus implementieren
- Benutzerprofile und Statistiken

## 🎨 Benutzeroberfläche

Die App hat eine saubere Benutzeroberfläche mit:
- Hauptfarbe: Blau (#2196F3)
- Schriftart: Roboto
- Material Design 3
- Responsive für verschiedene Bildschirmgrößen

## 📝 Hinweise

- Die App verwendet echte PDF- und Audio-Dateien aus dem `assets/App-data` Ordner
- Alle 20 Lektionen sind vollständig mit Inhalten ausgestattet
- Audio-Dateien werden automatisch erkannt und angezeigt
- PDF-Dateien werden mit vollständiger Funktionalität angezeigt
- Die App unterstützt sowohl Android als auch iOS

## 🇩🇪 Lektionen-Inhalte

Die App enthält 20 Lektionen mit verschiedenen Themen:

1. **Grundlagen**: Begrüßungen, Zahlen
2. **Familie**: Familienmitglieder
3. **Farben**: Grundfarben
4. **Tiere**: Haustiere und Nutztiere
5. **Essen**: Grundnahrungsmittel
6. **Warnhinweise**: Alltagsaufforderungen
7. **Berufe**: Berufe und Arbeit
8. **Wohnen**: Wohnen und Haushalt
9. **Transport**: Transport und Verkehr
10. **Einkaufen**: Einkaufen und Geschäfte
11. **Zeit**: Zeit und Kalender
12. **Wetter**: Wetter und Jahreszeiten
13. **Hobbys**: Hobbys und Freizeit
14. **Gesundheit**: Gesundheit und Körper
15. **Reisen**: Reisen und Urlaub
16. **Technologie**: Technologie und Medien
17. **Kultur**: Kultur und Traditionen
18. **Umwelt**: Umwelt und Nachhaltigkeit
19. **Bildung**: Bildung und Lernen
20. **Fortgeschrittene**: Fortgeschrittene Kommunikation

## 🎵 Audio-Funktionen

- **Tabellen**: Vokabellisten mit Aussprache
- **Hörtexte**: Dialoge und Texte zum Hören
- **Übungen**: Interaktive Übungsaufgaben
- **Play/Pause**: Einfache Steuerung der Audio-Wiedergabe
- **Automatische Erkennung**: Verfügbare Audio-Dateien werden automatisch erkannt

## 📄 PDF-Funktionen

- **Echte PDF-Dateien**: Vollständige Lektionsinhalte (Priorität)
- **Automatische Erkennung**: Unterstützt mehrere PDF-Namensmuster
- **Zoom-Funktion**: Vergrößern und Verkleinern
- **Navigation**: Seitenweise Navigation
- **Textauswahl**: Text kann ausgewählt und kopiert werden
- **Fehlerbehandlung**: Klare Fehlermeldungen bei Problemen
- **Fallback-Inhalt**: Anzeige von Inhalten wenn PDF nicht verfügbar
- **Neu laden**: Möglichkeit PDF erneut zu laden bei Fehlern

## 🔍 PDF-Erkennung

Die App sucht automatisch nach PDF-Dateien mit folgenden Namensmustern:
- `vt1_eBook_Lektion_X.pdf`
- `vt1_eBook_Lektion X.pdf`
- `Lektion_X.pdf`
- `Lektion X.pdf` 
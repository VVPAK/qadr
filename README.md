# Qadr

[![Build](https://github.com/VVPAK/qadr/actions/workflows/build.yml/badge.svg)](https://github.com/VVPAK/qadr/actions/workflows/build.yml)
[![Tests](https://github.com/VVPAK/qadr/actions/workflows/test.yml/badge.svg)](https://github.com/VVPAK/qadr/actions/workflows/test.yml)

A Flutter-based Muslim companion app with a conversational UI. The main screen is a chat interface powered by an OpenAI-compatible LLM that returns structured JSON responses, rendered as rich UI components — prayer times, Quran ayahs, duas, tasbih counter, qibla compass, and learning cards.

## Features

- **Prayer Times** — offline calculation via `adhan_dart`, supports all major madhabs
- **Quran** — search and browse ayahs with Arabic text and translations
- **Duas** — curated collection of daily duas
- **Tasbih** — digital dhikr counter with haptic feedback and milestone vibrations
- **Qibla** — compass direction to Mecca
- **Learn** — Islamic knowledge cards
- **Conversational UI** — natural language interface that understands Islamic context

## Tech Stack

- **Flutter 3.41.6** (pinned via FVM)
- **State management:** Riverpod with code generation
- **Navigation:** GoRouter
- **Local storage:** Drift (SQLite), SharedPreferences, flutter_secure_storage
- **LLM integration:** OpenAI-compatible API with structured JSON responses
- **Localization:** English, Arabic, Russian

## Getting Started

**Prerequisites:** [FVM](https://fvm.app) installed.

```bash
# Install the pinned Flutter version
fvm install

# Install dependencies
fvm flutter pub get

# Regenerate code (freezed, json_serializable, drift, riverpod)
fvm dart run build_runner build --delete-conflicting-outputs

# Run the app
fvm flutter run
```

## Development

```bash
fvm flutter analyze          # Lint
fvm flutter test             # Run all tests (excluding golden)
fvm flutter test --tags golden --update-goldens  # Update golden snapshots
fvm flutter build apk        # Build Android APK
fvm flutter gen-l10n         # Regenerate localization files
```

## Architecture

```
lib/
├── core/           # Shared models, extensions, constants, services
├── features/
│   ├── chat/       # Conversational UI, LLM integration, intent parsing
│   ├── prayer/     # Prayer times screen and calculation
│   ├── quran/      # Quran browsing and search
│   ├── duas/       # Dua collection
│   ├── tasbih/     # Dhikr counter
│   ├── qibla/      # Qibla compass
│   ├── learn/      # Learning cards
│   └── settings/   # Preferences, API key, madhab selection
└── l10n/           # ARB localization files
```

Each feature follows `domain/` → `data/` → `presentation/` layering.

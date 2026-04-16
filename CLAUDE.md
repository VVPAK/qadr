# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Qadr is a Flutter-based Muslim companion app with a conversational UI. The main screen is a chat interface powered by an OpenAI-compatible LLM that returns structured JSON responses. The LLM's responses are parsed into intents and rendered as rich UI components (prayer times, Quran ayahs, duas, tasbih counter, qibla compass, learning cards).

## Build & Development Commands

**Always use FVM** (Flutter Version Manager) instead of system Flutter:

```bash
fvm flutter run                          # Run the app
fvm flutter build apk                    # Build Android APK
fvm flutter build ios                    # Build iOS
fvm flutter analyze                      # Run lint analysis
fvm flutter test                         # Run all tests
fvm flutter test test/widget_test.dart   # Run a single test
fvm dart run build_runner build --delete-conflicting-outputs  # Regenerate code (freezed, json_serializable, drift, riverpod)
fvm flutter gen-l10n                     # Regenerate localization files
```

Flutter version is pinned in `.fvmrc` (currently 3.41.6).

## Architecture

**State management:** Riverpod (with riverpod_generator for code-gen providers).

**Navigation:** GoRouter with onboarding guard — redirects to `/onboarding` until `onboardingComplete` is set.

**Data layer:**
- `UserPreferences` (SharedPreferences) — madhab, language, location, notifications, onboarding state
- `SecureStorage` (flutter_secure_storage) — LLM API key and base URL
- `AppDatabase` (Drift/SQLite) — Quran surahs/ayahs, duas

**Chat flow:** User message → `ChatMessagesNotifier` → `SystemPromptBuilder` (builds system prompt with user context) → `OpenAiLlmService` (calls OpenAI-compatible API) → `IntentParser` (extracts JSON from LLM response) → `LlmResponse` with intent + optional `ComponentPayload` → `ChatMessageRenderer` maps component type to widget.

**Models:** Freezed + json_serializable for immutable data classes. Generated files: `*.freezed.dart`, `*.g.dart`. Run `build_runner` after modifying any `@freezed` or `@JsonSerializable` class.

**Localization:** ARB-based (`lib/l10n/`), three locales: en, ar, ru. Access via `context.l10n.someKey`. Template file: `app_en.arb`.

## Key Conventions

- `Result<T>` sealed class (`core/models/result.dart`) for error handling — `Success(data)` / `Failure(message, error)`
- Context extensions (`core/extensions/context_extensions.dart`): `context.theme`, `context.textTheme`, `context.colorScheme`, `context.l10n`, `context.isRtl`
- `ComponentData` is a freezed sealed class — each variant maps to a UI widget card
- LLM responses must be valid JSON matching the schema in `SystemPromptBuilder`
- Prayer time calculation uses `adhan_dart` package (offline)
- Islamic enums (`Madhab`, `PrayerName`, `ChatIntent`) live in `core/constants/islamic_constants.dart`

## Feature Structure

Each feature follows: `feature_name/domain/` (models, services), `feature_name/data/` (repositories, API), `feature_name/presentation/` (screens, widgets, providers).

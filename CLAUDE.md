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

## Development Workflow — Test Driven Development (REQUIRED)

**All non-trivial code changes must follow TDD.** This is a hard rule, not a preference.

The red-green-refactor loop:

1. **Red** — Write a failing test first. Place unit tests in `test/` mirroring `lib/` structure; widget tests for UI in `test/<feature>/…_test.dart`; integration tests (if any) in `integration_test/`. Use `flutter_test` for widgets, plain `test` for pure Dart. Run `fvm flutter test <path>` and confirm the test fails for the right reason.
2. **Green** — Write the minimum production code needed to make the test pass. Do not add extra functionality. Run the test again and confirm it passes.
3. **Refactor** — Clean up the implementation (and the test) without changing behaviour. Run `fvm flutter test` and `fvm flutter analyze` after every refactor; both must stay clean.

**What counts as "non-trivial":** new public function/class/provider, bug fix, behaviour change, new widget with logic, any change to `domain/` services, intent parsing, prayer-time calculation, LLM request/response shape. Pure styling tweaks, copy changes, and l10n additions are exempt — but anything that has branching, state, or I/O needs a test first.

**Don't commit without tests.** If a PR/commit introduces logic without an accompanying failing-then-passing test, it's incomplete. Widget tests for visual screens may assert key rendered text, tap handlers firing, or navigation — not pixel layout.

**Practical expectations:**
- Mock `SharedPreferences` with `SharedPreferences.setMockInitialValues({})` in preferences tests.
- Stub `Dio` via `dio_adapter` or a fake `HttpClient` for LLM/network tests — never hit real endpoints.
- Use `ProviderContainer` with `overrides` for Riverpod tests; prefer overriding services at the provider level rather than peeking into widgets.
- Fake async time with `fake_async` for timers (`PrayerScreen` countdown, dhikr debounce, etc.).
- When fixing a bug, the first commit in the fix must be a regression test that reproduces it.

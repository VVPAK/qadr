# Troubleshooting

## Google Fonts fails in tests

**Error:** `Failed to load font with url: https://fonts.gstatic.com/...` or `allowRuntimeFetching is false but font X was not found`

**Fix:** Download the missing font into `google_fonts/` and ensure it's in pubspec assets:
```bash
curl -L "https://fonts.gstatic.com/s/a/{hash}.ttf" -o google_fonts/FontName-Weight.ttf
```
Find the hash in `~/.pub-cache/hosted/pub.dev/google_fonts-*/lib/src/google_fonts_parts/part_*.g.dart`. The `google_fonts/` directory is already declared in `pubspec.yaml` assets and `flutter_test_config.dart` sets `allowRuntimeFetching = false`.

---

## Nav bar indicator travels through intermediate tabs

**Symptom:** Tapping a non-adjacent nav tab animates the indicator through all tabs in between.

**Fix:** Use `jumpToPage()` instead of `animateToPage()` in `_onNavChanged` (`lib/app/main_shell.dart`). `animateToPage` scrolls through intermediate pages, firing `_onPageChanged` for each one.

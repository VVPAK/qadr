import 'package:freezed_annotation/freezed_annotation.dart';

part 'component_data.freezed.dart';
part 'component_data.g.dart';

@freezed
sealed class ComponentData with _$ComponentData {
  const factory ComponentData.prayerTimes({
    required List<PrayerTimeEntry> prayers,
    required String date,
  }) = PrayerTimesData;

  const factory ComponentData.quranAyah({
    required List<AyahEntry> ayahs,
  }) = QuranAyahData;

  const factory ComponentData.dua({
    required String arabic,
    required String transliteration,
    required String translation,
    required String source,
  }) = DuaData;

  const factory ComponentData.tasbih({
    required String dhikrText,
    @Default(33) int targetCount,
  }) = TasbihData;

  const factory ComponentData.qibla() = QiblaData;

  factory ComponentData.fromJson(Map<String, dynamic> json) =>
      _$ComponentDataFromJson(json);
}

@freezed
class PrayerTimeEntry with _$PrayerTimeEntry {
  const factory PrayerTimeEntry({
    required String name,
    required String time,
    @Default(false) bool isNext,
    @Default(false) bool isPassed,
    @Default(false) bool isPassive,
  }) = _PrayerTimeEntry;

  factory PrayerTimeEntry.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimeEntryFromJson(json);
}

@freezed
class AyahEntry with _$AyahEntry {
  const factory AyahEntry({
    required int surah,
    required int ayah,
    required String arabic,
    required String translation,
  }) = _AyahEntry;

  factory AyahEntry.fromJson(Map<String, dynamic> json) =>
      _$AyahEntryFromJson(json);
}

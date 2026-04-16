enum Madhab {
  hanafi,
  shafii,
  maliki,
  hanbali;

  String get displayName => switch (this) {
        hanafi => 'Hanafi',
        shafii => "Shafi'i",
        maliki => 'Maliki',
        hanbali => 'Hanbali',
      };
}

enum PrayerName {
  fajr,
  sunrise,
  dhuhr,
  asr,
  maghrib,
  isha;

  String get displayName => switch (this) {
        fajr => 'Fajr',
        sunrise => 'Sunrise',
        dhuhr => 'Dhuhr',
        asr => 'Asr',
        maghrib => 'Maghrib',
        isha => 'Isha',
      };
}

enum ChatIntent {
  prayerTime,
  quranSearch,
  duaRequest,
  tasbih,
  qibla,
  learning,
  generalQuestion;
}

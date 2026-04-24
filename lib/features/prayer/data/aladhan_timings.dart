class AladhanTimings {
  const AladhanTimings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  factory AladhanTimings.fromJson(Map<String, dynamic> json) {
    // Strip optional timezone suffix like " (+04)" from time strings.
    String clean(String s) => s.split(' ').first;
    return AladhanTimings(
      fajr: clean(json['Fajr'] as String),
      sunrise: clean(json['Sunrise'] as String),
      dhuhr: clean(json['Dhuhr'] as String),
      asr: clean(json['Asr'] as String),
      maghrib: clean(json['Maghrib'] as String),
      isha: clean(json['Isha'] as String),
    );
  }
}

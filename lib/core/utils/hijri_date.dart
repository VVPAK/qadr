class HijriDate {
  const HijriDate(this.year, this.month, this.day);

  final int year;
  final int month;
  final int day;

  static const _monthsRu = [
    'Мухаррам',
    'Сафар',
    'Раби аль-авваль',
    'Раби ас-сани',
    'Джумада аль-уля',
    'Джумада ас-сания',
    'Раджаб',
    'Шабан',
    'Рамадан',
    'Шавваль',
    'Зуль-каада',
    'Зуль-хиджа',
  ];

  String get monthNameRu => _monthsRu[month - 1];

  String formattedRu() => '$day $monthNameRu, $year';

  // Tabular (Kuwaiti) Gregorian → Islamic civil conversion. Can differ from
  // Umm al-Qura by ±1 day, which is acceptable for a calendar header.
  factory HijriDate.fromGregorian(DateTime date) {
    final gy = date.year;
    final gm = date.month;
    final gd = date.day;

    final a = (gm - 14) ~/ 12;
    final jd =
        (1461 * (gy + 4800 + a)) ~/ 4 +
        (367 * (gm - 2 - 12 * a)) ~/ 12 -
        (3 * ((gy + 4900 + a) ~/ 100)) ~/ 4 +
        gd -
        32075;

    var l = jd - 1948440 + 10632;
    final n = (l - 1) ~/ 10631;
    l = l - 10631 * n + 354;
    final j =
        ((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719) +
        (l ~/ 5670) * ((43 * l) ~/ 15238);
    l =
        l -
        ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) -
        (j ~/ 16) * ((15238 * j) ~/ 43) +
        29;
    final month = (24 * l) ~/ 709;
    final day = l - (709 * month) ~/ 24;
    final year = 30 * n + j - 30;

    return HijriDate(year, month, day);
  }
}

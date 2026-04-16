import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayer_time_model.freezed.dart';
part 'prayer_time_model.g.dart';

@freezed
class PrayerTimeModel with _$PrayerTimeModel {
  const factory PrayerTimeModel({
    required DateTime fajr,
    required DateTime sunrise,
    required DateTime dhuhr,
    required DateTime asr,
    required DateTime maghrib,
    required DateTime isha,
    required DateTime date,
  }) = _PrayerTimeModel;

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimeModelFromJson(json);
}

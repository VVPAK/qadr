// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerTimeModelImpl _$$PrayerTimeModelImplFromJson(
  Map<String, dynamic> json,
) => _$PrayerTimeModelImpl(
  fajr: DateTime.parse(json['fajr'] as String),
  sunrise: DateTime.parse(json['sunrise'] as String),
  dhuhr: DateTime.parse(json['dhuhr'] as String),
  asr: DateTime.parse(json['asr'] as String),
  maghrib: DateTime.parse(json['maghrib'] as String),
  isha: DateTime.parse(json['isha'] as String),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$$PrayerTimeModelImplToJson(
  _$PrayerTimeModelImpl instance,
) => <String, dynamic>{
  'fajr': instance.fajr.toIso8601String(),
  'sunrise': instance.sunrise.toIso8601String(),
  'dhuhr': instance.dhuhr.toIso8601String(),
  'asr': instance.asr.toIso8601String(),
  'maghrib': instance.maghrib.toIso8601String(),
  'isha': instance.isha.toIso8601String(),
  'date': instance.date.toIso8601String(),
};

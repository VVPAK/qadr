// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      name: json['name'] as String?,
      madhab:
          $enumDecodeNullable(_$MadhabEnumMap, json['madhab']) ?? Madhab.hanafi,
      language: json['language'] as String? ?? 'en',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'madhab': _$MadhabEnumMap[instance.madhab]!,
      'language': instance.language,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'notificationsEnabled': instance.notificationsEnabled,
    };

const _$MadhabEnumMap = {
  Madhab.hanafi: 'hanafi',
  Madhab.shafii: 'shafii',
  Madhab.maliki: 'maliki',
  Madhab.hanbali: 'hanbali',
};

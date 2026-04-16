// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DuaModelImpl _$$DuaModelImplFromJson(Map<String, dynamic> json) =>
    _$DuaModelImpl(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      arabic: json['arabic'] as String,
      transliteration: json['transliteration'] as String,
      translationEn: json['translationEn'] as String,
      translationRu: json['translationRu'] as String,
      source: json['source'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$DuaModelImplToJson(_$DuaModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'arabic': instance.arabic,
      'transliteration': instance.transliteration,
      'translationEn': instance.translationEn,
      'translationRu': instance.translationRu,
      'source': instance.source,
      'isFavorite': instance.isFavorite,
    };

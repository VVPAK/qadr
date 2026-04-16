import 'package:freezed_annotation/freezed_annotation.dart';

part 'dua_model.freezed.dart';
part 'dua_model.g.dart';

@freezed
class DuaModel with _$DuaModel {
  const factory DuaModel({
    required int id,
    required String category,
    required String arabic,
    required String transliteration,
    required String translationEn,
    required String translationRu,
    required String source,
    @Default(false) bool isFavorite,
  }) = _DuaModel;

  factory DuaModel.fromJson(Map<String, dynamic> json) =>
      _$DuaModelFromJson(json);
}

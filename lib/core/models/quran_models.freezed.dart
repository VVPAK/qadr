// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Surah _$SurahFromJson(Map<String, dynamic> json) {
  return _Surah.fromJson(json);
}

/// @nodoc
mixin _$Surah {
  int get number => throw _privateConstructorUsedError;
  String get nameArabic => throw _privateConstructorUsedError;
  String get nameEnglish => throw _privateConstructorUsedError;
  String get nameRussian => throw _privateConstructorUsedError;
  String get revelationType => throw _privateConstructorUsedError;
  int get ayahCount => throw _privateConstructorUsedError;

  /// Serializes this Surah to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurahCopyWith<Surah> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurahCopyWith<$Res> {
  factory $SurahCopyWith(Surah value, $Res Function(Surah) then) =
      _$SurahCopyWithImpl<$Res, Surah>;
  @useResult
  $Res call({
    int number,
    String nameArabic,
    String nameEnglish,
    String nameRussian,
    String revelationType,
    int ayahCount,
  });
}

/// @nodoc
class _$SurahCopyWithImpl<$Res, $Val extends Surah>
    implements $SurahCopyWith<$Res> {
  _$SurahCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? nameArabic = null,
    Object? nameEnglish = null,
    Object? nameRussian = null,
    Object? revelationType = null,
    Object? ayahCount = null,
  }) {
    return _then(
      _value.copyWith(
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            nameArabic: null == nameArabic
                ? _value.nameArabic
                : nameArabic // ignore: cast_nullable_to_non_nullable
                      as String,
            nameEnglish: null == nameEnglish
                ? _value.nameEnglish
                : nameEnglish // ignore: cast_nullable_to_non_nullable
                      as String,
            nameRussian: null == nameRussian
                ? _value.nameRussian
                : nameRussian // ignore: cast_nullable_to_non_nullable
                      as String,
            revelationType: null == revelationType
                ? _value.revelationType
                : revelationType // ignore: cast_nullable_to_non_nullable
                      as String,
            ayahCount: null == ayahCount
                ? _value.ayahCount
                : ayahCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SurahImplCopyWith<$Res> implements $SurahCopyWith<$Res> {
  factory _$$SurahImplCopyWith(
    _$SurahImpl value,
    $Res Function(_$SurahImpl) then,
  ) = __$$SurahImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int number,
    String nameArabic,
    String nameEnglish,
    String nameRussian,
    String revelationType,
    int ayahCount,
  });
}

/// @nodoc
class __$$SurahImplCopyWithImpl<$Res>
    extends _$SurahCopyWithImpl<$Res, _$SurahImpl>
    implements _$$SurahImplCopyWith<$Res> {
  __$$SurahImplCopyWithImpl(
    _$SurahImpl _value,
    $Res Function(_$SurahImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? nameArabic = null,
    Object? nameEnglish = null,
    Object? nameRussian = null,
    Object? revelationType = null,
    Object? ayahCount = null,
  }) {
    return _then(
      _$SurahImpl(
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        nameArabic: null == nameArabic
            ? _value.nameArabic
            : nameArabic // ignore: cast_nullable_to_non_nullable
                  as String,
        nameEnglish: null == nameEnglish
            ? _value.nameEnglish
            : nameEnglish // ignore: cast_nullable_to_non_nullable
                  as String,
        nameRussian: null == nameRussian
            ? _value.nameRussian
            : nameRussian // ignore: cast_nullable_to_non_nullable
                  as String,
        revelationType: null == revelationType
            ? _value.revelationType
            : revelationType // ignore: cast_nullable_to_non_nullable
                  as String,
        ayahCount: null == ayahCount
            ? _value.ayahCount
            : ayahCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SurahImpl implements _Surah {
  const _$SurahImpl({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.nameRussian,
    required this.revelationType,
    required this.ayahCount,
  });

  factory _$SurahImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurahImplFromJson(json);

  @override
  final int number;
  @override
  final String nameArabic;
  @override
  final String nameEnglish;
  @override
  final String nameRussian;
  @override
  final String revelationType;
  @override
  final int ayahCount;

  @override
  String toString() {
    return 'Surah(number: $number, nameArabic: $nameArabic, nameEnglish: $nameEnglish, nameRussian: $nameRussian, revelationType: $revelationType, ayahCount: $ayahCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurahImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.nameArabic, nameArabic) ||
                other.nameArabic == nameArabic) &&
            (identical(other.nameEnglish, nameEnglish) ||
                other.nameEnglish == nameEnglish) &&
            (identical(other.nameRussian, nameRussian) ||
                other.nameRussian == nameRussian) &&
            (identical(other.revelationType, revelationType) ||
                other.revelationType == revelationType) &&
            (identical(other.ayahCount, ayahCount) ||
                other.ayahCount == ayahCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    number,
    nameArabic,
    nameEnglish,
    nameRussian,
    revelationType,
    ayahCount,
  );

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurahImplCopyWith<_$SurahImpl> get copyWith =>
      __$$SurahImplCopyWithImpl<_$SurahImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurahImplToJson(this);
  }
}

abstract class _Surah implements Surah {
  const factory _Surah({
    required final int number,
    required final String nameArabic,
    required final String nameEnglish,
    required final String nameRussian,
    required final String revelationType,
    required final int ayahCount,
  }) = _$SurahImpl;

  factory _Surah.fromJson(Map<String, dynamic> json) = _$SurahImpl.fromJson;

  @override
  int get number;
  @override
  String get nameArabic;
  @override
  String get nameEnglish;
  @override
  String get nameRussian;
  @override
  String get revelationType;
  @override
  int get ayahCount;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurahImplCopyWith<_$SurahImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Ayah _$AyahFromJson(Map<String, dynamic> json) {
  return _Ayah.fromJson(json);
}

/// @nodoc
mixin _$Ayah {
  int get surahNumber => throw _privateConstructorUsedError;
  int get ayahNumber => throw _privateConstructorUsedError;
  String get textArabic => throw _privateConstructorUsedError;
  String get textEnglish => throw _privateConstructorUsedError;
  String get textRussian => throw _privateConstructorUsedError;

  /// Serializes this Ayah to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ayah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AyahCopyWith<Ayah> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AyahCopyWith<$Res> {
  factory $AyahCopyWith(Ayah value, $Res Function(Ayah) then) =
      _$AyahCopyWithImpl<$Res, Ayah>;
  @useResult
  $Res call({
    int surahNumber,
    int ayahNumber,
    String textArabic,
    String textEnglish,
    String textRussian,
  });
}

/// @nodoc
class _$AyahCopyWithImpl<$Res, $Val extends Ayah>
    implements $AyahCopyWith<$Res> {
  _$AyahCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ayah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surahNumber = null,
    Object? ayahNumber = null,
    Object? textArabic = null,
    Object? textEnglish = null,
    Object? textRussian = null,
  }) {
    return _then(
      _value.copyWith(
            surahNumber: null == surahNumber
                ? _value.surahNumber
                : surahNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            ayahNumber: null == ayahNumber
                ? _value.ayahNumber
                : ayahNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            textArabic: null == textArabic
                ? _value.textArabic
                : textArabic // ignore: cast_nullable_to_non_nullable
                      as String,
            textEnglish: null == textEnglish
                ? _value.textEnglish
                : textEnglish // ignore: cast_nullable_to_non_nullable
                      as String,
            textRussian: null == textRussian
                ? _value.textRussian
                : textRussian // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AyahImplCopyWith<$Res> implements $AyahCopyWith<$Res> {
  factory _$$AyahImplCopyWith(
    _$AyahImpl value,
    $Res Function(_$AyahImpl) then,
  ) = __$$AyahImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int surahNumber,
    int ayahNumber,
    String textArabic,
    String textEnglish,
    String textRussian,
  });
}

/// @nodoc
class __$$AyahImplCopyWithImpl<$Res>
    extends _$AyahCopyWithImpl<$Res, _$AyahImpl>
    implements _$$AyahImplCopyWith<$Res> {
  __$$AyahImplCopyWithImpl(_$AyahImpl _value, $Res Function(_$AyahImpl) _then)
    : super(_value, _then);

  /// Create a copy of Ayah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surahNumber = null,
    Object? ayahNumber = null,
    Object? textArabic = null,
    Object? textEnglish = null,
    Object? textRussian = null,
  }) {
    return _then(
      _$AyahImpl(
        surahNumber: null == surahNumber
            ? _value.surahNumber
            : surahNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        ayahNumber: null == ayahNumber
            ? _value.ayahNumber
            : ayahNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        textArabic: null == textArabic
            ? _value.textArabic
            : textArabic // ignore: cast_nullable_to_non_nullable
                  as String,
        textEnglish: null == textEnglish
            ? _value.textEnglish
            : textEnglish // ignore: cast_nullable_to_non_nullable
                  as String,
        textRussian: null == textRussian
            ? _value.textRussian
            : textRussian // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AyahImpl implements _Ayah {
  const _$AyahImpl({
    required this.surahNumber,
    required this.ayahNumber,
    required this.textArabic,
    required this.textEnglish,
    required this.textRussian,
  });

  factory _$AyahImpl.fromJson(Map<String, dynamic> json) =>
      _$$AyahImplFromJson(json);

  @override
  final int surahNumber;
  @override
  final int ayahNumber;
  @override
  final String textArabic;
  @override
  final String textEnglish;
  @override
  final String textRussian;

  @override
  String toString() {
    return 'Ayah(surahNumber: $surahNumber, ayahNumber: $ayahNumber, textArabic: $textArabic, textEnglish: $textEnglish, textRussian: $textRussian)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AyahImpl &&
            (identical(other.surahNumber, surahNumber) ||
                other.surahNumber == surahNumber) &&
            (identical(other.ayahNumber, ayahNumber) ||
                other.ayahNumber == ayahNumber) &&
            (identical(other.textArabic, textArabic) ||
                other.textArabic == textArabic) &&
            (identical(other.textEnglish, textEnglish) ||
                other.textEnglish == textEnglish) &&
            (identical(other.textRussian, textRussian) ||
                other.textRussian == textRussian));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    surahNumber,
    ayahNumber,
    textArabic,
    textEnglish,
    textRussian,
  );

  /// Create a copy of Ayah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AyahImplCopyWith<_$AyahImpl> get copyWith =>
      __$$AyahImplCopyWithImpl<_$AyahImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AyahImplToJson(this);
  }
}

abstract class _Ayah implements Ayah {
  const factory _Ayah({
    required final int surahNumber,
    required final int ayahNumber,
    required final String textArabic,
    required final String textEnglish,
    required final String textRussian,
  }) = _$AyahImpl;

  factory _Ayah.fromJson(Map<String, dynamic> json) = _$AyahImpl.fromJson;

  @override
  int get surahNumber;
  @override
  int get ayahNumber;
  @override
  String get textArabic;
  @override
  String get textEnglish;
  @override
  String get textRussian;

  /// Create a copy of Ayah
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AyahImplCopyWith<_$AyahImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuranSearchResult _$QuranSearchResultFromJson(Map<String, dynamic> json) {
  return _QuranSearchResult.fromJson(json);
}

/// @nodoc
mixin _$QuranSearchResult {
  Ayah get ayah => throw _privateConstructorUsedError;
  String get surahName => throw _privateConstructorUsedError;
  double get relevance => throw _privateConstructorUsedError;

  /// Serializes this QuranSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuranSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuranSearchResultCopyWith<QuranSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuranSearchResultCopyWith<$Res> {
  factory $QuranSearchResultCopyWith(
    QuranSearchResult value,
    $Res Function(QuranSearchResult) then,
  ) = _$QuranSearchResultCopyWithImpl<$Res, QuranSearchResult>;
  @useResult
  $Res call({Ayah ayah, String surahName, double relevance});

  $AyahCopyWith<$Res> get ayah;
}

/// @nodoc
class _$QuranSearchResultCopyWithImpl<$Res, $Val extends QuranSearchResult>
    implements $QuranSearchResultCopyWith<$Res> {
  _$QuranSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuranSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ayah = null,
    Object? surahName = null,
    Object? relevance = null,
  }) {
    return _then(
      _value.copyWith(
            ayah: null == ayah
                ? _value.ayah
                : ayah // ignore: cast_nullable_to_non_nullable
                      as Ayah,
            surahName: null == surahName
                ? _value.surahName
                : surahName // ignore: cast_nullable_to_non_nullable
                      as String,
            relevance: null == relevance
                ? _value.relevance
                : relevance // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }

  /// Create a copy of QuranSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AyahCopyWith<$Res> get ayah {
    return $AyahCopyWith<$Res>(_value.ayah, (value) {
      return _then(_value.copyWith(ayah: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuranSearchResultImplCopyWith<$Res>
    implements $QuranSearchResultCopyWith<$Res> {
  factory _$$QuranSearchResultImplCopyWith(
    _$QuranSearchResultImpl value,
    $Res Function(_$QuranSearchResultImpl) then,
  ) = __$$QuranSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Ayah ayah, String surahName, double relevance});

  @override
  $AyahCopyWith<$Res> get ayah;
}

/// @nodoc
class __$$QuranSearchResultImplCopyWithImpl<$Res>
    extends _$QuranSearchResultCopyWithImpl<$Res, _$QuranSearchResultImpl>
    implements _$$QuranSearchResultImplCopyWith<$Res> {
  __$$QuranSearchResultImplCopyWithImpl(
    _$QuranSearchResultImpl _value,
    $Res Function(_$QuranSearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuranSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ayah = null,
    Object? surahName = null,
    Object? relevance = null,
  }) {
    return _then(
      _$QuranSearchResultImpl(
        ayah: null == ayah
            ? _value.ayah
            : ayah // ignore: cast_nullable_to_non_nullable
                  as Ayah,
        surahName: null == surahName
            ? _value.surahName
            : surahName // ignore: cast_nullable_to_non_nullable
                  as String,
        relevance: null == relevance
            ? _value.relevance
            : relevance // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuranSearchResultImpl implements _QuranSearchResult {
  const _$QuranSearchResultImpl({
    required this.ayah,
    required this.surahName,
    required this.relevance,
  });

  factory _$QuranSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuranSearchResultImplFromJson(json);

  @override
  final Ayah ayah;
  @override
  final String surahName;
  @override
  final double relevance;

  @override
  String toString() {
    return 'QuranSearchResult(ayah: $ayah, surahName: $surahName, relevance: $relevance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuranSearchResultImpl &&
            (identical(other.ayah, ayah) || other.ayah == ayah) &&
            (identical(other.surahName, surahName) ||
                other.surahName == surahName) &&
            (identical(other.relevance, relevance) ||
                other.relevance == relevance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ayah, surahName, relevance);

  /// Create a copy of QuranSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuranSearchResultImplCopyWith<_$QuranSearchResultImpl> get copyWith =>
      __$$QuranSearchResultImplCopyWithImpl<_$QuranSearchResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuranSearchResultImplToJson(this);
  }
}

abstract class _QuranSearchResult implements QuranSearchResult {
  const factory _QuranSearchResult({
    required final Ayah ayah,
    required final String surahName,
    required final double relevance,
  }) = _$QuranSearchResultImpl;

  factory _QuranSearchResult.fromJson(Map<String, dynamic> json) =
      _$QuranSearchResultImpl.fromJson;

  @override
  Ayah get ayah;
  @override
  String get surahName;
  @override
  double get relevance;

  /// Create a copy of QuranSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuranSearchResultImplCopyWith<_$QuranSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

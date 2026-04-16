// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'component_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ComponentData _$ComponentDataFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'prayerTimes':
      return PrayerTimesData.fromJson(json);
    case 'quranAyah':
      return QuranAyahData.fromJson(json);
    case 'dua':
      return DuaData.fromJson(json);
    case 'tasbih':
      return TasbihData.fromJson(json);
    case 'qibla':
      return QiblaData.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'ComponentData',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$ComponentData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PrayerTimeEntry> prayers, String date)
    prayerTimes,
    required TResult Function(List<AyahEntry> ayahs) quranAyah,
    required TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )
    dua,
    required TResult Function(String dhikrText, int targetCount) tasbih,
    required TResult Function() qibla,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult? Function(List<AyahEntry> ayahs)? quranAyah,
    TResult? Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult? Function(String dhikrText, int targetCount)? tasbih,
    TResult? Function()? qibla,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult Function(List<AyahEntry> ayahs)? quranAyah,
    TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult Function(String dhikrText, int targetCount)? tasbih,
    TResult Function()? qibla,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrayerTimesData value) prayerTimes,
    required TResult Function(QuranAyahData value) quranAyah,
    required TResult Function(DuaData value) dua,
    required TResult Function(TasbihData value) tasbih,
    required TResult Function(QiblaData value) qibla,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrayerTimesData value)? prayerTimes,
    TResult? Function(QuranAyahData value)? quranAyah,
    TResult? Function(DuaData value)? dua,
    TResult? Function(TasbihData value)? tasbih,
    TResult? Function(QiblaData value)? qibla,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrayerTimesData value)? prayerTimes,
    TResult Function(QuranAyahData value)? quranAyah,
    TResult Function(DuaData value)? dua,
    TResult Function(TasbihData value)? tasbih,
    TResult Function(QiblaData value)? qibla,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this ComponentData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentDataCopyWith<$Res> {
  factory $ComponentDataCopyWith(
    ComponentData value,
    $Res Function(ComponentData) then,
  ) = _$ComponentDataCopyWithImpl<$Res, ComponentData>;
}

/// @nodoc
class _$ComponentDataCopyWithImpl<$Res, $Val extends ComponentData>
    implements $ComponentDataCopyWith<$Res> {
  _$ComponentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PrayerTimesDataImplCopyWith<$Res> {
  factory _$$PrayerTimesDataImplCopyWith(
    _$PrayerTimesDataImpl value,
    $Res Function(_$PrayerTimesDataImpl) then,
  ) = __$$PrayerTimesDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PrayerTimeEntry> prayers, String date});
}

/// @nodoc
class __$$PrayerTimesDataImplCopyWithImpl<$Res>
    extends _$ComponentDataCopyWithImpl<$Res, _$PrayerTimesDataImpl>
    implements _$$PrayerTimesDataImplCopyWith<$Res> {
  __$$PrayerTimesDataImplCopyWithImpl(
    _$PrayerTimesDataImpl _value,
    $Res Function(_$PrayerTimesDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? prayers = null, Object? date = null}) {
    return _then(
      _$PrayerTimesDataImpl(
        prayers: null == prayers
            ? _value._prayers
            : prayers // ignore: cast_nullable_to_non_nullable
                  as List<PrayerTimeEntry>,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerTimesDataImpl implements PrayerTimesData {
  const _$PrayerTimesDataImpl({
    required final List<PrayerTimeEntry> prayers,
    required this.date,
    final String? $type,
  }) : _prayers = prayers,
       $type = $type ?? 'prayerTimes';

  factory _$PrayerTimesDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerTimesDataImplFromJson(json);

  final List<PrayerTimeEntry> _prayers;
  @override
  List<PrayerTimeEntry> get prayers {
    if (_prayers is EqualUnmodifiableListView) return _prayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prayers);
  }

  @override
  final String date;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ComponentData.prayerTimes(prayers: $prayers, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerTimesDataImpl &&
            const DeepCollectionEquality().equals(other._prayers, _prayers) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_prayers),
    date,
  );

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerTimesDataImplCopyWith<_$PrayerTimesDataImpl> get copyWith =>
      __$$PrayerTimesDataImplCopyWithImpl<_$PrayerTimesDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PrayerTimeEntry> prayers, String date)
    prayerTimes,
    required TResult Function(List<AyahEntry> ayahs) quranAyah,
    required TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )
    dua,
    required TResult Function(String dhikrText, int targetCount) tasbih,
    required TResult Function() qibla,
  }) {
    return prayerTimes(prayers, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult? Function(List<AyahEntry> ayahs)? quranAyah,
    TResult? Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult? Function(String dhikrText, int targetCount)? tasbih,
    TResult? Function()? qibla,
  }) {
    return prayerTimes?.call(prayers, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult Function(List<AyahEntry> ayahs)? quranAyah,
    TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult Function(String dhikrText, int targetCount)? tasbih,
    TResult Function()? qibla,
    required TResult orElse(),
  }) {
    if (prayerTimes != null) {
      return prayerTimes(prayers, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrayerTimesData value) prayerTimes,
    required TResult Function(QuranAyahData value) quranAyah,
    required TResult Function(DuaData value) dua,
    required TResult Function(TasbihData value) tasbih,
    required TResult Function(QiblaData value) qibla,
  }) {
    return prayerTimes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrayerTimesData value)? prayerTimes,
    TResult? Function(QuranAyahData value)? quranAyah,
    TResult? Function(DuaData value)? dua,
    TResult? Function(TasbihData value)? tasbih,
    TResult? Function(QiblaData value)? qibla,
  }) {
    return prayerTimes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrayerTimesData value)? prayerTimes,
    TResult Function(QuranAyahData value)? quranAyah,
    TResult Function(DuaData value)? dua,
    TResult Function(TasbihData value)? tasbih,
    TResult Function(QiblaData value)? qibla,
    required TResult orElse(),
  }) {
    if (prayerTimes != null) {
      return prayerTimes(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerTimesDataImplToJson(this);
  }
}

abstract class PrayerTimesData implements ComponentData {
  const factory PrayerTimesData({
    required final List<PrayerTimeEntry> prayers,
    required final String date,
  }) = _$PrayerTimesDataImpl;

  factory PrayerTimesData.fromJson(Map<String, dynamic> json) =
      _$PrayerTimesDataImpl.fromJson;

  List<PrayerTimeEntry> get prayers;
  String get date;

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrayerTimesDataImplCopyWith<_$PrayerTimesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuranAyahDataImplCopyWith<$Res> {
  factory _$$QuranAyahDataImplCopyWith(
    _$QuranAyahDataImpl value,
    $Res Function(_$QuranAyahDataImpl) then,
  ) = __$$QuranAyahDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AyahEntry> ayahs});
}

/// @nodoc
class __$$QuranAyahDataImplCopyWithImpl<$Res>
    extends _$ComponentDataCopyWithImpl<$Res, _$QuranAyahDataImpl>
    implements _$$QuranAyahDataImplCopyWith<$Res> {
  __$$QuranAyahDataImplCopyWithImpl(
    _$QuranAyahDataImpl _value,
    $Res Function(_$QuranAyahDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ayahs = null}) {
    return _then(
      _$QuranAyahDataImpl(
        ayahs: null == ayahs
            ? _value._ayahs
            : ayahs // ignore: cast_nullable_to_non_nullable
                  as List<AyahEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuranAyahDataImpl implements QuranAyahData {
  const _$QuranAyahDataImpl({
    required final List<AyahEntry> ayahs,
    final String? $type,
  }) : _ayahs = ayahs,
       $type = $type ?? 'quranAyah';

  factory _$QuranAyahDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuranAyahDataImplFromJson(json);

  final List<AyahEntry> _ayahs;
  @override
  List<AyahEntry> get ayahs {
    if (_ayahs is EqualUnmodifiableListView) return _ayahs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ayahs);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ComponentData.quranAyah(ayahs: $ayahs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuranAyahDataImpl &&
            const DeepCollectionEquality().equals(other._ayahs, _ayahs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ayahs));

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuranAyahDataImplCopyWith<_$QuranAyahDataImpl> get copyWith =>
      __$$QuranAyahDataImplCopyWithImpl<_$QuranAyahDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PrayerTimeEntry> prayers, String date)
    prayerTimes,
    required TResult Function(List<AyahEntry> ayahs) quranAyah,
    required TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )
    dua,
    required TResult Function(String dhikrText, int targetCount) tasbih,
    required TResult Function() qibla,
  }) {
    return quranAyah(ayahs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult? Function(List<AyahEntry> ayahs)? quranAyah,
    TResult? Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult? Function(String dhikrText, int targetCount)? tasbih,
    TResult? Function()? qibla,
  }) {
    return quranAyah?.call(ayahs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult Function(List<AyahEntry> ayahs)? quranAyah,
    TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult Function(String dhikrText, int targetCount)? tasbih,
    TResult Function()? qibla,
    required TResult orElse(),
  }) {
    if (quranAyah != null) {
      return quranAyah(ayahs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrayerTimesData value) prayerTimes,
    required TResult Function(QuranAyahData value) quranAyah,
    required TResult Function(DuaData value) dua,
    required TResult Function(TasbihData value) tasbih,
    required TResult Function(QiblaData value) qibla,
  }) {
    return quranAyah(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrayerTimesData value)? prayerTimes,
    TResult? Function(QuranAyahData value)? quranAyah,
    TResult? Function(DuaData value)? dua,
    TResult? Function(TasbihData value)? tasbih,
    TResult? Function(QiblaData value)? qibla,
  }) {
    return quranAyah?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrayerTimesData value)? prayerTimes,
    TResult Function(QuranAyahData value)? quranAyah,
    TResult Function(DuaData value)? dua,
    TResult Function(TasbihData value)? tasbih,
    TResult Function(QiblaData value)? qibla,
    required TResult orElse(),
  }) {
    if (quranAyah != null) {
      return quranAyah(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QuranAyahDataImplToJson(this);
  }
}

abstract class QuranAyahData implements ComponentData {
  const factory QuranAyahData({required final List<AyahEntry> ayahs}) =
      _$QuranAyahDataImpl;

  factory QuranAyahData.fromJson(Map<String, dynamic> json) =
      _$QuranAyahDataImpl.fromJson;

  List<AyahEntry> get ayahs;

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuranAyahDataImplCopyWith<_$QuranAyahDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DuaDataImplCopyWith<$Res> {
  factory _$$DuaDataImplCopyWith(
    _$DuaDataImpl value,
    $Res Function(_$DuaDataImpl) then,
  ) = __$$DuaDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String arabic,
    String transliteration,
    String translation,
    String source,
  });
}

/// @nodoc
class __$$DuaDataImplCopyWithImpl<$Res>
    extends _$ComponentDataCopyWithImpl<$Res, _$DuaDataImpl>
    implements _$$DuaDataImplCopyWith<$Res> {
  __$$DuaDataImplCopyWithImpl(
    _$DuaDataImpl _value,
    $Res Function(_$DuaDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arabic = null,
    Object? transliteration = null,
    Object? translation = null,
    Object? source = null,
  }) {
    return _then(
      _$DuaDataImpl(
        arabic: null == arabic
            ? _value.arabic
            : arabic // ignore: cast_nullable_to_non_nullable
                  as String,
        transliteration: null == transliteration
            ? _value.transliteration
            : transliteration // ignore: cast_nullable_to_non_nullable
                  as String,
        translation: null == translation
            ? _value.translation
            : translation // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DuaDataImpl implements DuaData {
  const _$DuaDataImpl({
    required this.arabic,
    required this.transliteration,
    required this.translation,
    required this.source,
    final String? $type,
  }) : $type = $type ?? 'dua';

  factory _$DuaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DuaDataImplFromJson(json);

  @override
  final String arabic;
  @override
  final String transliteration;
  @override
  final String translation;
  @override
  final String source;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ComponentData.dua(arabic: $arabic, transliteration: $transliteration, translation: $translation, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuaDataImpl &&
            (identical(other.arabic, arabic) || other.arabic == arabic) &&
            (identical(other.transliteration, transliteration) ||
                other.transliteration == transliteration) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, arabic, transliteration, translation, source);

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DuaDataImplCopyWith<_$DuaDataImpl> get copyWith =>
      __$$DuaDataImplCopyWithImpl<_$DuaDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PrayerTimeEntry> prayers, String date)
    prayerTimes,
    required TResult Function(List<AyahEntry> ayahs) quranAyah,
    required TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )
    dua,
    required TResult Function(String dhikrText, int targetCount) tasbih,
    required TResult Function() qibla,
  }) {
    return dua(arabic, transliteration, translation, source);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult? Function(List<AyahEntry> ayahs)? quranAyah,
    TResult? Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult? Function(String dhikrText, int targetCount)? tasbih,
    TResult? Function()? qibla,
  }) {
    return dua?.call(arabic, transliteration, translation, source);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult Function(List<AyahEntry> ayahs)? quranAyah,
    TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult Function(String dhikrText, int targetCount)? tasbih,
    TResult Function()? qibla,
    required TResult orElse(),
  }) {
    if (dua != null) {
      return dua(arabic, transliteration, translation, source);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrayerTimesData value) prayerTimes,
    required TResult Function(QuranAyahData value) quranAyah,
    required TResult Function(DuaData value) dua,
    required TResult Function(TasbihData value) tasbih,
    required TResult Function(QiblaData value) qibla,
  }) {
    return dua(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrayerTimesData value)? prayerTimes,
    TResult? Function(QuranAyahData value)? quranAyah,
    TResult? Function(DuaData value)? dua,
    TResult? Function(TasbihData value)? tasbih,
    TResult? Function(QiblaData value)? qibla,
  }) {
    return dua?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrayerTimesData value)? prayerTimes,
    TResult Function(QuranAyahData value)? quranAyah,
    TResult Function(DuaData value)? dua,
    TResult Function(TasbihData value)? tasbih,
    TResult Function(QiblaData value)? qibla,
    required TResult orElse(),
  }) {
    if (dua != null) {
      return dua(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DuaDataImplToJson(this);
  }
}

abstract class DuaData implements ComponentData {
  const factory DuaData({
    required final String arabic,
    required final String transliteration,
    required final String translation,
    required final String source,
  }) = _$DuaDataImpl;

  factory DuaData.fromJson(Map<String, dynamic> json) = _$DuaDataImpl.fromJson;

  String get arabic;
  String get transliteration;
  String get translation;
  String get source;

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DuaDataImplCopyWith<_$DuaDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasbihDataImplCopyWith<$Res> {
  factory _$$TasbihDataImplCopyWith(
    _$TasbihDataImpl value,
    $Res Function(_$TasbihDataImpl) then,
  ) = __$$TasbihDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String dhikrText, int targetCount});
}

/// @nodoc
class __$$TasbihDataImplCopyWithImpl<$Res>
    extends _$ComponentDataCopyWithImpl<$Res, _$TasbihDataImpl>
    implements _$$TasbihDataImplCopyWith<$Res> {
  __$$TasbihDataImplCopyWithImpl(
    _$TasbihDataImpl _value,
    $Res Function(_$TasbihDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dhikrText = null, Object? targetCount = null}) {
    return _then(
      _$TasbihDataImpl(
        dhikrText: null == dhikrText
            ? _value.dhikrText
            : dhikrText // ignore: cast_nullable_to_non_nullable
                  as String,
        targetCount: null == targetCount
            ? _value.targetCount
            : targetCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TasbihDataImpl implements TasbihData {
  const _$TasbihDataImpl({
    required this.dhikrText,
    this.targetCount = 33,
    final String? $type,
  }) : $type = $type ?? 'tasbih';

  factory _$TasbihDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TasbihDataImplFromJson(json);

  @override
  final String dhikrText;
  @override
  @JsonKey()
  final int targetCount;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ComponentData.tasbih(dhikrText: $dhikrText, targetCount: $targetCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasbihDataImpl &&
            (identical(other.dhikrText, dhikrText) ||
                other.dhikrText == dhikrText) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dhikrText, targetCount);

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasbihDataImplCopyWith<_$TasbihDataImpl> get copyWith =>
      __$$TasbihDataImplCopyWithImpl<_$TasbihDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PrayerTimeEntry> prayers, String date)
    prayerTimes,
    required TResult Function(List<AyahEntry> ayahs) quranAyah,
    required TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )
    dua,
    required TResult Function(String dhikrText, int targetCount) tasbih,
    required TResult Function() qibla,
  }) {
    return tasbih(dhikrText, targetCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult? Function(List<AyahEntry> ayahs)? quranAyah,
    TResult? Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult? Function(String dhikrText, int targetCount)? tasbih,
    TResult? Function()? qibla,
  }) {
    return tasbih?.call(dhikrText, targetCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult Function(List<AyahEntry> ayahs)? quranAyah,
    TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult Function(String dhikrText, int targetCount)? tasbih,
    TResult Function()? qibla,
    required TResult orElse(),
  }) {
    if (tasbih != null) {
      return tasbih(dhikrText, targetCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrayerTimesData value) prayerTimes,
    required TResult Function(QuranAyahData value) quranAyah,
    required TResult Function(DuaData value) dua,
    required TResult Function(TasbihData value) tasbih,
    required TResult Function(QiblaData value) qibla,
  }) {
    return tasbih(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrayerTimesData value)? prayerTimes,
    TResult? Function(QuranAyahData value)? quranAyah,
    TResult? Function(DuaData value)? dua,
    TResult? Function(TasbihData value)? tasbih,
    TResult? Function(QiblaData value)? qibla,
  }) {
    return tasbih?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrayerTimesData value)? prayerTimes,
    TResult Function(QuranAyahData value)? quranAyah,
    TResult Function(DuaData value)? dua,
    TResult Function(TasbihData value)? tasbih,
    TResult Function(QiblaData value)? qibla,
    required TResult orElse(),
  }) {
    if (tasbih != null) {
      return tasbih(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TasbihDataImplToJson(this);
  }
}

abstract class TasbihData implements ComponentData {
  const factory TasbihData({
    required final String dhikrText,
    final int targetCount,
  }) = _$TasbihDataImpl;

  factory TasbihData.fromJson(Map<String, dynamic> json) =
      _$TasbihDataImpl.fromJson;

  String get dhikrText;
  int get targetCount;

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasbihDataImplCopyWith<_$TasbihDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QiblaDataImplCopyWith<$Res> {
  factory _$$QiblaDataImplCopyWith(
    _$QiblaDataImpl value,
    $Res Function(_$QiblaDataImpl) then,
  ) = __$$QiblaDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QiblaDataImplCopyWithImpl<$Res>
    extends _$ComponentDataCopyWithImpl<$Res, _$QiblaDataImpl>
    implements _$$QiblaDataImplCopyWith<$Res> {
  __$$QiblaDataImplCopyWithImpl(
    _$QiblaDataImpl _value,
    $Res Function(_$QiblaDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComponentData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$QiblaDataImpl implements QiblaData {
  const _$QiblaDataImpl({final String? $type}) : $type = $type ?? 'qibla';

  factory _$QiblaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QiblaDataImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ComponentData.qibla()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QiblaDataImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PrayerTimeEntry> prayers, String date)
    prayerTimes,
    required TResult Function(List<AyahEntry> ayahs) quranAyah,
    required TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )
    dua,
    required TResult Function(String dhikrText, int targetCount) tasbih,
    required TResult Function() qibla,
  }) {
    return qibla();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult? Function(List<AyahEntry> ayahs)? quranAyah,
    TResult? Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult? Function(String dhikrText, int targetCount)? tasbih,
    TResult? Function()? qibla,
  }) {
    return qibla?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PrayerTimeEntry> prayers, String date)? prayerTimes,
    TResult Function(List<AyahEntry> ayahs)? quranAyah,
    TResult Function(
      String arabic,
      String transliteration,
      String translation,
      String source,
    )?
    dua,
    TResult Function(String dhikrText, int targetCount)? tasbih,
    TResult Function()? qibla,
    required TResult orElse(),
  }) {
    if (qibla != null) {
      return qibla();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrayerTimesData value) prayerTimes,
    required TResult Function(QuranAyahData value) quranAyah,
    required TResult Function(DuaData value) dua,
    required TResult Function(TasbihData value) tasbih,
    required TResult Function(QiblaData value) qibla,
  }) {
    return qibla(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrayerTimesData value)? prayerTimes,
    TResult? Function(QuranAyahData value)? quranAyah,
    TResult? Function(DuaData value)? dua,
    TResult? Function(TasbihData value)? tasbih,
    TResult? Function(QiblaData value)? qibla,
  }) {
    return qibla?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrayerTimesData value)? prayerTimes,
    TResult Function(QuranAyahData value)? quranAyah,
    TResult Function(DuaData value)? dua,
    TResult Function(TasbihData value)? tasbih,
    TResult Function(QiblaData value)? qibla,
    required TResult orElse(),
  }) {
    if (qibla != null) {
      return qibla(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QiblaDataImplToJson(this);
  }
}

abstract class QiblaData implements ComponentData {
  const factory QiblaData() = _$QiblaDataImpl;

  factory QiblaData.fromJson(Map<String, dynamic> json) =
      _$QiblaDataImpl.fromJson;
}

PrayerTimeEntry _$PrayerTimeEntryFromJson(Map<String, dynamic> json) {
  return _PrayerTimeEntry.fromJson(json);
}

/// @nodoc
mixin _$PrayerTimeEntry {
  String get name => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  bool get isNext => throw _privateConstructorUsedError;

  /// Serializes this PrayerTimeEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrayerTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrayerTimeEntryCopyWith<PrayerTimeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerTimeEntryCopyWith<$Res> {
  factory $PrayerTimeEntryCopyWith(
    PrayerTimeEntry value,
    $Res Function(PrayerTimeEntry) then,
  ) = _$PrayerTimeEntryCopyWithImpl<$Res, PrayerTimeEntry>;
  @useResult
  $Res call({String name, String time, bool isNext});
}

/// @nodoc
class _$PrayerTimeEntryCopyWithImpl<$Res, $Val extends PrayerTimeEntry>
    implements $PrayerTimeEntryCopyWith<$Res> {
  _$PrayerTimeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrayerTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? time = null, Object? isNext = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String,
            isNext: null == isNext
                ? _value.isNext
                : isNext // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrayerTimeEntryImplCopyWith<$Res>
    implements $PrayerTimeEntryCopyWith<$Res> {
  factory _$$PrayerTimeEntryImplCopyWith(
    _$PrayerTimeEntryImpl value,
    $Res Function(_$PrayerTimeEntryImpl) then,
  ) = __$$PrayerTimeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String time, bool isNext});
}

/// @nodoc
class __$$PrayerTimeEntryImplCopyWithImpl<$Res>
    extends _$PrayerTimeEntryCopyWithImpl<$Res, _$PrayerTimeEntryImpl>
    implements _$$PrayerTimeEntryImplCopyWith<$Res> {
  __$$PrayerTimeEntryImplCopyWithImpl(
    _$PrayerTimeEntryImpl _value,
    $Res Function(_$PrayerTimeEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrayerTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? time = null, Object? isNext = null}) {
    return _then(
      _$PrayerTimeEntryImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String,
        isNext: null == isNext
            ? _value.isNext
            : isNext // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerTimeEntryImpl implements _PrayerTimeEntry {
  const _$PrayerTimeEntryImpl({
    required this.name,
    required this.time,
    this.isNext = false,
  });

  factory _$PrayerTimeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerTimeEntryImplFromJson(json);

  @override
  final String name;
  @override
  final String time;
  @override
  @JsonKey()
  final bool isNext;

  @override
  String toString() {
    return 'PrayerTimeEntry(name: $name, time: $time, isNext: $isNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerTimeEntryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.isNext, isNext) || other.isNext == isNext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, time, isNext);

  /// Create a copy of PrayerTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerTimeEntryImplCopyWith<_$PrayerTimeEntryImpl> get copyWith =>
      __$$PrayerTimeEntryImplCopyWithImpl<_$PrayerTimeEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerTimeEntryImplToJson(this);
  }
}

abstract class _PrayerTimeEntry implements PrayerTimeEntry {
  const factory _PrayerTimeEntry({
    required final String name,
    required final String time,
    final bool isNext,
  }) = _$PrayerTimeEntryImpl;

  factory _PrayerTimeEntry.fromJson(Map<String, dynamic> json) =
      _$PrayerTimeEntryImpl.fromJson;

  @override
  String get name;
  @override
  String get time;
  @override
  bool get isNext;

  /// Create a copy of PrayerTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrayerTimeEntryImplCopyWith<_$PrayerTimeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AyahEntry _$AyahEntryFromJson(Map<String, dynamic> json) {
  return _AyahEntry.fromJson(json);
}

/// @nodoc
mixin _$AyahEntry {
  int get surah => throw _privateConstructorUsedError;
  int get ayah => throw _privateConstructorUsedError;
  String get arabic => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  /// Serializes this AyahEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AyahEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AyahEntryCopyWith<AyahEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AyahEntryCopyWith<$Res> {
  factory $AyahEntryCopyWith(AyahEntry value, $Res Function(AyahEntry) then) =
      _$AyahEntryCopyWithImpl<$Res, AyahEntry>;
  @useResult
  $Res call({int surah, int ayah, String arabic, String translation});
}

/// @nodoc
class _$AyahEntryCopyWithImpl<$Res, $Val extends AyahEntry>
    implements $AyahEntryCopyWith<$Res> {
  _$AyahEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AyahEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surah = null,
    Object? ayah = null,
    Object? arabic = null,
    Object? translation = null,
  }) {
    return _then(
      _value.copyWith(
            surah: null == surah
                ? _value.surah
                : surah // ignore: cast_nullable_to_non_nullable
                      as int,
            ayah: null == ayah
                ? _value.ayah
                : ayah // ignore: cast_nullable_to_non_nullable
                      as int,
            arabic: null == arabic
                ? _value.arabic
                : arabic // ignore: cast_nullable_to_non_nullable
                      as String,
            translation: null == translation
                ? _value.translation
                : translation // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AyahEntryImplCopyWith<$Res>
    implements $AyahEntryCopyWith<$Res> {
  factory _$$AyahEntryImplCopyWith(
    _$AyahEntryImpl value,
    $Res Function(_$AyahEntryImpl) then,
  ) = __$$AyahEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int surah, int ayah, String arabic, String translation});
}

/// @nodoc
class __$$AyahEntryImplCopyWithImpl<$Res>
    extends _$AyahEntryCopyWithImpl<$Res, _$AyahEntryImpl>
    implements _$$AyahEntryImplCopyWith<$Res> {
  __$$AyahEntryImplCopyWithImpl(
    _$AyahEntryImpl _value,
    $Res Function(_$AyahEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AyahEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surah = null,
    Object? ayah = null,
    Object? arabic = null,
    Object? translation = null,
  }) {
    return _then(
      _$AyahEntryImpl(
        surah: null == surah
            ? _value.surah
            : surah // ignore: cast_nullable_to_non_nullable
                  as int,
        ayah: null == ayah
            ? _value.ayah
            : ayah // ignore: cast_nullable_to_non_nullable
                  as int,
        arabic: null == arabic
            ? _value.arabic
            : arabic // ignore: cast_nullable_to_non_nullable
                  as String,
        translation: null == translation
            ? _value.translation
            : translation // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AyahEntryImpl implements _AyahEntry {
  const _$AyahEntryImpl({
    required this.surah,
    required this.ayah,
    required this.arabic,
    required this.translation,
  });

  factory _$AyahEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AyahEntryImplFromJson(json);

  @override
  final int surah;
  @override
  final int ayah;
  @override
  final String arabic;
  @override
  final String translation;

  @override
  String toString() {
    return 'AyahEntry(surah: $surah, ayah: $ayah, arabic: $arabic, translation: $translation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AyahEntryImpl &&
            (identical(other.surah, surah) || other.surah == surah) &&
            (identical(other.ayah, ayah) || other.ayah == ayah) &&
            (identical(other.arabic, arabic) || other.arabic == arabic) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, surah, ayah, arabic, translation);

  /// Create a copy of AyahEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AyahEntryImplCopyWith<_$AyahEntryImpl> get copyWith =>
      __$$AyahEntryImplCopyWithImpl<_$AyahEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AyahEntryImplToJson(this);
  }
}

abstract class _AyahEntry implements AyahEntry {
  const factory _AyahEntry({
    required final int surah,
    required final int ayah,
    required final String arabic,
    required final String translation,
  }) = _$AyahEntryImpl;

  factory _AyahEntry.fromJson(Map<String, dynamic> json) =
      _$AyahEntryImpl.fromJson;

  @override
  int get surah;
  @override
  int get ayah;
  @override
  String get arabic;
  @override
  String get translation;

  /// Create a copy of AyahEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AyahEntryImplCopyWith<_$AyahEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_time_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PrayerTimeModel _$PrayerTimeModelFromJson(Map<String, dynamic> json) {
  return _PrayerTimeModel.fromJson(json);
}

/// @nodoc
mixin _$PrayerTimeModel {
  DateTime get fajr => throw _privateConstructorUsedError;
  DateTime get sunrise => throw _privateConstructorUsedError;
  DateTime get dhuhr => throw _privateConstructorUsedError;
  DateTime get asr => throw _privateConstructorUsedError;
  DateTime get maghrib => throw _privateConstructorUsedError;
  DateTime get isha => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this PrayerTimeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrayerTimeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrayerTimeModelCopyWith<PrayerTimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerTimeModelCopyWith<$Res> {
  factory $PrayerTimeModelCopyWith(
    PrayerTimeModel value,
    $Res Function(PrayerTimeModel) then,
  ) = _$PrayerTimeModelCopyWithImpl<$Res, PrayerTimeModel>;
  @useResult
  $Res call({
    DateTime fajr,
    DateTime sunrise,
    DateTime dhuhr,
    DateTime asr,
    DateTime maghrib,
    DateTime isha,
    DateTime date,
  });
}

/// @nodoc
class _$PrayerTimeModelCopyWithImpl<$Res, $Val extends PrayerTimeModel>
    implements $PrayerTimeModelCopyWith<$Res> {
  _$PrayerTimeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrayerTimeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fajr = null,
    Object? sunrise = null,
    Object? dhuhr = null,
    Object? asr = null,
    Object? maghrib = null,
    Object? isha = null,
    Object? date = null,
  }) {
    return _then(
      _value.copyWith(
            fajr: null == fajr
                ? _value.fajr
                : fajr // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            sunrise: null == sunrise
                ? _value.sunrise
                : sunrise // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dhuhr: null == dhuhr
                ? _value.dhuhr
                : dhuhr // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            asr: null == asr
                ? _value.asr
                : asr // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            maghrib: null == maghrib
                ? _value.maghrib
                : maghrib // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isha: null == isha
                ? _value.isha
                : isha // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrayerTimeModelImplCopyWith<$Res>
    implements $PrayerTimeModelCopyWith<$Res> {
  factory _$$PrayerTimeModelImplCopyWith(
    _$PrayerTimeModelImpl value,
    $Res Function(_$PrayerTimeModelImpl) then,
  ) = __$$PrayerTimeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime fajr,
    DateTime sunrise,
    DateTime dhuhr,
    DateTime asr,
    DateTime maghrib,
    DateTime isha,
    DateTime date,
  });
}

/// @nodoc
class __$$PrayerTimeModelImplCopyWithImpl<$Res>
    extends _$PrayerTimeModelCopyWithImpl<$Res, _$PrayerTimeModelImpl>
    implements _$$PrayerTimeModelImplCopyWith<$Res> {
  __$$PrayerTimeModelImplCopyWithImpl(
    _$PrayerTimeModelImpl _value,
    $Res Function(_$PrayerTimeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrayerTimeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fajr = null,
    Object? sunrise = null,
    Object? dhuhr = null,
    Object? asr = null,
    Object? maghrib = null,
    Object? isha = null,
    Object? date = null,
  }) {
    return _then(
      _$PrayerTimeModelImpl(
        fajr: null == fajr
            ? _value.fajr
            : fajr // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        sunrise: null == sunrise
            ? _value.sunrise
            : sunrise // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dhuhr: null == dhuhr
            ? _value.dhuhr
            : dhuhr // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        asr: null == asr
            ? _value.asr
            : asr // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        maghrib: null == maghrib
            ? _value.maghrib
            : maghrib // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isha: null == isha
            ? _value.isha
            : isha // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerTimeModelImpl implements _PrayerTimeModel {
  const _$PrayerTimeModelImpl({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
  });

  factory _$PrayerTimeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerTimeModelImplFromJson(json);

  @override
  final DateTime fajr;
  @override
  final DateTime sunrise;
  @override
  final DateTime dhuhr;
  @override
  final DateTime asr;
  @override
  final DateTime maghrib;
  @override
  final DateTime isha;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'PrayerTimeModel(fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerTimeModelImpl &&
            (identical(other.fajr, fajr) || other.fajr == fajr) &&
            (identical(other.sunrise, sunrise) || other.sunrise == sunrise) &&
            (identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr) &&
            (identical(other.asr, asr) || other.asr == asr) &&
            (identical(other.maghrib, maghrib) || other.maghrib == maghrib) &&
            (identical(other.isha, isha) || other.isha == isha) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fajr, sunrise, dhuhr, asr, maghrib, isha, date);

  /// Create a copy of PrayerTimeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerTimeModelImplCopyWith<_$PrayerTimeModelImpl> get copyWith =>
      __$$PrayerTimeModelImplCopyWithImpl<_$PrayerTimeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerTimeModelImplToJson(this);
  }
}

abstract class _PrayerTimeModel implements PrayerTimeModel {
  const factory _PrayerTimeModel({
    required final DateTime fajr,
    required final DateTime sunrise,
    required final DateTime dhuhr,
    required final DateTime asr,
    required final DateTime maghrib,
    required final DateTime isha,
    required final DateTime date,
  }) = _$PrayerTimeModelImpl;

  factory _PrayerTimeModel.fromJson(Map<String, dynamic> json) =
      _$PrayerTimeModelImpl.fromJson;

  @override
  DateTime get fajr;
  @override
  DateTime get sunrise;
  @override
  DateTime get dhuhr;
  @override
  DateTime get asr;
  @override
  DateTime get maghrib;
  @override
  DateTime get isha;
  @override
  DateTime get date;

  /// Create a copy of PrayerTimeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrayerTimeModelImplCopyWith<_$PrayerTimeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

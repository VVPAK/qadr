// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'llm_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LlmResponse _$LlmResponseFromJson(Map<String, dynamic> json) {
  return _LlmResponse.fromJson(json);
}

/// @nodoc
mixin _$LlmResponse {
  ChatIntent get intent => throw _privateConstructorUsedError;
  ResponseType get responseType => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  ComponentPayload? get component => throw _privateConstructorUsedError;

  /// Serializes this LlmResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LlmResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LlmResponseCopyWith<LlmResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LlmResponseCopyWith<$Res> {
  factory $LlmResponseCopyWith(
    LlmResponse value,
    $Res Function(LlmResponse) then,
  ) = _$LlmResponseCopyWithImpl<$Res, LlmResponse>;
  @useResult
  $Res call({
    ChatIntent intent,
    ResponseType responseType,
    String? text,
    ComponentPayload? component,
  });

  $ComponentPayloadCopyWith<$Res>? get component;
}

/// @nodoc
class _$LlmResponseCopyWithImpl<$Res, $Val extends LlmResponse>
    implements $LlmResponseCopyWith<$Res> {
  _$LlmResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LlmResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = null,
    Object? responseType = null,
    Object? text = freezed,
    Object? component = freezed,
  }) {
    return _then(
      _value.copyWith(
            intent: null == intent
                ? _value.intent
                : intent // ignore: cast_nullable_to_non_nullable
                      as ChatIntent,
            responseType: null == responseType
                ? _value.responseType
                : responseType // ignore: cast_nullable_to_non_nullable
                      as ResponseType,
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            component: freezed == component
                ? _value.component
                : component // ignore: cast_nullable_to_non_nullable
                      as ComponentPayload?,
          )
          as $Val,
    );
  }

  /// Create a copy of LlmResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComponentPayloadCopyWith<$Res>? get component {
    if (_value.component == null) {
      return null;
    }

    return $ComponentPayloadCopyWith<$Res>(_value.component!, (value) {
      return _then(_value.copyWith(component: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LlmResponseImplCopyWith<$Res>
    implements $LlmResponseCopyWith<$Res> {
  factory _$$LlmResponseImplCopyWith(
    _$LlmResponseImpl value,
    $Res Function(_$LlmResponseImpl) then,
  ) = __$$LlmResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ChatIntent intent,
    ResponseType responseType,
    String? text,
    ComponentPayload? component,
  });

  @override
  $ComponentPayloadCopyWith<$Res>? get component;
}

/// @nodoc
class __$$LlmResponseImplCopyWithImpl<$Res>
    extends _$LlmResponseCopyWithImpl<$Res, _$LlmResponseImpl>
    implements _$$LlmResponseImplCopyWith<$Res> {
  __$$LlmResponseImplCopyWithImpl(
    _$LlmResponseImpl _value,
    $Res Function(_$LlmResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LlmResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = null,
    Object? responseType = null,
    Object? text = freezed,
    Object? component = freezed,
  }) {
    return _then(
      _$LlmResponseImpl(
        intent: null == intent
            ? _value.intent
            : intent // ignore: cast_nullable_to_non_nullable
                  as ChatIntent,
        responseType: null == responseType
            ? _value.responseType
            : responseType // ignore: cast_nullable_to_non_nullable
                  as ResponseType,
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        component: freezed == component
            ? _value.component
            : component // ignore: cast_nullable_to_non_nullable
                  as ComponentPayload?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LlmResponseImpl implements _LlmResponse {
  const _$LlmResponseImpl({
    required this.intent,
    required this.responseType,
    this.text,
    this.component,
  });

  factory _$LlmResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LlmResponseImplFromJson(json);

  @override
  final ChatIntent intent;
  @override
  final ResponseType responseType;
  @override
  final String? text;
  @override
  final ComponentPayload? component;

  @override
  String toString() {
    return 'LlmResponse(intent: $intent, responseType: $responseType, text: $text, component: $component)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LlmResponseImpl &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.responseType, responseType) ||
                other.responseType == responseType) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.component, component) ||
                other.component == component));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, intent, responseType, text, component);

  /// Create a copy of LlmResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LlmResponseImplCopyWith<_$LlmResponseImpl> get copyWith =>
      __$$LlmResponseImplCopyWithImpl<_$LlmResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LlmResponseImplToJson(this);
  }
}

abstract class _LlmResponse implements LlmResponse {
  const factory _LlmResponse({
    required final ChatIntent intent,
    required final ResponseType responseType,
    final String? text,
    final ComponentPayload? component,
  }) = _$LlmResponseImpl;

  factory _LlmResponse.fromJson(Map<String, dynamic> json) =
      _$LlmResponseImpl.fromJson;

  @override
  ChatIntent get intent;
  @override
  ResponseType get responseType;
  @override
  String? get text;
  @override
  ComponentPayload? get component;

  /// Create a copy of LlmResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LlmResponseImplCopyWith<_$LlmResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComponentPayload _$ComponentPayloadFromJson(Map<String, dynamic> json) {
  return _ComponentPayload.fromJson(json);
}

/// @nodoc
mixin _$ComponentPayload {
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this ComponentPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComponentPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComponentPayloadCopyWith<ComponentPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentPayloadCopyWith<$Res> {
  factory $ComponentPayloadCopyWith(
    ComponentPayload value,
    $Res Function(ComponentPayload) then,
  ) = _$ComponentPayloadCopyWithImpl<$Res, ComponentPayload>;
  @useResult
  $Res call({String type, Map<String, dynamic> data});
}

/// @nodoc
class _$ComponentPayloadCopyWithImpl<$Res, $Val extends ComponentPayload>
    implements $ComponentPayloadCopyWith<$Res> {
  _$ComponentPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComponentPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ComponentPayloadImplCopyWith<$Res>
    implements $ComponentPayloadCopyWith<$Res> {
  factory _$$ComponentPayloadImplCopyWith(
    _$ComponentPayloadImpl value,
    $Res Function(_$ComponentPayloadImpl) then,
  ) = __$$ComponentPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> data});
}

/// @nodoc
class __$$ComponentPayloadImplCopyWithImpl<$Res>
    extends _$ComponentPayloadCopyWithImpl<$Res, _$ComponentPayloadImpl>
    implements _$$ComponentPayloadImplCopyWith<$Res> {
  __$$ComponentPayloadImplCopyWithImpl(
    _$ComponentPayloadImpl _value,
    $Res Function(_$ComponentPayloadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComponentPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? data = null}) {
    return _then(
      _$ComponentPayloadImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ComponentPayloadImpl implements _ComponentPayload {
  const _$ComponentPayloadImpl({
    required this.type,
    required final Map<String, dynamic> data,
  }) : _data = data;

  factory _$ComponentPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComponentPayloadImplFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'ComponentPayload(type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComponentPayloadImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of ComponentPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComponentPayloadImplCopyWith<_$ComponentPayloadImpl> get copyWith =>
      __$$ComponentPayloadImplCopyWithImpl<_$ComponentPayloadImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ComponentPayloadImplToJson(this);
  }
}

abstract class _ComponentPayload implements ComponentPayload {
  const factory _ComponentPayload({
    required final String type,
    required final Map<String, dynamic> data,
  }) = _$ComponentPayloadImpl;

  factory _ComponentPayload.fromJson(Map<String, dynamic> json) =
      _$ComponentPayloadImpl.fromJson;

  @override
  String get type;
  @override
  Map<String, dynamic> get data;

  /// Create a copy of ComponentPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComponentPayloadImplCopyWith<_$ComponentPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/islamic_constants.dart';

part 'llm_response.freezed.dart';
part 'llm_response.g.dart';

enum ResponseType { text, component }

@freezed
class LlmResponse with _$LlmResponse {
  const factory LlmResponse({
    required ChatIntent intent,
    required ResponseType responseType,
    String? text,
    ComponentPayload? component,
  }) = _LlmResponse;

  factory LlmResponse.fromJson(Map<String, dynamic> json) =>
      _$LlmResponseFromJson(json);
}

@freezed
class ComponentPayload with _$ComponentPayload {
  const factory ComponentPayload({
    required String type,
    required Map<String, dynamic> data,
  }) = _ComponentPayload;

  factory ComponentPayload.fromJson(Map<String, dynamic> json) =>
      _$ComponentPayloadFromJson(json);
}

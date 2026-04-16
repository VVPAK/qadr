// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LlmResponseImpl _$$LlmResponseImplFromJson(Map<String, dynamic> json) =>
    _$LlmResponseImpl(
      intent: $enumDecode(_$ChatIntentEnumMap, json['intent']),
      responseType: $enumDecode(_$ResponseTypeEnumMap, json['responseType']),
      text: json['text'] as String?,
      component: json['component'] == null
          ? null
          : ComponentPayload.fromJson(
              json['component'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$LlmResponseImplToJson(_$LlmResponseImpl instance) =>
    <String, dynamic>{
      'intent': _$ChatIntentEnumMap[instance.intent]!,
      'responseType': _$ResponseTypeEnumMap[instance.responseType]!,
      'text': instance.text,
      'component': instance.component,
    };

const _$ChatIntentEnumMap = {
  ChatIntent.prayerTime: 'prayerTime',
  ChatIntent.quranSearch: 'quranSearch',
  ChatIntent.duaRequest: 'duaRequest',
  ChatIntent.tasbih: 'tasbih',
  ChatIntent.qibla: 'qibla',
  ChatIntent.generalQuestion: 'generalQuestion',
};

const _$ResponseTypeEnumMap = {
  ResponseType.text: 'text',
  ResponseType.component: 'component',
};

_$ComponentPayloadImpl _$$ComponentPayloadImplFromJson(
  Map<String, dynamic> json,
) => _$ComponentPayloadImpl(
  type: json['type'] as String,
  data: json['data'] as Map<String, dynamic>,
);

Map<String, dynamic> _$$ComponentPayloadImplToJson(
  _$ComponentPayloadImpl instance,
) => <String, dynamic>{'type': instance.type, 'data': instance.data};

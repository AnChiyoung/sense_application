// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dummy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as int?,
      eventTitle: json['eventTitle'] as String?,
      eventDate: json['eventDate'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventTitle': instance.eventTitle,
      'eventDate': instance.eventDate,
      'created': instance.created,
    };

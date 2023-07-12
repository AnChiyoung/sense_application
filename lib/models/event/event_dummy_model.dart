import 'package:json_annotation/json_annotation.dart';
part 'event_dummy_model.g.dart';

@JsonSerializable()
  // checked: true, createFactory: true, fieldRename: FieldRename.snake)
// )
class EventModel {
  int? id;
  String? eventTitle;
  String? eventDate;
  String? created;

  EventModel({
    this.id,
    this.eventTitle,
    this.eventDate,
    this.created,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return _$EventModelFromJson(json);
  }
}
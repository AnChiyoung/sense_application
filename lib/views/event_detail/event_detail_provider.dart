
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';

class EDProvider with ChangeNotifier {
  EventModel _eventModel = EventModel();
  EventModel get eventModel => _eventModel;

  void setEventModel({required EventModel eventModel, int? test}) async {
    _eventModel = eventModel;
  }

  void setAndNotifyEventModel({required eventModel}) async {
    _eventModel = eventModel;
    notifyListeners();
  }

  void toggleEventAlarm( int eventId, bool value ) async {
    Map<String, dynamic> payload = { 'is_alarm': value };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;
    _eventModel.isAlarm = value;
    notifyListeners();
  }

  void toggleEventPublic(int eventId, bool value) async {
    String nextValue = value ? 'PUBLIC' : 'PRIVATE';
    Map<String, dynamic> payload = { 'public_type': nextValue };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;
    _eventModel.publicType = nextValue;
    notifyListeners();
  }

  Future<bool> deleteEvent(int eventId) async {
    bool result = await EventRequest().deleteEvent(eventId);
    return result;
  }

  void clearEventModal(bool notify) async {
    _eventModel = EventModel();
    if (notify) notifyListeners();
  }
}


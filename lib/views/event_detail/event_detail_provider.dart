
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';


enum EnumEventDetailTab {
  plan("계획", 'PLAN'),
  recommend("추천", 'RECOMMEND');

  final String label;
  final String value;  
  const EnumEventDetailTab(this.label, this.value);    
}

class EDProvider with ChangeNotifier {
  EventModel _eventModel = EventModel();
  EventModel get eventModel => _eventModel;

  EnumEventDetailTab _eventDetailTabState = EnumEventDetailTab.plan;
  EnumEventDetailTab get eventDetailTabState => _eventDetailTabState;

  void setEventModel(EventModel eventModel, bool notify) async {
    _eventModel = eventModel;
    if (notify) notifyListeners();
  }

  void toggleEventAlarm(int eventId, bool value, bool notify) async {
    Map<String, dynamic> payload = { 'is_alarm': value };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    _eventModel.isAlarm = value;
    if (notify) notifyListeners();
  }

  void toggleEventPublic(int eventId, bool value, bool notify) async {
    String nextValue = value ? 'PUBLIC' : 'PRIVATE';
    Map<String, dynamic> payload = { 'public_type': nextValue };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;
    
    _eventModel.publicType = nextValue;
    if (notify) notifyListeners();
  }

  Future<bool> deleteEvent(int eventId, bool notify) async {
    bool result = await EventRequest().deleteEvent(eventId);
    if (notify) notifyListeners();
    return result;
  }

  void clearEventModal(bool notify) async {
    _eventModel = EventModel();
    if (notify) notifyListeners();
  }

  void setEventDetailTabState(EnumEventDetailTab tabState, bool notify) {
    _eventDetailTabState = tabState;
    if (notify) notifyListeners();
  }

  void changeEventTitle(int eventId, String value, bool notify) async {
    Map<String, dynamic> payload = { 'title': value };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    _eventModel.eventTitle = value;
    if (notify) notifyListeners();
  }
}


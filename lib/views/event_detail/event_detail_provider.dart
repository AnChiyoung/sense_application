
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';


enum EnumEventDetailTab {
  plan("계획", 'PLAN'),
  recommend("추천", 'RECOMMEND');

  final String label;
  final String value;  
  const EnumEventDetailTab(this.label, this.value);    
}

enum EnumEventDetailBottomSheetField {
  category("유형", 'CATEGORY', '이벤트 유형'),
  target("대상", 'TARGET', '이벤트 대상'),
  date("날짜", 'DATE', '날짜 선택'),
  region("위치", 'REGION', '지역 선택');

  final String label;
  final String value;
  final String bottomSheetTitle;
  const EnumEventDetailBottomSheetField(this.label, this.value, this.bottomSheetTitle);    
}

enum EnumEventCategory {
  birthday(1, "생일"),
  date(2, "데이트"),
  travel(3, "여행"),
  meeting(4, "모임",),
  business(5, "비즈니스");

  final int id;
  final String title;
  const EnumEventCategory(this.id, this.title);
}

class EDProvider with ChangeNotifier {
  EventModel _eventModel = EventModel();
  EventModel get eventModel => _eventModel;

  EnumEventDetailTab _eventDetailTabState = EnumEventDetailTab.plan;
  EnumEventDetailTab get eventDetailTabState => _eventDetailTabState;

  EnumEventDetailBottomSheetField? _eventDetailBottomSheetField;
  EnumEventDetailBottomSheetField? get eventDetailBottomSheetField => _eventDetailBottomSheetField;

  int _categoryId = -1;
  int get categoryId => _categoryId;

  void initState(EventModel eventModel, bool notify) {
    setEventModel(eventModel, notify);
    setCategoryId(eventModel.eventCategoryObject?.id ?? -1, notify);
  }

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

  void changeEventTitle(int eventId, String value, bool notify) async {
    Map<String, dynamic> payload = { 'title': value };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    _eventModel.eventTitle = value;
    if (notify) notifyListeners();
  }

  void setEventDetailTabState(EnumEventDetailTab tabState, bool notify) {
    _eventDetailTabState = tabState;
    if (notify) notifyListeners();
  }

  void setEventDetailBottomSheetField(EnumEventDetailBottomSheetField field, bool notify) {
    _eventDetailBottomSheetField = field;
    if (notify) notifyListeners();
  }

  void setCategoryId(int categoryId, bool notify) {
    _categoryId = categoryId;
    if (notify) notifyListeners();
  }

  void changeEventCategory(int eventId, int categoryId, bool notify) async {
    Map<String, dynamic> payload = { 'event_category': categoryId };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    _eventModel.eventCategoryObject = EventCategory(
      id: categoryId,
      title: EnumEventCategory.values.firstWhere((element) => element.id == categoryId).title
    );
    if (notify) notifyListeners();
  }
}



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

enum EnumEventTarget {
  friend(1, "친구"),
  family(2, "가족"),
  lover(3, "연인"),
  work(4, "직장");

  final int id;
  final String title;
  const EnumEventTarget(this.id, this.title);
}

enum EnumEventCity {
  seoul(1, "서울"), gyeonggi(2, "경기도"), incheon(3, "인천"), gangwon(4, "강원도"), jeolla(5, "전라도"), gyeongsang(6, "경상도"), chungcheong(7, "충청도"), busan(8, "부산"), jeju(9, "제주");

  final int id;
  final String title;
  const EnumEventCity(this.id, this.title);
}

enum EnumEventSubCity {
  gangnam(1, "강남", 1), samsung(2, "삼성", 1), songpa(3, "송파", 1), gyodae(4, "교대", 1), cityhall(5, "시청", 1), myeongdong(6, "명동", 1), jongro(7, "종로", 1), insadong(8, "인사동", 1), dongdaemun(9, "동대문", 1), gangbuk(10, "강북", 1),
  suwon(22, "수원", 2), ingye(23, "인계", 2), dongtan(24, "동탄", 2), yongin(25, "용인", 2), yeoju(26, "여주", 2), ichoen(27, "이천", 2), bucheon(28, "부천", 2), seongnam(29, "성남", 2), anyang(30, "안양", 2), goyang(31, "고양", 2),
  songdo(38, "송도", 3), sorae(39, "소래포구", 3), guwol(40, "구월", 3), incheonAirport(41, "인천공항", 3), yeongjong(42, "영종도", 3), wolmi(43, "월미도", 3), bupyeong(44, "부평", 3), gyeyang(45, "계양", 3), seogu(46, "서구", 3), ganghwa(47, "강화", 3),
  sokcho(49, "속초", 4), yangyang(50, "양양", 4), gosung(51, "고성", 4), gangneung(52, "강릉", 4), donghae(53, "동해", 4), samcheok(54, "삼척", 4), pyeongchang(55, "평창", 4), jeongseon(56, "정선", 4), wonju(57, "원주", 4), hoengseong(58, "횡성", 4),
  yeosu(63, '여수', 5), gwangyang(64, '광양', 5), suncheon(65, '순천', 5), jeonju(66, '전주', 5), gunsan(67, '군산', 5), buan(68, '부안', 5), namwon(69, '남원', 5), gwangju(70, '광주', 5), mokpo(71, '목포', 5), naju(72, '나주', 5),
  gyeongju(74, '경주', 6), pochang(75, '포항', 6), yeongdeok(76, '영덕', 6), ulsan(77, '울산', 6), changwon(78, '창원', 6), gimhae(79, '김해', 6), jinju(80, '진주', 6), daegu(81, '대구', 6), mungyeong(82, '문경', 6), gumi(83, '구미', 6),
  yuseong(85, '유성구', 7), cheongju(86, '청주', 7), sejong(87, '세종', 7), cheonan(88, '천안', 7), asan(89, '아산', 7), danyang(90, '단양', 7), chungju(91, '충주', 7), jecheon(92, '제천', 7), goesan(93, '괴산', 7), anmyeondo(94, '안면도', 7),
  haeundae(97, '해운대', 8), centum(98, '센텀', 8), songjeong(99, '송정', 8), gijang(100, '기장', 8), gwangan(101, '광안리', 8), yeonje(102, '연제', 8), busanStation(103, '부산역', 8), nampho(104, '남포동', 8), jagalchi(105, '자갈치', 8), seomyeon(106, '서면', 8),
  jejuAirport(113, '제주공항', 9), hyeopjae(114, '협재', 9), hamdeok(115, '함덕', 9), jungmun(116, '중문', 9), pyoseon(117, '표선', 9), seongsan(118, '성산', 9);
  

  final int id;
  final String title;
  final int cityId;
  const EnumEventSubCity(this.id, this.title, this.cityId);
}

class EDProvider with ChangeNotifier {
  EventModel _eventModel = EventModel();
  EventModel get eventModel => _eventModel;

  EnumEventDetailTab _eventDetailTabState = EnumEventDetailTab.plan;
  EnumEventDetailTab get eventDetailTabState => _eventDetailTabState;

  EnumEventDetailBottomSheetField? _eventDetailBottomSheetField;
  EnumEventDetailBottomSheetField? get eventDetailBottomSheetField => _eventDetailBottomSheetField;

  EnumEventCategory? _category;
  EnumEventCategory? get category => _category;

  EnumEventTarget? _target;
  EnumEventTarget? get target => _target;

  DateTime? _date = DateTime.now();
  DateTime? get date => _date;

  EnumEventCity? _city;
  EnumEventCity? get city => _city;
  EnumEventSubCity? _subCity;
  EnumEventSubCity? get subCity => _subCity;
  EnumEventCity? _dropdownCity;
  EnumEventCity? get dropdownCity => _dropdownCity;

  List<EnumEventSubCity> _subCityList = EnumEventSubCity.values.where((e) => e.cityId == 1).map((e) => e).toList();
  List<EnumEventSubCity> get subCityList => _subCityList;

  void initState(EventModel eventModel, bool notify) {
    setEventModel(eventModel, false);

    if (eventModel.eventCategoryObject?.id != null && eventModel.eventCategoryObject!.id! > 0) {
      setCategory(EnumEventCategory.values.firstWhere((element) => element.id == eventModel.eventCategoryObject?.id),false);
    }

    if (eventModel.targetCategoryObject?.id != null && eventModel.targetCategoryObject!.id! > 0) {
      setTarget(EnumEventTarget.values.firstWhere((element) => element.id == eventModel.targetCategoryObject?.id), false);
    }

    if (eventModel.city?.id != null && eventModel.city!.id! > 0) {
      setCity(EnumEventCity.values.firstWhere((element) => element.id == eventModel.city?.id), false);
      setDropdownCity(EnumEventCity.values.firstWhere((element) => element.id == eventModel.city?.id), false);
    }

    if (eventModel.subCity?.id != null && eventModel.subCity!.id! > 0) {
      setSubCity(EnumEventSubCity.values.firstWhere((element) => element.id == eventModel.subCity?.id), false);
    }

    if (eventModel.eventDate != null && eventModel.eventDate != '') {
      setDate(DateTime.parse(eventModel.eventDate!), false);
    }

    if (notify) notifyListeners();
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

  void setCategory(EnumEventCategory? category, bool notify) {
    _category = category;
    if (notify) notifyListeners();
  }

  void changeEventCategory(int eventId, EnumEventCategory category, bool notify) async {
    Map<String, dynamic> payload = { 'event_category': category.id };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    _eventModel.eventCategoryObject = EventCategory(id: category.id, title: category.title);
    if (notify) notifyListeners();
  }

  void setTarget(EnumEventTarget? target, bool notify) {
    _target = target;
    if (notify) notifyListeners();
  }

  void changeEventTarget(int eventId, EnumEventTarget target, bool notify) async {
    Map<String, dynamic> payload = { 'contact_category': target.id };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    _eventModel.targetCategoryObject = ContactCategory(id: target.id, title: target.title);
    if (notify) notifyListeners();
  }

  void setCity(EnumEventCity? city, bool notify) {
    _city = city;
    if (notify) notifyListeners();
  }
  void setSubCity(EnumEventSubCity? subCity, bool notify) {
    _subCity = subCity;
    if (notify) notifyListeners();
  }

  void changeEventRegion(int eventId, EnumEventCity city, EnumEventSubCity? subCity, bool notify) async {
    Map<String, dynamic> payload;
    if (subCity == null) {
      payload = { 'city': city.id };
    } else {
      payload = { 'city': city.id, 'sub_city': subCity.id };
    }
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    if (subCity == null) {
      _eventModel.city = City(id: city.id, title: city.title);
      _eventModel.subCity = null;
    } else {
      _eventModel.city = City(id: city.id, title: city.title);
      _eventModel.subCity = SubCity(id: subCity.id, title: subCity.title);
    }
    if (notify) notifyListeners();
  }

  void setDropdownCity(EnumEventCity city, bool notify) {
    _dropdownCity = city;
    _subCityList = EnumEventSubCity.values.where((e) => e.cityId == city.id).map((e) => e).toList();
    if (notify) notifyListeners();
  }

  void selectTotalCity(EnumEventCity? dropdownCity, bool notify) {
    if (dropdownCity == null) return;
    setCity(dropdownCity, false);
    setSubCity(null, false);

    if (notify) notifyListeners();
  }

  void selectSubCity(EnumEventSubCity subCity, bool notify) {
    setCity(EnumEventCity.values.firstWhere((element) => element.id == subCity.cityId), false);
    setSubCity(subCity, false);

    if (notify) notifyListeners();
  }


  void setDate(DateTime data, bool notify) {
    _date = data;
    if (notify) notifyListeners();
  }

  void changeDate(int eventId, DateTime date, bool notify) async {
    Map<String, dynamic> payload;
    payload = { 'date': DateFormat('yyyy-MM-dd').format(date) };
    bool result = await EventRequest().personalFieldUpdateEvent2(eventId, payload);
    if (!result) return;

    _eventModel.eventDate = DateFormat('yyyy-MM-dd').format(date);
    if (notify) notifyListeners();
  }

  // clear 언제 호출함?
  void clear(bool notify) {
    _eventModel = EventModel();
    _eventDetailTabState = EnumEventDetailTab.plan;
    _eventDetailBottomSheetField = null;
    _category = null;
    _target = null;
    _city = null;
    _subCity = null;
    _dropdownCity = null;
    _subCityList = EnumEventSubCity.values.where((e) => e.cityId == 1).map((e) => e).toList();
  }
}


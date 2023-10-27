import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class EventRequest {

  /// event list load
  Future<List<EventModel>> eventListRequest([int? selectMonth, int? selectYear]) async {

    String monthQuery = '';
    String yearQuery = '';

    if(selectMonth != null) {
      monthQuery = '?month=${selectMonth.toString()}';
    }

    if(selectYear != null) {
      yearQuery = '&year=${selectYear.toString()}';
    }

    SenseLogger().debug('${ApiUrl.releaseUrl}/events$monthQuery$yearQuery');

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/events$monthQuery$yearQuery&is_participated=true'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to event list load');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<EventModel> models = body.isEmpty || body == null ? [] : body.map((e) => EventModel.fromJson(e)).toList();;
      return models;
    } else {
      SenseLogger().debug('fail to event list load');
      return [];
    }
  }

  /// personal event load
  Future<EventModel> eventRequest(int eventId) async {

    // print('event id : ${eventId.toString()}');

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to personal event load');
      // print('logger');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      // print(jsonResult);
      EventModel eventModel = EventModel.fromPersonalJson(jsonResult);
      return eventModel;
    } else {
      SenseLogger().debug('fail to personal event load');
      return EventModel();
    }
  }

  Future<EventModel> eventRecommendRequest(int eventId) async {

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to personal event recommend info load');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      EventModel model = EventModel.fromPersonalJson(jsonResult);
      return model;
    } else {
      SenseLogger().debug('fail to personal event recommend info load');
      return EventModel();
    }
  }

  /// event create
  Future<bool> eventCreateRequest(BuildContext context) async {

    Map<String, dynamic> createModel = {};
    createModel.clear();
    context.read<CEProvider>().title == '' ? {} : createModel['title'] = context.read<CEProvider>().title;
    context.read<CEProvider>().category == -1 ? {} : createModel['event_category'] = context.read<CEProvider>().category + 1;
    context.read<CEProvider>().target == -1 ? {} : createModel['contact_category'] = context.read<CEProvider>().target + 1;
    context.read<CEProvider>().date == '' ? {} : createModel['date'] = context.read<CEProvider>().date;
    context.read<CEProvider>().city == -1 ? {} : createModel['city'] = context.read<CEProvider>().city + 1;
    // context.read<CEProvider>().saveSubCity.isEmpty ? {} : createModel['sub_city'] = context.read<CEProvider>().saveSubCity;
    context.read<CEProvider>().memo == '' ? {} : createModel['description'] = context.read<CEProvider>().memo;

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/event'),
      body: jsonEncode(createModel),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('이벤트 생성 성공');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      EventModel createEventResponse = EventModel.fromJsonForId(jsonResult);
      // context.read<CEProvider>().createEventUniqueId(createEventResponse.id!);
      SenseLogger().debug('create event id : ${createEventResponse.id}');
      return true;
    } else {
      SenseLogger().error('이벤트 생성 실패');
      return false;
    }
  }

  /// event update
  Future<bool> updateEvent(BuildContext context) async {

    Map<String, dynamic> createModel = {};
    context.read<CEProvider>().title == '' ? {} : createModel['title'] = context.read<CEProvider>().title;
    context.read<CEProvider>().category == -1 ? {} : createModel['event_category'] = context.read<CEProvider>().category;
    context.read<CEProvider>().target == -1 ? {} : createModel['contact_category'] = context.read<CEProvider>().target;
    context.read<CEProvider>().date == '' ? {} : createModel['date'] = context.read<CEProvider>().date;
    context.read<CEProvider>().memo == '' ? {} : createModel['description'] = context.read<CEProvider>().memo;

    final response = await http.post(
        Uri.parse('${ApiUrl.releaseUrl}/event'),
        body: jsonEncode(createModel),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to event update');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      EventModel createEventResponse = EventModel.fromJson(jsonResult);
      // context.read<CreateEventProvider>().createEventUniqueId(createEventResponse.id!);
      return true;
    } else {
      SenseLogger().debug('fail to event update');
      return false;
    }
  }

  /// personal field event update
  Future<bool> personalFieldUpdateEvent(BuildContext context, int eventId, int fieldNumber) async {

    Map<String, dynamic> fieldModel = {};
    fieldModel.clear();

    print('change category : ${context.read<CEProvider>().category + 1}');
    if(fieldNumber == 0) {
      fieldModel['title'] = context.read<CEProvider>().title;
    } else if(fieldNumber == 1) {
      fieldModel['event_category'] = context.read<CEProvider>().category + 1;
    } else if(fieldNumber == 2) {
      fieldModel['contact_category'] = context.read<CEProvider>().target + 1;
    } else if(fieldNumber == 3) {
      fieldModel['date'] = context.read<CEProvider>().date;
    } else if(fieldNumber == 4) {
      fieldModel['memo'] = context.read<CEProvider>().memo;
    }
    // else if(fieldNumber == 5) {
    //   fieldModel['is_alarm'] = context.read<CEProvider>().isAlarm;
    // } else if(fieldNumber == 6) {
    //   fieldModel['public_type'] = context.read<CEProvider>().publicType;
    // }

    SenseLogger().debug(fieldModel.toString());

    final response = await http.patch(
        Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}'),
        body: jsonEncode(fieldModel),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to event update');
      return true;
    } else {
      SenseLogger().debug('fail to event update');
      return false;
    }
  }

  /// personal field event update
  Future<bool> personalFieldUpdateEvent2(int eventId, Map<String, dynamic> fieldModel) async {
    final response = await http.patch(
      Uri.parse('${ApiUrl.releaseUrl}/event/$eventId'),
      body: jsonEncode(fieldModel),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to event update');
      return true;
    } else {
      SenseLogger().debug('fail to event update');
      return false;
    }
  }

  /// event delete
  Future<bool> deleteEvent(int eventUniqueId) async {

    final response = await http.delete(
        Uri.parse('${ApiUrl.releaseUrl}/event/${eventUniqueId.toString()}'),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode == 204) {
      SenseLogger().debug('success to event delete');
      return true;
    } else {
      SenseLogger().debug('fail to event delete');
      return false;
    }
  }
}

class EventModel {
  int? id;
  EventHost? eventHost;
  String? eventTitle;
  String? description;
  int? totalBudget;
  String? eventDate;
  String? created;
  int? visitCount;
  int? recommendCount;
  bool? isAlarm;
  String? publicType;
  EventCategory? eventCategoryObject;
  ContactCategory? targetCategoryObject;
  RecommendRequestModel? recommendModel;
  City? city;
  SubCity? subCity;

  /// unused
  // List<int>? recommendCategory;
  // List<int>? createEventUsers;

  /// what??
  // List<String>? eventUsers;
  // List<int>? address;
  // int? totalCost;
  // EventCategory? eventCategory;
  // List<EventUser>? eventUser = [];
  // int? contactCategory;
  // String? createDate;
  // RecommendCategory? recommendCategory;

  EventModel({
    this.id = -1,
    this.eventHost,
    this.eventTitle = '',
    this.description = '',
    this.totalBudget = -1,
    this.eventDate = '',
    this.created = '',
    this.visitCount = 0,
    this.recommendCount = 0,
    this.isAlarm = false,
    this.publicType = 'PUBLIC',
    this.eventCategoryObject,
    this.targetCategoryObject,
    this.recommendModel,
    this.city,
    this.subCity,

    /// unused
    // this.eventUsers,
    // this.address,
    // this.totalCost,
    // this.eventUser,
    // this.createDate,
    // this.createEventUsers,
    // this.recommendCategory,
  });

  EventModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    eventTitle = json['title'] ?? '';
    eventHost = json['host'] != null ? EventHost.fromJson(json['host']) : null; /// 그냥 정의했을 때는 null이 배치되지 않기 때문에 null을 집어넣기 위한 명시적 정의
    eventDate = json['date'] ?? '';
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    subCity = json['sub_city'] != null ? SubCity.fromJson(json['sub_city']) : null;
    eventCategoryObject = json['event_category'] != null ? EventCategory.fromJson(json['event_category']) : null;
    targetCategoryObject = json['contact_category'] != null ? ContactCategory.fromJson(json['contact_category']) : null;
    created = json['created'] ?? '';
    // json['event_users'] == [] || json['event_users'] == null
    //     ? eventUser = []
    //     : json['event_users'].forEach((v) {
    //       eventUser!.add(EventUser.fromJson(v));
    //     }
    // );
  }

  EventModel.fromJsonForId(dynamic json) {
    id = json['id'] ?? -1;
  }

  EventModel.fromPersonalJson(dynamic json) {
    id = json['id'] ?? -1;
    eventHost = json['host'] != null ? EventHost.fromJson(json['host'] ?? EventHost()) : null;
    eventTitle = json['title'] ?? '';
    description = json['description'] ?? '';
    totalBudget = json['total_budget'] ?? -1;
    eventDate = json['date'] ?? '';
    created = json['created'] ?? '';
    visitCount = json['visit_count'] ?? 0;
    recommendCount = json['recommend_count'] ?? 0;
    isAlarm = json['is_alarm'] ?? false;
    publicType = json['public_type'] ?? 'PUBLIC';
    eventCategoryObject = json['event_category'] != null ? EventCategory.fromJson(json['event_category']) : EventCategory(id: -1, title: '');
    targetCategoryObject = json['contact_category'] != null ? ContactCategory.fromJson(json['contact_category']) : ContactCategory(id: -1, title: '');
    recommendModel = (json['recommend_request'] != null ? RecommendRequestModel.fromJson(json['recommend_request']) : RecommendRequestModel.initModel);
    city = json['city'] != null ? City.fromJson(json['city'] ?? City()) : City(id: -1, title: '');
    subCity = json['sub_city'] != null ? SubCity.fromJson(json['sub_city'] ?? SubCity()) : SubCity(id: -1, title: '');

    // recommendCategory = json['recommend_category'] ?? '';
    // totalCost = json['total_cost'] ?? -1;
  }

  EventModel.fromJsonForRecommend(dynamic json) {
    recommendModel = json['recommend_request'] ?? RecommendRequestModel(
      id: -1,
      userId: -1,
      memo: '',
      isPresent: false,
      isHotel: false,
      isLunch: false,
      isDinner: false,
      isActivity: false,
      isPub: false,
      totalBudget: -1,
      pubBudget: -1,
      presentBudget: -1,
      hotelBudget: -1,
      lunchBudget: -1,
      dinnerBudget: -1,
      activityBudget: -1,
      created: '',
      modified: ''
    );
  }

  // Map<String, dynamic> toJson() => {
  //   'title': eventTitle,
  //   'event_category': eventCategory,
  //   'contact_category': contactCategory,
  //   'city': city,
  //   'sub_city': subCity,
  //   'date': createDate,
  //   'description': description,
  //   'event_users': createEventUsers,
  //   'recommend_categories': recommendCategory,
  // };

  @override
  String toString() {
    return 'EventModel{id: $id, eventHost: $eventHost, eventTitle: $eventTitle, description: $description, totalBudget: $totalBudget, eventDate: $eventDate, created: $created, visitCount: $visitCount, recommendCount: $recommendCount, isAlarm: $isAlarm, publicType: $publicType, eventCategoryObject: $eventCategoryObject, targetCategoryObject: $targetCategoryObject, recommendModel: $recommendModel, city: $city, subCity: $subCity}';
  }
}

class EventHost {
  int? id;
  String? name;
  String? email;
  String? username;
  String? profileImage;

  EventHost({
    this.id = -1,
    this.name = '',
    this.email = '',
    this.username = '',
    this.profileImage = '',
  });

  EventHost.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    username = json['username'] ?? '';
    profileImage = json['profile_image_url'] ?? '';
  }
}

class EventCategory {
  int? id;
  String? title;

  EventCategory({
    this.id = -1,
    this.title = '',
  });

  EventCategory.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

class ContactCategory {
  int? id;
  String? title;

  ContactCategory({
    this.id = -1,
    this.title = '',
  });

  ContactCategory.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

class City {
  int? id;
  String? title;

  City({
    this.id = -1,
    this.title = '',
  });

  City.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

class SubCity {
  int? id;
  String? title;

  SubCity({
    this.id,
    this.title,
  });

  SubCity.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

class EventUser {
  int? id;
  UserData? userData;

  EventUser({
    this.id,
    this.userData,
  });

  EventUser.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    userData = json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? username;
  String? profileImage;

  UserData({
    this.id,
    this.name,
    this.email,
    this.username,
    this.profileImage,
  });

  UserData.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    username = json['username'] ?? '';
    profileImage = json['profile_image_url'] ?? '';
  }
}

class RecommendRequestModel {
  int? id;
  int? userId;
  String? memo;
  bool? isPresent;
  bool? isHotel;
  bool? isLunch;
  bool? isDinner;
  bool? isActivity;
  bool? isPub;
  int? totalBudget;
  int? pubBudget;
  int? presentBudget;
  int? hotelBudget;
  int? lunchBudget;
  int? dinnerBudget;
  int? activityBudget;
  String? created;
  String? modified;

  RecommendRequestModel({
    this.id,
    this.userId,
    this.memo,
    this.isPresent,
    this.isHotel,
    this.isLunch,
    this.isDinner,
    this.isActivity,
    this.isPub,
    this.totalBudget,
    this.pubBudget,
    this.presentBudget,
    this.hotelBudget,
    this.lunchBudget,
    this.dinnerBudget,
    this.activityBudget,
    this.created,
    this.modified,
  });

  RecommendRequestModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    userId = json['user'] ?? -1;
    memo = json['memo'] ?? '';
    isPresent = json['is_present'] ?? false;
    isHotel = json['is_hotel'] ?? false;
    isLunch = json['is_lunch'] ?? false;
    isDinner = json['is_dinner'] ?? false;
    isActivity = json['is_activity'] ?? false;
    isPub = json['is_pub'] ?? false;
    totalBudget = json['total_budget'] ?? -1;
    pubBudget = json['pub_budget'] ?? -1;
    presentBudget = json['present_budget'] ?? -1;
    hotelBudget = json['hotel_budget'] ?? -1;
    lunchBudget = json['lunch_budget'] ?? -1;
    dinnerBudget = json['dinner_budget'] ?? -1;
    activityBudget = json['activity_budget'] ?? -1;
    created = json['created'] ?? '';
    modified = json['modified'] ?? '';
  }

  static RecommendRequestModel initModel = RecommendRequestModel(
      id: -1,
      userId: -1,
      memo: '',
      isPresent: false,
      isHotel: false,
      isLunch: false,
      isDinner: false,
      isActivity: false,
      isPub: false,
      totalBudget: -1,
      pubBudget: -1,
      presentBudget: -1,
      hotelBudget: -1,
      lunchBudget: -1,
      dinnerBudget: -1,
      activityBudget: -1,
      created: '',
      modified: ''
  );
}
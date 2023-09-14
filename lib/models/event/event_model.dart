import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';

class EventRequest {

  /// logger
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 50,
      colors: false,
      printTime: true,
    ),
  );

  /// event list load
  Future<List<EventModel>> eventListRequest([int? selectMonth]) async {

    String monthQuery = '';

    if(selectMonth != null) {
      monthQuery = '?month=${selectMonth.toString()}';
    }

    logger.v('${ApiUrl.releaseUrl}/events$monthQuery');

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/events$monthQuery&is_participated=true'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('success to event list load');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<EventModel> models = body.isEmpty || body == null ? [] : body.map((e) => EventModel.fromJson(e)).toList();;
      return models;
    } else {
      logger.v('fail to event list load');
      return [];
    }
  }

  /// personal event load
  Future<EventModel> eventRequest(int eventId) async {

    print('event id : ${eventId.toString()}');

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('success to personal event load');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      // print('for id : ${EventCategory.fromJson(jsonResult['event_category']).id}');
      // print(jsonResult);
      EventModel eventModel = EventModel.fromPersonalJson(jsonResult);
      return eventModel;
    } else {
      logger.v('fail to personal event load');
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
      logger.v('success to personal event recommend info load');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      EventModel model = EventModel.fromPersonalJson(jsonResult);
      return model;
    } else {
      logger.v('fail to personal event recommend info load');
      return EventModel();
    }
  }

  /// event create
  Future<bool> eventCreateRequest(BuildContext context) async {

    Map<String, dynamic> createModel = {};
    createModel.clear();
    context.read<CreateEventImproveProvider>().title == '' ? {} : createModel['title'] = context.read<CreateEventImproveProvider>().title;
    context.read<CreateEventImproveProvider>().category == -1 ? {} : createModel['event_category'] = context.read<CreateEventImproveProvider>().category + 1;
    context.read<CreateEventImproveProvider>().target == -1 ? {} : createModel['contact_category'] = context.read<CreateEventImproveProvider>().target + 1;
    context.read<CreateEventImproveProvider>().date == '' ? {} : createModel['date'] = context.read<CreateEventImproveProvider>().date;
    context.read<CreateEventProvider>().city == -1 ? {} : createModel['city'] = context.read<CreateEventProvider>().city + 1;
    context.read<CreateEventImproveProvider>().memo == '' ? {} : createModel['description'] = context.read<CreateEventImproveProvider>().memo;

    print(createModel);

    logger.d(
        'title : ${context.read<CreateEventImproveProvider>().title}\n' +
        'category : ${context.read<CreateEventImproveProvider>().category}\n' +
        'target : ${context.read<CreateEventImproveProvider>().target}\n' +
        'date : ${context.read<CreateEventImproveProvider>().date}\n' +
        'city : ${context.read<CreateEventProvider>().city}\n' +
        'memo : ${context.read<CreateEventImproveProvider>().memo}\n'
    );

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/event'),
      body: jsonEncode(createModel),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('이벤트 생성 성공');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      EventModel createEventResponse = EventModel.fromJsonForId(jsonResult);
      context.read<CreateEventImproveProvider>().createEventUniqueId(createEventResponse.id!);
      logger.d('create event id : ${createEventResponse.id}');
      return true;
    } else {
      logger.v('이벤트 생성 실패');
      return false;
    }
  }

  /// event update
  Future<bool> updateEvent(BuildContext context) async {

    Map<String, dynamic> createModel = {};
    context.read<CreateEventProvider>().title == '' ? {} : createModel['title'] = context.read<CreateEventProvider>().title;
    context.read<CreateEventProvider>().category == -1 ? {} : createModel['event_category'] = context.read<CreateEventProvider>().category;
    context.read<CreateEventProvider>().target == -1 ? {} : createModel['contact_category'] = context.read<CreateEventProvider>().target;
    context.read<CreateEventProvider>().date == '' ? {} : createModel['date'] = context.read<CreateEventProvider>().date;
    context.read<CreateEventProvider>().memo == '' ? {} : createModel['description'] = context.read<CreateEventProvider>().memo;

    final response = await http.post(
        Uri.parse('${ApiUrl.releaseUrl}/event'),
        body: jsonEncode(createModel),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('success to event update');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      EventModel createEventResponse = EventModel.fromJson(jsonResult);
      context.read<CreateEventProvider>().createEventUniqueId(createEventResponse.id!);
      return true;
    } else {
      logger.v('fail to event update');
      return false;
    }
  }

  /// personal field event update
  Future<bool> personalFieldUpdateEvent(BuildContext context, int eventId, int fieldNumber) async {

    Map<String, dynamic> fieldModel = {};
    fieldModel.clear();

    print(context.read<CreateEventImproveProvider>().isAlarm);
    print(context.read<CreateEventImproveProvider>().publicType);

    print('change category : ${context.read<CreateEventImproveProvider>().category + 1}');
    if(fieldNumber == 0) {
      fieldModel['title'] = context.read<CreateEventImproveProvider>().title;
    } else if(fieldNumber == 1) {
      fieldModel['event_category'] = context.read<CreateEventImproveProvider>().category + 1;
    } else if(fieldNumber == 2) {
      fieldModel['contact_category'] = context.read<CreateEventImproveProvider>().target + 1;
    } else if(fieldNumber == 3) {
      fieldModel['date'] = context.read<CreateEventImproveProvider>().date;
    } else if(fieldNumber == 4) {
      fieldModel['memo'] = context.read<CreateEventImproveProvider>().memo;
    } else if(fieldNumber == 5) {
      fieldModel['is_alarm'] = context.read<CreateEventImproveProvider>().isAlarm;
    } else if(fieldNumber == 6) {
      fieldModel['public_type'] = context.read<CreateEventImproveProvider>().publicType;
    }

    final response = await http.patch(
        Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}'),
        body: jsonEncode(fieldModel),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('success to event update');
      return true;
    } else {
      logger.v('fail to event update');
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
      logger.v('success to event delete');
      return true;
    } else {
      logger.v('fail to event delete');
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
  bool? isAlarm;
  String? publicType;
  EventCategory? eventCategoryObject;
  ContactCategory? targetCategoryObject;
  RecommendRequestModel? recommendModel;
  City? city;

  /// unused
  // List<int>? recommendCategory;
  // SubCity? subCity;
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
    this.id,
    this.eventHost,
    this.eventTitle,
    this.description,
    this.totalBudget,
    this.eventDate,
    this.created,
    this.isAlarm,
    this.publicType,
    this.eventCategoryObject,
    this.targetCategoryObject,
    this.recommendModel,
    this.city,

    /// unused
    // this.eventUsers,
    // this.address,
    // this.totalCost,
    // this.eventUser,
    // this.subCity,
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
    // subCity = json['sub_city'] != null ? SubCity.fromJson(json['sub_city']) : null;
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
    isAlarm = json['is_alarm'] ?? false;
    publicType = json['public_type'] ?? 'PUBLIC';
    eventCategoryObject = json['event_category'] != null ? EventCategory.fromJson(json['event_category']) : EventCategory(id: -1, title: '');
    targetCategoryObject = json['contact_category'] != null ? ContactCategory.fromJson(json['contact_category']) : ContactCategory(id: -1, title: '');
    recommendModel = json['recommend_request'] != null ? RecommendRequestModel.fromJson(json['recommend_request']) : RecommendRequestModel.initModel;
    city = json['city'] != null ? City.fromJson(json['city'] ?? City()) : City(id: -1, title: '');

    // recommendCategory = json['recommend_category'] ?? '';
    // subCity = json['sub_city'] != null ? SubCity.fromJson(json['sub_city'] ?? SubCity()) : SubCity(id: 1, title: '서울');
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
}

class EventHost {
  int? id;
  String? name;
  String? email;
  String? username;
  String? profileImage;

  EventHost({
    this.id,
    this.name,
    this.email,
    this.username,
    this.profileImage,
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
    this.id,
    this.title,
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
    this.id,
    this.title,
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
    this.id,
    this.title,
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
    memo = json['is_present'] ?? '';
    isPresent = json['is_hotel'] ?? false;
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
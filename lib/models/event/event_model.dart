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
      EventModel eventModel = EventModel.fromPersonalJson(jsonResult);
      return eventModel;
    } else {
      logger.v('fail to personal event load');
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
    context.read<CreateEventImproveProvider>().memo == '' ? {} : createModel['description'] = context.read<CreateEventImproveProvider>().memo;

    logger.d(
        'title : ${context.read<CreateEventImproveProvider>().title}\n' +
        'category : ${context.read<CreateEventImproveProvider>().category}\n' +
        'target : ${context.read<CreateEventImproveProvider>().target}\n' +
        'date : ${context.read<CreateEventImproveProvider>().date}\n' +
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
    }
    // else if(fieldNumber == 5) {
    //   fieldModel['is_alarm'] = context.read<CreateEventImproveProvider>().isAlarm;
    // } else if(fieldNumber == 6) {
    //   fieldModel['public_type'] = context.read<CreateEventImproveProvider>().publicType;
    // }

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
  String? eventTitle;
  EventHost? eventHost;
  List<String>? eventUsers; /// 추후 user id : pk로 변경
  List<int>? address; /// 현재는 이벤트 리스폰스에 존재하지 않음. 추후 생성 by andy
  int? totalCost;
  String? eventDate;
  EventCategory? eventCategory;
  String? created;
  List<EventUser>? eventUser = [];

  /// when request to server
  int? contactCategory;
  // int? city;
  // int? subCity;
  String? createDate;
  String? description;
  List<int>? createEventUsers;
  List<int>? recommendCategory;

  /// add 2023.07.30.
  EventCategory? eventCategoryObject;
  ContactCategory? targetCategoryObject;
  // RecommendCategory? recommendCategory;
  City? city;
  SubCity? subCity;
  bool? isAlarm;
  String? publicType;

  EventModel({
    this.id,
    this.eventTitle,
    this.eventHost,
    this.eventUsers,
    this.address,
    this.totalCost,
    this.eventDate,
    this.created,
    this.eventUser,

    /// when request to server
    this.eventCategory,
    this.contactCategory,
    this.city,
    this.subCity,
    this.createDate,
    this.description,
    this.createEventUsers,
    this.recommendCategory,

    /// add 2023.07.30.
    this.isAlarm,
    this.publicType,
  });

  EventModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    eventTitle = json['title'] ?? '';
    eventHost = json['host'] != null ? EventHost.fromJson(json['host']) : null; /// 그냥 정의했을 때는 null이 배치되지 않기 때문에 null을 집어넣기 위한 명시적 정의
    eventDate = json['date'] ?? '';
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    subCity = json['sub_city'] != null ? SubCity.fromJson(json['sub_city']) : null;
    eventCategory = json['event_category'] != null ? EventCategory.fromJson(json['event_category']) : null;
    created = json['created'] ?? '';
    json['event_users'] == [] || json['event_users'] == null
        ? eventUser = []
        : json['event_users'].forEach((v) {
          eventUser!.add(EventUser.fromJson(v));
        }
    );
  }

  EventModel.fromJsonForId(dynamic json) {
    id = json['id'] ?? -1;
  }

  EventModel.fromPersonalJson(dynamic json) {
    id = json['id'] ?? -1;
    eventHost = json['master'] != null ? EventHost.fromJson(json['master'] ?? EventHost()) : null;
    eventCategoryObject = json['event_category'] != null ? EventCategory.fromJson(json['event_category']) : EventCategory(id: -1, title: '');
    targetCategoryObject = json['contact_category'] != null ? ContactCategory.fromJson(json['contact_category']) : ContactCategory(id: -1, title: '');
    // recommendCategory = json['recommend_category'] ?? '';
    city = json['city'] != null ? City.fromJson(json['city'] ?? City()) : City(id: 1, title: '서울');
    subCity = json['sub_city'] != null ? SubCity.fromJson(json['sub_city'] ?? SubCity()) : SubCity(id: 1, title: '서울');
    eventTitle = json['title'] ?? '';
    description = json['description'] ?? '';
    totalCost = json['total_cost'] ?? -1;
    eventDate = json['date'] ?? '';
    created = json['created'] ?? '';
    isAlarm = json['is_alarm'] ?? false;
    publicType = json['public_type'] ?? 'PUBLIC';
    // eventUsers =
  }

  Map<String, dynamic> toJson() => {
    'title': eventTitle,
    'event_category': eventCategory,
    'contact_category': contactCategory,
    'city': city,
    'sub_city': subCity,
    'date': createDate,
    'description': description,
    'event_users': createEventUsers,
    'recommend_categories': recommendCategory,
  };
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
  int? id = -1;
  String? title = '';

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
  int? id = -1;
  String? title = '';

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

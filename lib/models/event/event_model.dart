import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class EventRequest {

  /// logger
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 50,
      colors: false,
      printTime: true,
    ),
  );

  Future<List<EventModel>> eventListRequest([int? selectMonth]) async {

    String monthQuery = '';

    if(selectMonth != null) {
      monthQuery = '?month=${selectMonth.toString()}';
    }

    logger.v('${ApiUrl.devUrl}events$monthQuery');

    final response = await http.get(
      Uri.parse('${ApiUrl.devUrl}events$monthQuery'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('이벤트 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<EventModel> models = body.isEmpty || body == null ? [] : body.map((e) => EventModel.fromJson(e)).toList();
      // CommentResponseModel model = CommentResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return models;
    } else {
      logger.v('이벤트 불러오기 실패');
      return [];
    }
  }
}

class EventModel {
  int? id;
  String? status;
  String? recommendStatus;
  String? eventTitle;
  EventHost? eventHost;
  List<String>? eventUsers; /// 추후 user id : pk로 변경
  List<int>? address; /// 현재는 이벤트 리스폰스에 존재하지 않음. 추후 생성 by andy
  int? maxCost;
  String? eventDate;
  int? visitCount;
  String? created;

  EventModel({
    this.id,
    this.status,
    this.recommendStatus,
    this.eventTitle,
    this.eventHost,
    this.eventUsers,
    this.address,
    this.maxCost,
    this.eventDate,
    this.visitCount,
    this.created,
  });

  EventModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    status = json['status'] ?? '진행전';
    recommendStatus = json['recommend_status'] ?? '진행전';
    eventTitle = json['title'] ?? '';
    eventHost = json['host'] != null ? EventHost.fromJson(json['host']) : null; /// 그냥 정의했을 때는 null이 배치되지 않기 때문에 null을 집어넣기 위한 명시적 정의
    // eventUsers
    // address
    // maxCost
    eventDate = json['date'] ?? '';
    // visitCount
    created = json['created'] ?? '';
  }
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
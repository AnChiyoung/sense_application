import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class EventFeedRequest {
  /// logger
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 50,
      colors: false,
      printTime: true,
    ),
  );

  /// event list load
  Future<List<EventModel>> recommendEventListRequest() async {

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/events?is_participated=false'),
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
}
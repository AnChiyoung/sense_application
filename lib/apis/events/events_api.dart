import 'dart:convert';
import 'package:sense_flutter_application/service/api_service.dart';

class EventsApi {
  Future<Map<String, dynamic>> getEvents(String filter) async {
    final response = await ApiService.get(
      'events/calendar?$filter',
    );

    print('filter $filter');

    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }
}

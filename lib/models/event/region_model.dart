import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/constants/api_path.dart';

class RegionRequest {

  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 50,
      colors: false,
      printTime: true,
    ),
  );

  Future<List<City>> cityListRequest() async {

    final response = await http.get(
      Uri.parse('${ApiUrl.devUrl}business/cities'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('city 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<City> models = body.isEmpty || body == null ? [] : body.map((e) => City.fromJson(e)).toList();
      return models;
    } else {
      logger.v('city 불러오기 실패');
      return [];
    }
  }

  Future<List<SubCity>> subCityListRequest(String cityNumber) async {

    final response = await http.get(
      Uri.parse('${ApiUrl.devUrl}business/city/$cityNumber/subcities'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('subcity 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<SubCity> models = body.isEmpty || body == null ? [] : body.map((e) => SubCity.fromJson(e)).toList();
      return models;
    } else {
      logger.v('subcity 불러오기 실패');
      return [];
    }
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
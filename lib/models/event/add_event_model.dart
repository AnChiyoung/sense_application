
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/constants/api_path.dart';

class AddEventModel {
  static String eventTypeModel = '';
  static List<int> userModel = [];
  static List<int> shareUserModel = [];
  static String dateModel = '';
  static List<String> recommendedModel = [];
  static String costModel = '';
  static List<String> regionModel = [];
  static String memoModel = '';

  static String eventInfoTitle = '';
  static String eventInfoName = '';

  static bool editorMode = false;
}

class ContactModel {
  String phoneNumber;
  String name;
  int? saveCategory;
  Image? profileImage;

  ContactModel({
    required this.phoneNumber,
    required this.name,
    this.saveCategory,
    this.profileImage,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
      saveCategory: json['category'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'name': name,
    'saveCategory': saveCategory,
    'profileImage': profileImage,
  };
}

var contactDummyModel =
// [
  {
  'phoneNumber': '010-6630-0387',
  'name': '안치영',
  'category': 1,
};
// {
//   'phoneNumber': '010-1111-2222',
//   'name': '김씨요',
//   'category': 1,
// }
// ];

class CreateEventModel {
  String? title;
  List<String>? eventType;
  List<String>? recommendedType;
  String? date;
  String? cost;
  String? description;
  List<String>? region;
  List<int>? user;

  CreateEventModel({
    this.title,
    this.eventType,
    this.recommendedType,
    this.date,
    this.cost,
    this.description,
    this.region,
    this.user,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'type': eventType,
    'recommend_type': recommendedType,
    'start_date': date,
    'max_cost': cost,
    'description': description,
    'address': region,
    'event_users': user,
  };

  var aa = {
    "title": "dfd",
    "type": ["BIRTHDAY"],
    "recommend_type": ["GIFT"],
    "start_date": "2023-04-15T17:25:03.903Z",
    "end_date": "2023-04-15T17:25:03.903Z",
    "max_cost": "25",
    "description": "df",
    "address": [
      "df"
    ]
  };

  Future<bool> postCreateEvent(Map<String, dynamic> postModel) async {
    print('get response start');
    var url = Uri.parse('${ApiUrl.releaseUrl}/suggestions?recommend_type=HOTEL');
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    // var response = await http.post(url, body: jsonEncode(postModel), headers: headers);
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    if(response.statusCode == 200 || response.statusCode == 201) {
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print('성공');
      return true;
    } else {
      // print(jsonDecode(response.body));
      print('실패');
      return false;
    }
  }
}
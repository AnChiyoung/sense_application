import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class ContactRequest {
  static List<Contact> contacts = [];

  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  Future<List<ContactModel>> contactListRequest() async {

    var logger = Logger(
      printer: PrettyPrinter(
        lineLength: 120,
        colors: true,
        printTime: true,
      ),
    );

    final response = await http.get(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/contacts'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      print(body);
      List<ContactModel> contactModels = body.isEmpty ? [] : body.map((e) => ContactModel.fromJson(e)).toList();

      print('contact models : ${contactModels}');

      return contactModels;
    } else {
      print('연락처 불러오기 실패');
      return [];
    }
  }

  Future<List<ContactModel>> contactListCreateRequest(List<ContactModel> list) async {

    List<ContactModel> initList = list;
    final sendContactModels =
    {
      "contacts": initList
    };

    // var sendTest = {
    //   'contacts' : [
    //     ''
    //   ]
    // };
    print(jsonEncode(sendContactModels));
    // return [];
    //
    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/contacts'),
      body: jsonEncode(sendContactModels),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 저장 성공');
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      // var logger = Logger(
      //   printer: PrettyPrinter(
      //     lineLength: 120,
      //     colors: true,
      //     printTime: true,
      //   ),
      // );
      // logger.i('연락처 리스폰스 : ${jsonDecode(utf8.decode(response.bodyBytes))['data']}');
      // List<ContactModel> contactModels = body.isEmpty ? [] : body.map((e) => ContactModel.fromJson(e)).toList();
      // return contactModels;
      return [];
    } else {
      print('연락처 저장 실패');
      return [];
    }
  }

  /// contact detail request
  Future<ContactModel> contactDetailRequest(int contactId) async {

    var logger = Logger(
      printer: PrettyPrinter(
        lineLength: 120,
        colors: true,
        printTime: true,
      ),
    );

    logger.i('contact id : ${contactId.toString()}');

    final response = await http.get(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/contact/${contactId.toString()}'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 상세 불러오기 성공');
      ContactModel model = ContactModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      print('연락처 상세 불러오기 실패');
      return ContactModel();
    }
  }

  /// contact bookmarked request
  Future<ContactModel> bookmarkedRequest(int contactId) async {

    var logger = Logger(
      printer: PrettyPrinter(
        lineLength: 120,
        colors: true,
        printTime: true,
      ),
    );

    logger.i('contact id : ${contactId.toString()}');

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/contact/${contactId.toString()}/bookmark'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 북마크 성공');
      ContactModel model = ContactModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      print('연락처 북마크 실패');
      return ContactModel();
    }
  }

  /// contact unbookmarked request
  Future<ContactModel> unBookmarkedRequest(int contactId) async {

    var logger = Logger(
      printer: PrettyPrinter(
        lineLength: 120,
        colors: true,
        printTime: true,
      ),
    );

    logger.i('contact id : ${contactId.toString()}');

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/contact/${contactId.toString()}/unbookmark'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 언북마크 성공');
      ContactModel model = ContactModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      print('연락처 언북마크 실패');
      return ContactModel();
    }
  }
}

class ContactModel {
  int? id;
  int? owner;
  int? partnerId;
  int? contactCategory;
  ContactCategory? contactCategoryObject;
  String? name;
  String? phone;
  String? birthday;
  String? gender;
  String? profileImage;
  String? created;
  bool? isBookmarked;

  ContactModel({
    this.id,
    this.owner,
    this.partnerId,
    this.contactCategory,
    this.contactCategoryObject,
    this.name,
    this.phone,
    this.birthday,
    this.gender,
    this.profileImage,
    this.created,
    this.isBookmarked,
  });

  ContactModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    // owner = json['owner'] ?? -1;
    partnerId = json['partner_id'] ?? -1;
    // contactCategory = json['contact_category'] ?? '';
    contactCategoryObject = json['contact_category'] != null ? ContactCategory.fromJson(json['contact_category']) : null;
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    birthday = json['birthday'] ?? '';
    gender = json['gender'] ?? '';
    profileImage = json['image_url'] ?? '';
    created = json['created'] ?? '';
    isBookmarked = json['is_bookmarked'] ?? false;
  }

  Map<String, dynamic> toJson() => {
    'contact_category': contactCategory,
    'name': name,
    'phone': phone,
    'gender': gender,
    'image': profileImage,
  };
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

class ContactListRequestJson {
  List<ContactModel>? body;

  ContactListRequestJson({
    this.body,
  });

  Map<String, dynamic> toJson() => {
    'contact': body
  };
}
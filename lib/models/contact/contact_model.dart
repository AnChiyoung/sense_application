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
      var logger = Logger(
        printer: PrettyPrinter(
          lineLength: 120,
          colors: true,
          printTime: true,
        ),
      );
      logger.i('연락처 리스폰스 : ${jsonDecode(utf8.decode(response.bodyBytes))['data']}');
      List<ContactModel> contactModels = body.isEmpty ? [] : body.map((e) => ContactModel.fromJson(e)).toList();
      return contactModels;
    } else {
      print('연락처 불러오기 실패');
      return [];
    }
  }

  Future<List<ContactModel>> contactListCreateRequest(List<String> nameList) async {

    print(nameList);
    List<ContactModel> aa = [];
    nameList.map((e) =>
        aa.add(
          ContactModel(
            contactCategory: 0,
            name: e,
            phone: '',
            birthday: '',
            gender: '',
            profileImage: '',
          )
        )
    );

    // print(jsonEncode(aa));



    // final sendContactModels =
    // {
    //   "contacts": aa
    // };
    // print(jsonEncode(sendContactModels));
    return [];
    //
    // final response = await http.post(
    //   Uri.parse('https://dev.server.sense.runners.im/api/v1/contacts'),
    //   body: jsonEncode(sendContactModels),
    //   headers: {
    //     'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
    //     'Content-Type': 'application/json; charset=UTF-8'
    //   },
    // );

    // if(response.statusCode == 200 || response.statusCode == 201) {
    //   print('연락처 저장 성공');
    //   List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
    //   var logger = Logger(
    //     printer: PrettyPrinter(
    //       lineLength: 120,
    //       colors: true,
    //       printTime: true,
    //     ),
    //   );
    //   logger.i('연락처 리스폰스 : ${jsonDecode(utf8.decode(response.bodyBytes))['data']}');
    //   List<ContactModel> contactModels = body.isEmpty ? [] : body.map((e) => ContactModel.fromJson(e)).toList();
    //   return contactModels;
    // } else {
    //   print('연락처 저장 실패');
    //   return [];
    // }
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
    owner = json['owner'] ?? -1;
    partnerId = json['partner_id'] ?? -1;
    contactCategory = json['contact_category'] ?? '';
    contactCategoryObject = json['contact_category'] != null ? ContactCategory.fromJson(json['contact_category']) : null;
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    birthday = json['birthday'] ?? '';
    gender = json['gender'] ?? '';
    profileImage = json['image'] ?? '';
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
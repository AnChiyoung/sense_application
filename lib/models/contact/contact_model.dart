import 'dart:convert';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactTabModel {
  int? count;
  List<ContactModel>? contactModelList = []; /// **** 중요

  ContactTabModel({
    this.count,
    this.contactModelList,
  });

  ContactTabModel.fromJson(dynamic json) {
    count = json['count'] ?? -1;
    json['data'].forEach((v) {
      contactModelList!.add(ContactModel.fromJson(v));
    }) ?? [];
  }
}

class ContactRequest {
  static List<Contact> contacts = [];

  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  Future<ContactTabModel> contactListRequest([int? category]) async {

    String orderbyParams = '';

    if(category == null) {
      orderbyParams = '';
    } else {
      if(category == 1) {
        orderbyParams = '?contact_category=친구';
      } else if(category == 2) {
        orderbyParams = '?contact_category=가족';
      } else if(category == 3) {
        orderbyParams = '?contact_category=연인';
      } else if(category == 4) {
        orderbyParams = '?contact_category=직장';
      }
    }

    final response = await http.get(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/contacts$orderbyParams'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 불러오기 성공');

      ContactTabModel model = ContactTabModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      logger.i(model.count);
      logger.i(model.contactModelList!.elementAt(0).id);

      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      // List<ContactModel> contactModels = body.isEmpty ? [] : body.map((e) => ContactModel.fromJson(e)).toList();

      return model;
    } else {
      print('연락처 불러오기 실패');
      return ContactTabModel();
    }
  }

  Future<bool> contactListCreateRequest(List<ContactModel> list) async {

    List<ContactModel> initList = list;
    final sendContactModels =
    {
      "contacts": initList
    };

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
      return true;
    } else {
      print('연락처 저장 실패');
      return false;
    }
  }

  /// contact detail request
  Future<ContactModel> contactDetailRequest(int contactId) async {

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

  /// contact update
  Future<ContactModel> contactUpdateRequest(int contactId, int category, String name, String phone, String birthday, String gender, String profileImage) async {

    Map<String, dynamic> updateRequestBody = ContactModel(
      contactCategory: category,
      name: name,
      phone: phone,
      birthday: birthday,
      gender: gender,
      profileImage: profileImage, /// base 64 string focused
    ).updateJson();



    final response = await http.patch(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/contact/${contactId.toString()}'),
      body: jsonEncode(updateRequestBody),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    // final responseMetaData = http.MultipartRequest(
    //   'PATCH',
    //   Uri.parse('https://dev.server.sense.runners.im/api/v1/contact/${contactId.toString()}'),
    // );
    // responseMetaData.files.add(
    //   http.MultipartFile(
    //     //,
    //     File(filename).readAsBytes().asStream(),
    //     File(filename).lengthSync(),
    //     filename: filename.split("/").last;
    //   )
    // );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 수정 성공');
      ContactModel model = ContactModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      print('연락처 수정 실패');
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

  Map<String, dynamic> updateJson() => {
    'contact_category': contactCategory,
    'name': name,
    'phone': phone,
    'birthday': birthday,
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
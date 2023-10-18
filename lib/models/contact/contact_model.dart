import 'dart:convert';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
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

  Future<List<ContactModel>> contactListRequest([int? category]) async {

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
      Uri.parse('${ApiUrl.releaseUrl}/contacts$orderbyParams'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<ContactModel> contactModels = body.isEmpty ? [] : body.map((e) => ContactModel.fromJson(e)).toList();
      return contactModels;
    } else {
      print('연락처 불러오기 실패');
      return [];
    }
  }

  Future<bool> contactListCreateRequest(List<ContactModel> list) async {

    List<ContactModel> initList = list;
    final sendContactModels =
    {
      "contacts": initList
    };

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/user/contacts'),
      body: jsonEncode(sendContactModels),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 저장 성공');
      return true;
    } else {
      print('연락처 저장 실패');
      return false;
    }
  }

  /// contact detail request
  Future<ContactModel> contactDetailRequest(int contactId) async {

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/contact/${contactId.toString()}'),
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

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/contact/${contactId.toString()}/bookmark'),
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

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/contact/${contactId.toString()}/unbookmark'),
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
  Future<bool> contactUpdateRequest(int contactId, int category, String name, String phone, String birthday, String gender, String profileImage, BuildContext context) async {

    Map<String, dynamic> updateRequestBody = ContactModel(
      contactCategory: category,
      name: name,
      phone: phone.isEmpty ? '010-0000-0000' : phone,
      birthday: birthday.isEmpty ? '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}' : birthday,
      gender: gender,
      profileImage: profileImage.isEmpty ? null : profileImage, /// base 64 string focused
    ).updateJson();

    final response = await http.patch(
      Uri.parse('${ApiUrl.releaseUrl}/contact/${contactId.toString()}'),
      body: jsonEncode(updateRequestBody),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('연락처 수정 성공');
      ContactModel model = ContactModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      context.read<ContactProvider>().contactResponseModelChange(model);
      return true;
    } else {
      print('연락처 수정 실패');
      return false;
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
    owner = json['owner'] ?? -1;
    partnerId = json['partner'] ?? -1;
    contactCategoryObject = json['contact_category'] != null ? ContactCategory.fromJson(json['contact_category']) : ContactCategory(id: -1, title: '');
    name = json['name'] ?? '';
    phone = json['phone'] == null ? '' : json['phone'];
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
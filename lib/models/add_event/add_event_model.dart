import 'package:flutter/material.dart';

class AddEventModel {
  static String eventModel = '';
  static List<String> peopleModel = [];
  static List<String> sharePeopleModel = [];
  static String eventDateModel = '';
  static String eventRecommendedModel = '';
  static String priceModel = '';
  static List<String> regionModel = [];
  static String memoModel = '';
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

/*
Map testMap = jsonDecode(contactDummyModel);
var testContactModel = ContactModel.fromJson(testMap);
 */

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

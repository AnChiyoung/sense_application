import 'dart:convert';

import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:http/http.dart' as http;

class RecommendedApi {
  Future<List<RecommendedModel>> getRecommendList(String recommendType) async {

    String aa = '';

    var url = Uri.parse('${ApiUrl.recommendListPath}$recommendType');
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var response = await http.get(url, headers: headers);
    if(response.statusCode == 200 || response.statusCode == 201) {

      List<dynamic> body = json.decode(response.body)['data'];
      List<RecommendedModel> allInfo =
          body.map((e) => RecommendedModel.fromJson(e)).toList();

      return allInfo;
    } else {
      throw Exception('fail');
    }
  }
}

class RecommendedModel {
  int? id;
  Event? event;
  Product? product;
  Planner? planner;
  String? recommendType;

  RecommendedModel({
    this.id,
    this.event,
    this.product,
    this.planner,
    this.recommendType,
  });

  RecommendedModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    planner = json['planner'] != null ? Planner.fromJson(json['planner']) : null;
    recommendType = json['recommendType'] ?? '';
  }
}

class Event {
  int? id;
  // Master? master;
  // String? type;
  // String? startDate;
  // String? endDate;
  // String? minCost;
  // String? maxCost;
  // String? address;
  // String? created;
  // String? eventUsers;

  Event({
    this.id,
    // this.master,
    // this.type,
    // this.startDate,
    // this.endDate,
    // this.minCost,
    // this.maxCost,
    // this.address,
    // this.created,
    // this.eventUsers,
  });

  Event.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    // master = json['master'] ?? '';
    // type = json['type'] ?? '';
    // startDate = json['start_date'] ?? '';
    // endDate = json['end_date'] ?? '';
    // minCost = json['min_cost'] ?? '';
    // maxCost = json['max_cost'] ?? '';
    // address = json['address'] ?? '';
    // created = json['created'] ?? '';
    // eventUsers = json['event_users'] ?? '';
  }
}

class Product {
  int? id;
  String? title;
  String? type;
  String? description;
  String? originPrice;
  String? discountRate;
  String? imageUrl;
  String? vendor;
  String? address;
  String? purchaseUrl;
  String? created;

  Product({
    this.id,
    this.title,
    this.type,
    this.description,
    this.originPrice,
    this.discountRate,
    this.imageUrl,
    this.vendor,
    this.address,
    this.purchaseUrl,
    this.created,
  });

  Product.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
    type = json['type'] ?? '';
    description = json['description'] ?? '';
    originPrice = json['origin_price'] ?? '';
    discountRate = json['discount_rate'] ?? '';
    imageUrl = json['image_url'] ?? '';
    vendor = json['vendor'] ?? '';
    address = json['address'] ?? '';
    purchaseUrl = json['purchase_url'] ?? '';
    created = json['created'] ?? '';
  }
}

class Planner {
  User? user;

  Planner({
    this.user,
  });

  Planner.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? username;
  String? imageProfileUrl;

  User({
    this.id,
    this.username,
    this.imageProfileUrl,
  });

  User.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    username = json['username'] ?? '';
    imageProfileUrl = json['image_profile_url'] ?? '';
  }
}

class RecommendType {
  String? recommendType;

  RecommendType({
    this.recommendType,
  });

  RecommendType.fromJson(dynamic json) {
    recommendType = json['recommend_type'];
  }
}

class Master {
  int? id;
  String? username;
  String? imageProfileUrl;

  Master({
    this.id,
    this.username,
    this.imageProfileUrl,
  });

  Master.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    username = json['username'] ?? '';
    imageProfileUrl = json['image_profile_url'] ?? '';
  }
}

/// 하위는 쓰지 않는 모델링

// class RecommendedModel {
//   int? code;
//   String? message;
//   int? count;
//   dynamic next;
//   dynamic previous;
//   List<Data>? data;
//
//   RecommendedModel({
//       this.code,
//       this.message,
//       this.count,
//       this.next,
//       this.previous,
//       this.data,});
//
//   RecommendedModel.fromJson(dynamic json) {
//     code = json['code'];
//     message = json['message'];
//     count = json['count'];
//     next = json['next'];
//     previous = json['previous'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }
// }
//
// class Data {
//   int? id;
//   Event? event;
//   Product? product;
//   User? planner;
//   String? recommendType;
//
//   Data({
//     this.id,
//     this.event,
//     this.product,
//     this.planner,
//     this.recommendType,});
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     event = json['event'] != null ? Event.fromJson(json['event']) : null;
//     product = json['product'] != null ? Product.fromJson(json['product']) : null;
//     planner = json['planner'];
//     recommendType = json['recommend_type'];
//   }
// }
//
// class Event {
//   int? id;
//   Master? master;
//   String? type;
//   String? startDate;
//   String? endDate;
//   String? minCost;
//   String? maxCost;
//   String? address;
//   String? created;
//   String? eventUsers;
//
//   Event({
//     this.id,
//     this.master,
//     this.type,
//     this.startDate,
//     this.endDate,
//     this.minCost,
//     this.maxCost,
//     this.address,
//     this.created,
//     this.eventUsers,});
//
//   Event.fromJson(dynamic json) {
//     id = json['id'];
//     master = json['master'] != null ? Master.fromJson(json['master']) : null;
//     type = json['type'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     minCost = json['min_cost'];
//     maxCost = json['max_cost'];
//     address = json['address'];
//     created = json['created'];
//     eventUsers = json['event_users'];
//   }
// }
//
// class Product {
//   int? id;
//   String? title;
//   String? type;
//   String? description;
//   String? originPrice;
//   dynamic discountRate;
//   String? imageUrl;
//   String? vendor;
//   String? address;
//   String? purchaseUrl;
//   String? created;
//
//   Product({
//     this.id,
//     this.title,
//     this.type,
//     this.description,
//     this.originPrice,
//     this.discountRate,
//     this.imageUrl,
//     this.vendor,
//     this.address,
//     this.purchaseUrl,
//     this.created,});
//
//   Product.fromJson(dynamic json) {
//     id = json['id'];
//     title = json['title'];
//     type = json['type'];
//     description = json['description'];
//     originPrice = json['origin_price'];
//     discountRate = json['discount_rate'];
//     imageUrl = json['image_url'];
//     vendor = json['vendor'];
//     address = json['address'];
//     purchaseUrl = json['purchase_url'];
//     created = json['created'];
//   }
// }
//
// class User {
//   int? id;
//   String? username;
//   String? imageProfileUrl;
//
//   User({
//     this.id,
//     this.username,
//     this.imageProfileUrl,});
//
//   User.fromJson(dynamic json) {
//     id = json['id'];
//     username = json['username'];
//     imageProfileUrl = json['image_profile_url'];
//   }
// }
//
// class Master {
//   int? id;
//   String? username;
//   dynamic imageProfileUrl;
//
//   Master({
//     this.id,
//     this.username,
//     this.imageProfileUrl,});
//
//   Master.fromJson(dynamic json) {
//     id = json['id'];
//     username = json['username'];
//     imageProfileUrl = json['image_profile_url'];
//   }
// }
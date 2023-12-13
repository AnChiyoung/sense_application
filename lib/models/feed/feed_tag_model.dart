import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/api/api_path.dart';

class FeedTagLoad {
  Future<List<TagModel>> tagRequest() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/labels'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<TagModel> tagModelList = body.map((e) => TagModel.fromJson(e)).toList();
      return tagModelList;
    } else {
      throw Exception;
    }
  }
}

class TagModel {
  int? id;
  String? title;
  int? postCount;
  bool? isActive;
  String? created;
  String? modified;

  TagModel({
    this.id,
    this.title,
    this.postCount,
    this.isActive,
    this.created,
    this.modified,
  });

  TagModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
    postCount = json['post_count'] ?? -1;
    isActive = json['is_active'] ?? false;
    created = json['created'] ?? '';
    modified = json['modified'] ?? '';
  }
}

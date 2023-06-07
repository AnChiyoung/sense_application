import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedTagLoad {
  Future<List<TagModel>> tagRequest() async {
    final response = await http.get(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/labels'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('댓글 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<TagModel> tagModelList = body.map((e) => TagModel.fromJson(e)).toList();

      print(tagModelList.elementAt(0).title);
      return tagModelList;
    } else {
      print('댓글 불러오기 실패');
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
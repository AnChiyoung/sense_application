import 'dart:convert';

import 'package:http/http.dart' as http;

class FeedContentModel {
  Future<FeedDetailModel> feedDetailLoad(int feedId) async {
    final response = await http.get(
        // Uri.parse('https://dev.server.sense.runners.im/api/v1/post/' + feedId.toString()),
        Uri.parse('https://dev.server.sense.runners.im/api/v1/post/15'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if(response.statusCode == 200 || response.statusCode == 201) {
      // final jsonResult = json.decode(response.body)['data'];
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      print(jsonResult);
      FeedDetailModel feedDetailModel = FeedDetailModel.fromJson(jsonResult);
      print(feedDetailModel.thumbnail);
      return feedDetailModel;
    } else {
      throw Exception;
    }
  }
}

class FeedDetailModel {
  int? id;
  String? thumbnail;
  int? label;
  String? labelTitle;
  String? title;
  String? subTitle;
  String? startDate;
  String? endDate;
  String? content;
  String? memo;
  int? likeCount;
  int? commentCount;
  int? shareCount;
  List<Tag>? tags = [];
  bool? isLiked;
  // pervpost, nextpost non active
  List<Content>? contents = [];
  String? createdTime;

  FeedDetailModel({
    this.id,
    this.thumbnail,
    this.label,
    this.labelTitle,
    this.title,
    this.subTitle,
    this.startDate,
    this.endDate,
    this.content,
    this.memo,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.tags,
    this.isLiked,
    this.contents,
    this.createdTime,
  });

  FeedDetailModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    thumbnail = json['thumbnail_image_url'] ?? '';
    label = json['label'] ?? -1;
    labelTitle = json['label_title'] ?? '';
    title = json['title'] ?? '';
    subTitle = json['sub_title'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    content = json['content'] ?? '';
    memo = json['memo'] ?? '';
    likeCount = json['like_count'] ?? -1;
    commentCount = json['comment_count'] ?? -1;
    shareCount = json['share_count'] ?? -1;
    json['tags'].forEach((v) {
      tags!.add(Tag.fromJson(v));
    }) ?? [];
    isLiked = json['is_liked'] ?? false;
    json['contents'].forEach((v) {
      contents!.add(Content.fromJson(v));
    }) ?? [];
    createdTime = json['created'] ?? '';
  }
}

class Tag {
  int? id;
  String? title;

  Tag({
    this.id,
    this.title,
  });

  Tag.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

class Content {
  int? id;
  String? type;
  String? contentUrl;
  int? order;

  Content({
    this.id,
    this.type,
    this.contentUrl,
    this.order,
  });

  Content.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    type = json['type'] ?? '';
    contentUrl = json['content'] ?? '';
    order = json['order'] ?? -1;
  }
}
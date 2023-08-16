import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class FeedContentModel {
  Future<FeedDetailModel> feedDetailLoad(int feedId) async {
    final response = await http.get(
        Uri.parse('${ApiUrl.releaseUrl}/post/${feedId.toString()}'),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if(response.statusCode == 200 || response.statusCode == 201) {
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      /// logger setting
      var logger = Logger(
        printer: PrettyPrinter(
          lineLength: 120,
          colors: true,
          printTime: true,
        ),
      );
      logger.d(jsonResult);
      FeedDetailModel feedDetailModel = FeedDetailModel.fromJson(jsonResult);
      print(feedDetailModel.commentCount);
      return feedDetailModel;
    } else {
      throw Exception;
    }
  }
}

class FeedDetailModel {
  int? id;
  String? thumbnail;
  String? title;
  String? subTitle;
  String? startDate;
  String? endDate;
  List<Content>? content = [];
  String? contentTitle;
  int? likeCount;
  bool? isCommented;
  int? commentCount;
  int? shareCount;
  List<Tag>? tags = [];
  bool? isLiked;
  // pervpost, nextpost non active
  String? createdTime;

  FeedDetailModel({
    this.id,
    this.thumbnail,
    this.title,
    this.subTitle,
    this.startDate,
    this.endDate,
    this.content,
    this.contentTitle,
    this.likeCount,
    this.isCommented,
    this.commentCount,
    this.shareCount,
    this.tags,
    this.isLiked,
    this.createdTime,
  });

  FeedDetailModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    thumbnail = json['thumbnail_media_url'] ?? '';
    title = json['title'] ?? '';
    subTitle = json['sub_title'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    json['content'].forEach((v) {
      content!.add(Content.fromJson(v));
    }) ?? [];
    contentTitle = json['content_title'] ?? '';
    likeCount = json['like_count'] ?? -1;
    isCommented = json['is_commented'] ?? false;
    commentCount = json['comment_count'] ?? -1;
    shareCount = json['share_count'] ?? -1;
    json['tags'].forEach((v) {
      tags!.add(Tag.fromJson(v));
    }) ?? [];
    isLiked = json['is_liked'] ?? false;
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
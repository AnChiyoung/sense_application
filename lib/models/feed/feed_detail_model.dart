import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sense_flutter_application/api/api_path.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class FeedContentModel {
  /// logger setting
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  Future<FeedDetailModel> feedDetailLoad(int feedId) async {
    print('feedId: ${feedId.toString()}');
    final response = await http.get(
        // Uri.parse('https://dev.server.sens.im/api/v1/post/54'),
        Uri.parse('${ApiUrl.releaseUrl}/post/${feedId.toString()}'),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
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
  List<dynamic>? content = [];
  String? contentTitle;
  String? notice;
  int? likeCount;
  int? commentCount;
  int? shareCount;
  List<Label>? labels = [];
  List<Tag>? tags = [];
  bool? isLiked;
  bool? isCommented;
  bool? isTemp;
  String? createdTime;
  String? html;

  FeedDetailModel({
    this.id,
    this.thumbnail,
    this.title,
    this.subTitle,
    this.startDate,
    this.endDate,
    this.content,
    this.contentTitle,
    this.notice,
    this.likeCount,
    this.shareCount,
    this.labels,
    this.isCommented,
    this.commentCount,
    this.tags,
    this.isLiked,
    this.createdTime,
    this.isTemp,
    this.html,
  });

  FeedDetailModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    thumbnail = json['thumbnail_media_url'] ?? '';
    title = json['title'] ?? '';
    subTitle = json['sub_title'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    json['content'].forEach((v) {
          content!.add(v);
        }) ??
        [];
    contentTitle = json['content_title'] ?? '';
    notice = json['notice'] ?? '';
    likeCount = json['like_count'] ?? -1;
    commentCount = json['comment_count'] ?? -1;
    shareCount = json['share_count'] ?? -1;
    json['labels'].forEach((v) {
          labels!.add(Label.fromJson(v));
        }) ??
        [];
    json['tags'].forEach((v) {
          tags!.add(Tag.fromJson(v));
        }) ??
        [];
    isLiked = json['is_liked'] ?? false;
    isCommented = json['is_commented'] ?? false;
    createdTime = json['created'] ?? '';
    isTemp = json['is_temp'] ?? false;
    html = json['html'] ?? '';
  }
}

class Label {
  int? id;
  String? title;

  Label({
    this.id,
    this.title,
  });

  Label.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
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

// class Content {
//   String? id;
//   Data? data;
//   String? type;
//
//   Content({this.id, this.data, this.type});
//
//   Content.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['type'] = this.type;
//     return data;
//   }
// }

// class Content {
//   String? id;
//   String? type;
//   // String? contentUrl;
//   // int? order;
//   ContentData? data;
//
//   Content({
//     this.id,
//     this.type,
//     this.data,
//     // this.contentUrl,
//     // this.order,
//   });
//
//   Content.fromJson(dynamic json) {
//     id = json['id'] ?? '';
//     type = json['type'] ?? '';
//     data = json['data'] != null ? ContentData.fromJson(json['event_category']) : ContentData(text: '');
//     // contentUrl = json['content'] ?? '';
//     // order = json['order'] ?? -1;
//   }
// }

class ContentData {
  String? text;

  ContentData({
    this.text,
  });

  ContentData.fromJson(dynamic json) {
    text = json['text'] ?? '';
  }
}

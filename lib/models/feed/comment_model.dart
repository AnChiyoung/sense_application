import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class CommentRequest {

   Future<List<CommentResponseModel>> commentRequest(int postId, String sort) async {

      final response = await http.get(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/post/${postId.toString()}/comments?ordering=$sort'),
         headers: {
            'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
            'Content-Type': 'application/json; charset=UTF-8'
         },
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('댓글 불러오기 성공');
         List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
         var logger = Logger(
            printer: PrettyPrinter(
               lineLength: 50,
               colors: false,
               printTime: true,
            ),
         );
         body.map((e) => logger.e('댓글 리스폰스 : $e'));
         // logger.e('댓글 리스폰스 : $body');
         List<CommentResponseModel> commentModels = body.isEmpty ? [] : body.map((e) => CommentResponseModel.fromJson(e)).toList();
         return commentModels;
      } else {
         print('댓글 불러오기 실패');
         return [];
      }
   }

   Future<CommentResponseModel> commentWriteRequest(int postId, String comment) async {

      Map<String, dynamic> commentRequestBody = CommentRequestModel(comment: comment).toJson();

      final response = await http.post(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/post/${postId.toString()}/comment'),
         body: jsonEncode(commentRequestBody),
         headers: {
            'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
            'Content-Type': 'application/json; charset=UTF-8'
         },
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('댓글 입력 성공');
         CommentResponseModel model = CommentResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
         return model;
      } else {
         print('댓글 입력 실패');
         CommentResponseModel model = CommentResponseModel();
         return model;
      }
   }

   /// 댓글 업데이트
   Future<CommentResponseModel> commentUpdateRequest(int commentId, String comment) async {

      print('comment update id : $commentId');

      Map<String, dynamic> commentRequestBody = CommentRequestModel(comment: comment).toJson();

      final response = await http.patch(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/comment/${commentId.toString()}'),
         body: jsonEncode(commentRequestBody),
         headers: {
            'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
            'Content-Type': 'application/json; charset=UTF-8'
         },
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('댓글 수정 성공');
         CommentResponseModel model = CommentResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
         return model;
      } else {
         print('댓글 수정 실패');
         return CommentResponseModel();
      }
   }

   /// 댓글 삭제(대댓글 포함)
   Future<CommentResponseModel> commentDeleteRequest(int commentId) async {

      print('delete comment id : ${commentId.toString()}');

      final response = await http.delete(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/comment/${commentId.toString()}'),
         headers: {
            'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
            'Content-Type': 'application/json; charset=UTF-8'
         },
      );

      if(response.statusCode == 200) {
         print('댓글 삭제 성공');
         var logger = Logger(
            printer: PrettyPrinter(
               lineLength: 120,
               colors: true,
               printTime: true,
            ),
         );
         logger.d('삭제 리스폰스 : ${jsonDecode(utf8.decode(response.bodyBytes))['data']}');
         CommentResponseModel model = CommentResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
         return model;
      } else {
         print('댓글 삭제 실패');
         return CommentResponseModel();
      }
   }

   Future<CommentResponseModel> recommentWriteRequest(int parentCommentId, String comment) async {

      Map<String, dynamic> commentRequestBody = CommentRequestModel(comment: comment).toJson();

      final response = await http.post(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/comment/${parentCommentId.toString()}/comment'),
         body: jsonEncode(commentRequestBody),
         headers: {
            'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
            'Content-Type': 'application/json; charset=UTF-8'
         },
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('대댓글 입력 성공');
         CommentResponseModel model = CommentResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
         return model;
      } else {
         print('대댓글 입력 실패');
         return CommentResponseModel();
      }
   }

   Future<CommentResponseModel> commentLikeRequest(int commentId) async {

      print('comment id : ${commentId.toString()}');

      final response = await http.post(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/comment/${commentId.toString()}/like'),
         headers: {
            'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
            'Content-Type': 'application/json; charset=UTF-8'
         },
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('댓글 좋아요 성공');
         var logger = Logger(
            printer: PrettyPrinter(
               lineLength: 120,
               colors: true,
               printTime: true,
            ),
         );
         logger.d('댓글 좋아요 리스폰스 : ${jsonDecode(utf8.decode(response.bodyBytes))['data']}');
         CommentResponseModel model = CommentResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
         return model;
      } else {
         print('댓글 좋아요 실패');
         return CommentResponseModel();
      }
   }

   Future<CommentResponseModel> commentUnlikeRequest(int commentId) async {

      print('comment id : ${commentId.toString()}');

      final response = await http.post(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/comment/${commentId.toString()}/unlike'),
         headers: {
            'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
            'Content-Type': 'application/json; charset=UTF-8'
         },
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('댓글 좋아요 취소 성공');
         var logger = Logger(
            printer: PrettyPrinter(
               lineLength: 120,
               colors: true,
               printTime: true,
            ),
         );
         logger.d('댓글 좋아요 취소 리스폰스 : ${jsonDecode(utf8.decode(response.bodyBytes))['data']}');
         CommentResponseModel model = CommentResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
         return model;
      } else {
         print('댓글 좋아요 취소 실패');
         return CommentResponseModel();
      }
   }
}

class CommentResponseModel {
   int? parentCommentId;
   int? id;
   PostBottomInfo? postBottomInfo;
   CommentUser? commentUser;
   String? content;
   int? likeCount;
   int? point;
   String? created;
   String? modified;
   bool? isActive;
   bool? isDelete;
   bool? isLiked;
   bool? isCommented;
   List<ChildComment>? childCommentList = [];

   CommentResponseModel({
      this.parentCommentId,
      this.id,
      this.postBottomInfo,
      this.commentUser,
      this.content,
      this.likeCount,
      this.point,
      this.created,
      this.modified,
      this.isActive,
      this.isDelete,
      this.isLiked,
      this.isCommented,
      this.childCommentList,
   });

   CommentResponseModel.fromJson(dynamic json) {
      parentCommentId = json['parent_comment'] ?? -1;
      id = json['id'] ?? -1;
      postBottomInfo = json['post'] != null ? PostBottomInfo.fromJson(json['post']) : null;
      commentUser = json['user'] != null ? CommentUser.fromJson(json['user']) : null;
      content = json['content'] ?? '';
      likeCount = json['like_count'] ?? -1;
      point = json['point'] ?? -1;
      created = json['created'] ?? DateTime.now().toString();
      modified = json['modified'] ?? DateTime.now().toString();
      isActive = json['is_active'] ?? false;
      isDelete = json['is_deleted'] ?? false;
      isLiked = json['is_liked'] ?? false;
      isCommented = json['is_commented'] ?? false;
      json['child_comments'] == [] || json['child_comments'] == null ? childCommentList = []
      : json['child_comments'].forEach((v) {
         childCommentList!.add(ChildComment.fromJson(v));
      });
   }
}

class PostBottomInfo {
   int? id;
   int? commentCount;
   int? likeCount;
   bool? isCommented;
   bool? isLiked;

   PostBottomInfo({
      this.id,
      this.commentCount,
      this.likeCount,
      this.isCommented,
      this.isLiked,
   });

   PostBottomInfo.fromJson(dynamic json) {
      id = json['id'] ?? -1;
      commentCount = json['comment_count'] ?? -1;
      likeCount = json['like_count'] ?? -1;
      isCommented = json['is_commented'] ?? false;
      isLiked = json['is_liked'] ?? false;
   }
}

class CommentUser {
   int? id;
   String? email;
   String? username;
   String? profileImageUrl;

   CommentUser({
      this.id,
      this.email,
      this.username,
      this.profileImageUrl,
   });

   CommentUser.fromJson(dynamic json) {
      id = json['id'] ?? -1;
      email = json['email'] ?? '';
      username = json['username'] ?? '';
      profileImageUrl = json['profile_image_url'] ?? '';
   }
}

class ChildComment {
   int? parentCommentId;
   int? childCommentId;
   PostBottomInfo? postBottomInfo;
   ChildCommentUser? childCommentUser;
   String? content;
   int? likeCount;
   int? point;
   String? createdTime;
   String? modifiedTime;
   bool? isActive;
   bool? isDeleted;
   bool? isLiked;

   ChildComment({
      this.parentCommentId,
      this.childCommentId,
      this.postBottomInfo,
      this.childCommentUser,
      this.content,
      this.likeCount,
      this.point,
      this.createdTime,
      this.modifiedTime,
      this.isActive,
      this.isDeleted,
      this.isLiked,
   });

   ChildComment.fromJson(dynamic json) {
      parentCommentId = json['parent_comment'] ?? -1;
      childCommentId = json['id'] ?? -1;
      postBottomInfo = json['post'] != null ? PostBottomInfo.fromJson(json['post']) : null;
      childCommentUser = json['user'] != null ? ChildCommentUser.fromJson(json['user']) : null;
      content = json['content'] ?? '';
      likeCount = json['like_count'] ?? -1;
      point = json['point'] ?? -1;
      createdTime = json['created'] ?? DateTime.now();
      modifiedTime = json['modified'] ?? DateTime.now();
      isActive = json['is_active'] ?? false;
      isDeleted = json['is_deleted'] ?? false;
      isLiked = json['is_liked'] ?? false;
   }
}

class ChildCommentUser {
   int? id;
   String? username;
   String? profileImageUrl;

   ChildCommentUser({
      this.id,
      this.username,
      this.profileImageUrl,
   });

   ChildCommentUser.fromJson(dynamic json) {
      id = json['id'] ?? -1;
      username = json['username'] ?? '';
      profileImageUrl = json['profile_image_url'] ?? '';
   }
}

class CommentRequestModel {
   static List<String> description = ['댓글테스트'];
   static List<String> profileImage = [''];
   static List<String> name = ['엘리예요'];
   static List<String> writeDateTime = ['7시간'];
   static List<int> likeCount = [0];
   static List<bool> likeState = [false];
   static List<int> subCommentCount = [0];
   static List<List<String>> subCommentDescription = [];

   ///
   String? comment;

   CommentRequestModel({
      this.comment,
   });

   Map<String, dynamic> toJson() => {
      'content': comment
   };
}
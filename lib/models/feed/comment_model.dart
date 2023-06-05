import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/login/login_model.dart';

class CommentRequest {

   Future<List<CommentResponseModel>> commentRequest(int postId) async {

      final response = await http.get(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/post/${postId.toString()}/comments'),
         headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('댓글 불러오기 성공');
         List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
         List<CommentResponseModel> commentModels = body.map((e) => CommentResponseModel.fromJson(e)).toList();

         return commentModels;
      } else {
         print('댓글 불러오기 실패');
         throw Exception;
      }
   }

   Future<bool> commentWriteRequest(int postId, String comment) async {

      Map<String, dynamic> commentRequestBody = CommentRequestModel(comment: comment).toJson();

      final response = await http.post(
         Uri.parse('https://dev.server.sense.runners.im/api/v1/post/${postId.toString()}/comment'),
         body: jsonEncode(commentRequestBody),
         headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
         print('댓글 입력 성공');

         return true;
      } else {
         print('댓글 입력 실패');
         print(PresentUserInfo.id);
         return false;
      }
   }
}

class CommentResponseModel {
   int? parentCommentId;
   int? id;
   int? postId;
   CommentUser? commentUser;
   String? content;
   int? likeCount;
   int? point;
   String? created;
   String? modified;
   bool? isActive;
   bool? isDelete;
   bool? isLiked;
   List<ChildComment>? childCommentList = [];

   CommentResponseModel({
      this.parentCommentId,
      this.id,
      this.postId,
      this.commentUser,
      this.content,
      this.likeCount,
      this.point,
      this.created,
      this.modified,
      this.isActive,
      this.isDelete,
      this.isLiked,
      this.childCommentList,
   });

   CommentResponseModel.fromJson(dynamic json) {
      parentCommentId = json['parent_comment'] ?? -1;
      id = json['id'] ?? -1;
      postId = json['post'] ?? -1;
      commentUser = json['user'] != null ? CommentUser.fromJson(json['user']) : null;
      content = json['content'] ?? '';
      likeCount = json['like_count'] ?? -1;
      point = json['point'] ?? -1;
      created = json['created'] ?? DateTime.now();
      modified = json['modified'] ?? DateTime.now();
      isActive = json['is_active'] ?? false;
      isDelete = json['is_deleted'] ?? false;
      isLiked = json['is_liked'] ?? false;
      json['child_comments'].forEach((v) {
         childCommentList!.add(ChildComment.fromJson(v));
      }) ?? [];
   }
}

class CommentUser {
   int? id;
   String? username;
   String? profileImageUrl;

   CommentUser({
      this.id,
      this.username,
      this.profileImageUrl,
   });

   CommentUser.fromJson(dynamic json) {
      id = json['id'] ?? -1;
      username = json['username'] ?? '';
      profileImageUrl = json['profile_image_url'] ?? '';
   }
}

class ChildComment {
   int? parentCommentId;
   int? childCommentId;
   int? postId;
   ChildCommentUser? childCommentUser;
   String? content;
   int? likeCount;
   int? point;
   String? createdTime;
   String? modifiedTime;
   bool? isActive;
   bool? isDeleted;
   // bool? isLiked;

   ChildComment({
      this.parentCommentId,
      this.childCommentId,
      this.postId,
      this.childCommentUser,
      this.content,
      this.likeCount,
      this.point,
      this.createdTime,
      this.modifiedTime,
      this.isActive,
      this.isDeleted,
      // this.isLiked,
   });

   ChildComment.fromJson(dynamic json) {
      parentCommentId = json['parent_comment'] ?? -1;
      childCommentId = json['id'] ?? -1;
      postId = json['post'] ?? -1;
      childCommentUser = json['user'] != null ? ChildCommentUser.fromJson(json['user']) : null;
      content = json['content'] ?? '';
      likeCount = json['like_count'] ?? -1;
      point = json['point'] ?? -1;
      createdTime = json['created'] ?? DateTime.now();
      modifiedTime = json['modified'] ?? DateTime.now();
      isActive = json['is_active'] ?? false;
      isDeleted = json['is_deleted'] ?? false;
      // isLiked = json['is_liked'] ?? false;
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
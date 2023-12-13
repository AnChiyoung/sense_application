import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sense_flutter_application/api/api.dart';

class PostImageResponseData {
  final int id;
  final String file;
  final String url;
  final String type;

  PostImageResponseData({
    required this.id,
    required this.file,
    required this.url,
    required this.type,
  });

  factory PostImageResponseData.fromJson(Map<String, dynamic> json) {
    return PostImageResponseData(
      id: json['id'] ?? -1,
      file: json['file'] ?? '',
      url: json['url'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'file': file,
        'url': url,
        'type': type,
      };

  @override
  String toString() => 'PostImageResponseData(id: $id, file: $file, url: $url, type: $type)';
}

class MediaRepository {
  Future<PostImageResponseData?> postImage({
    required XFile image,
  }) async {
    try {
      final bytes = await File(image.path).readAsBytes();
      String convertString = base64Encode(bytes);

      final response = await ApiRequest().post(
        url: '/image',
        fromJson: PostImageResponseData.fromJson,
        data: {
          'file': convertString,
        },
      );

      return response.data;
    } catch (e) {
      debugPrint('postImage(): ${e.toString()}');
      return null;
    }
  }
}

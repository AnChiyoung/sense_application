import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/api/api_path.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/utils/utility.dart';

class DjangoResponse<T> {
  final int code;
  final String message;
  final T? data;

  DjangoResponse({
    this.code = 0,
    this.message = '',
    this.data,
  });

  factory DjangoResponse.fromJson(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    T? data = json['data'] == null ? null : fromJson(json['data']);

    return DjangoResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: data,
    );
  }
}

class DjangoListResponse<T> {
  final int code;
  final String message;
  final int count;
  final String? next;
  final String? previous;
  final List<T> data;

  DjangoListResponse({
    this.code = 0,
    this.message = '',
    this.count = 0,
    this.next,
    this.previous,
    this.data = const [],
  });

  factory DjangoListResponse.fromJson(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    List<T> dataList = (json['data'] as List<dynamic>).map((e) => fromJson(e)).toList();

    return DjangoListResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      data: dataList,
    );
  }
}

class ApiRequest {
  // singleton
  static final ApiRequest _instance = ApiRequest._internal();
  ApiRequest._internal();
  factory ApiRequest() => _instance;

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  Future<DjangoListResponse<T>> getList<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String> extraHeaders = const {},
    bool withToken = false,
    Map<String, dynamic>? params,
  }) async {
    try {
      Map<String, String> headers = {
        ..._headers,
        ...extraHeaders,
      };
      if (withToken) {
        headers['Authorization'] = 'Bearer ${PresentUserInfo.loginToken}';
      }

      final response = await http.get(
        Uri.parse('${ApiUrl.releaseUrl}$url${Utils().toQueryString(params)}'),
        headers: headers,
      );

      if (response.statusCode >= 200 || response.statusCode < 300) {
        return DjangoListResponse.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
          fromJson,
        );
      } else {
        throw Exception('Failed to fetch list $url');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DjangoResponse<T>> get<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String> extraHeaders = const {},
    bool withToken = false,
    Map<String, dynamic>? params,
  }) async {
    try {
      Map<String, String> headers = {
        ..._headers,
        ...extraHeaders,
      };
      if (withToken) {
        headers['Authorization'] = 'Bearer ${PresentUserInfo.loginToken}';
      }

      final response = await http.get(
        Uri.parse('${ApiUrl.releaseUrl}$url${Utils().toQueryString(params)}'),
        headers: headers,
      );

      if (response.statusCode >= 200 || response.statusCode < 300) {
        return DjangoResponse.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
          fromJson,
        );
      } else {
        throw Exception('Failed to fetch $url');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // 좀 더 고도화 하기
  Future<DjangoResponse<T>> post<T>({
    required String url,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String> extraHeaders = const {},
    bool withToken = false,
    Map<String, dynamic>? data,
  }) async {
    try {
      Map<String, String> headers = {
        ..._headers,
        ...extraHeaders,
      };
      if (withToken) {
        headers['Authorization'] = 'Bearer ${PresentUserInfo.loginToken}';
      }

      final response = await http.post(
        Uri.parse('${ApiUrl.releaseUrl}$url'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode >= 200 || response.statusCode < 300) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));

        if (fromJson != null) {
          return DjangoResponse.fromJson(
            json,
            fromJson,
          );
        }

        return DjangoResponse(
          code: json['code'] as int,
          message: json['message'] as String,
          data: json['data'] as dynamic,
        );
      } else {
        throw Exception('Failed to fetch $url');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

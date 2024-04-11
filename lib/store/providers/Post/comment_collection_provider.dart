import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/service/api_service.dart';

final futureCommentProvider = FutureProvider.autoDispose.family<void, String>((ref, postId) async {
  return ref.read(commentProvider.notifier).fetchComments(postId);
});

final futureCommentNextProvider =
    FutureProvider.autoDispose.family<void, String>((ref, postId) async {
  return ref.read(commentProvider.notifier).fetchComments(postId);
});

final commentProvider =
    StateNotifierProvider.autoDispose<CommentCollection, Map<String, dynamic>>((ref) {
  ref.onDispose(() {
    print('disposed commentProvider');
  });
  return CommentCollection();
});

class CommentCollection extends StateNotifier<Map<String, dynamic>> {
  CommentCollection() : super({});

  Future<void> fetchComments(String postId) async {
    if (state.isEmpty) {
      PostApi().getPostComments(postId).then((value) {
        setComments = value;
      });
    }
  }

  Future<void> loadMoreComments() async {
    if (state['next'] != null) {
      ApiService.get('', fullUrl: state['next']).then((response) {
        var parse = json.decode(utf8.decode(response.bodyBytes));
        setComments = {
          ...parse,
          ...{
            'data': [...state['data'], ...parse['data']]
          }
        };
      });
    }
  }

  void addComment(Map<String, dynamic> comment) {
    List<dynamic> comments = state['data'];
    comments.insert(0, comment['data']);
    setComments = {
      ...state,
      ...{'data': comments}
    };
  }

  void addChildComment(Map<String, dynamic> comment) {
    List<dynamic> comments = state['data'];
    int parentIndex = comments.indexWhere((element) => element['id'] == comment['id']);
    comments[parentIndex] = comment;

    setComments = {
      ...state,
      ...{'data': comments}
    };
  }

  void removeComment(int commentId) {
    List<dynamic> comments =
        state['comments'].where((element) => element['id'] != commentId).toList();
    setComments = {
      ...state,
      ...{'comments': comments}
    };
  }

  set setComments(Map<String, dynamic> comments) {
    state = comments;
  }
}

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

final commentCountProvider = StateProvider.autoDispose((ref) {
  return ref.watch(commentProvider)['count'];
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
      ...{'data': comments, 'count': state['count'] + 1}
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

  void likeAcomment(Map<String, dynamic> comment) {
    // print(comment);
    List<dynamic> comments = state['data'];
    int parentIndex = comments.indexWhere(
        (element) => element['id'] == (comment['parent_comment'] as int? ?? comment['id']));

    if (comment['parent_comment'] != null) {
      var children = comments[parentIndex]['child_comments'];
      comments[parentIndex]['child_comments'] = children?.map((e) {
        if (e['id'] == comment['id']) {
          return comment;
        }
        return e;
      }).toList();
    } else {
      comments[parentIndex] = comment;
    }

    setComments = {
      ...state,
      ...{'data': comments}
    };
  }

  void removeComment(int commentId) {
    List<dynamic> comments = state['data'].where((element) => element['id'] != commentId).toList();
    setComments = {
      ...state,
      ...{'data': comments, 'count': state['count'] - 1}
    };
  }

  set setComments(Map<String, dynamic> comments) {
    state = comments;
  }
}

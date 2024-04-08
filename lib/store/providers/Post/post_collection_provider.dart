import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/models/comment.dart';

final postCollectionProvider = StateNotifierProvider<PostCollection, Map<String, dynamic>>((ref) {
  return PostCollection();
});

final singlePostCollectionProvider =
    StateNotifierProvider.autoDispose<SinglePostCollection, Map<String, dynamic>>((ref) {
  ref.onDispose(() {
    print('disposed');
  });
  return SinglePostCollection();
});

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final commentProvider = StateNotifierProvider<CommentCollection, Map<String, dynamic>>((ref) {
  return CommentCollection();
});

class CommentCollection extends StateNotifier<Map<String, dynamic>> {
  CommentCollection() : super({});

  Future<void> fetchComments(String postId) async {
    final response = await PostApi().getPostComments(postId);
    state = response;
  }

  Future<void> addComment(Comment comment) async {
    // state = {}
  }

  get comments => state;
}

class SinglePostCollection extends StateNotifier<Map<String, dynamic>> {
  SinglePostCollection() : super({});

  Future<void> fetchPost(String postId) async {
    PostApi().getPost(postId).then((value) {
      state = value;
    });

    print('state');
  }

  get post => state;
}

class PostCollection extends StateNotifier<Map<String, dynamic>> {
  PostCollection() : super({});

  get posts => state;

  Future<void> nextPost({String? url}) async {
    if (state['data'].length < state['count'] && state['next'] != null) {
      final response = await PostApi().getPosts(url: url);
      state = {
        ...response,
        'data': [...state['data'], ...response['data']]
      };
    }
  }

  void likeProduct(Map<String, dynamic> post, int productId) {
    // print(post['id']);
    // int postId = post['id'];
    // print(state['data']);
    // final index = state['data'].indexWhere((element) => element['id'] == postId);
    // print('index of store $index');
  }

  Future<void> refreshPosts({String? url, String? filter}) async {
    final response = await PostApi().getPosts(url: url, filter: filter);
    state = response;
  }

  Future<void> fetchPosts({String? url, String? filter}) async {
    if (state.isEmpty) {
      final response = await PostApi().getPosts(url: url, filter: filter);
      state = response;
    }
  }
}

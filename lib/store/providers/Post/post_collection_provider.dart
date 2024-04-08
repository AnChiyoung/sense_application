import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';

final postCollectionProvider = StateNotifierProvider<PostCollection, Map<String, dynamic>>((ref) {
  return PostCollection();
});

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

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

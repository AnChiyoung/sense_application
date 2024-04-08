import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/apis/product/product_api.dart';

final postFutureProvider = FutureProvider.autoDispose.family<void, String>((ref, postId) async {
  return ref.read(singlePostProvider.notifier).fetchPost(postId);
});

final singlePostProvider =
    StateNotifierProvider.autoDispose<SinglePostCollection, Map<String, dynamic>>((ref) {
  ref.onDispose(() {
    print('disposed provider');
  });
  return SinglePostCollection();
});

class SinglePostCollection extends StateNotifier<Map<String, dynamic>> {
  SinglePostCollection() : super({});

  Future<void> fetchPost(String postId) async {
    if (state.isEmpty) {
      PostApi().getPost(postId).then((value) {
        setPost = value;
      });
    }
  }

  Future<void> likeProduct(int productId) async {
    ProductApi().likeProduct(productId.toString()).then((value) {
      print(value);
    });
    List<dynamic> products = state['data']['store_products'].map((element) {
      if (element['id'] == productId) {
        element['is_liked'] = !(element['is_liked'] ?? false);
      }
      return element;
    }).toList();

    Map<String, dynamic> data = {
      ...state['data'],
      'store_products': [...products]
    };

    setPost = {
      ...state,
      ...{'data': data}
    };
  }

  set setPost(Map<String, dynamic> post) {
    state = post;
  }

  get post => state;
}

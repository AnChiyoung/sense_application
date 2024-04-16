import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/screens/widgets/common/post_card.dart';
import 'package:sense_flutter_application/store/providers/Post/post_collection_provider.dart';

class SingleCards extends ConsumerWidget {
  const SingleCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postCollection = ref.watch(postCollectionProvider);
    List<dynamic> data = postCollection['data'] ?? [];
    List<Widget> postWidgets = data.map((post) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PostCard(
            onTap: () {
              GoRouter.of(context).go('/post/${post['id']}');
            },
            subject: post['title'],
            subtext: post['sub_title'],
            thumbnail: post['thumbnail_media_url'],
          ));
    }).toList();

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 16),
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(children: postWidgets),
    );
  }
}

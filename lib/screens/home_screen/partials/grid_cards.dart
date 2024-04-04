// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/store/providers/Post/post_collection_provider.dart';

class GridCards extends ConsumerWidget {
  const GridCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postCollection = ref.watch(postCollectionProvider);
    List<dynamic> data = postCollection['data'] ?? [];
    final screenSize = MediaQuery.of(context).size;
    int columns = 2;

    if (screenSize.width >= 600 && screenSize.width < 1200) {
      columns = 3;
    } else if (screenSize.width >= 1200) {
      columns = 6;
    }

    print(data.length);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // Number of columns
        childAspectRatio: 162 / 212, // Aspect ratio of each item
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),

      // addAutomaticKeepAlives: false,
      // crossAxisSpacing: 12,
      // mainAxisSpacing: 16,
      itemCount: data.length,
      itemBuilder: ((context, index) {
        var post = data[index];
        return GridCard(
          image: post['thumbnail_media_url'],
          title: post['title'],
          description: post['sub_title'],
        );
      }),
    );
  }
}

class GridCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const GridCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    //  Text('향기 가득한 입생로랑 리브르 르 퍼퓸 5종류의 선물')
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

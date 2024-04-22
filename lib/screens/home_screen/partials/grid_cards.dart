// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/store/providers/Post/post_collection_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class GridCards extends ConsumerWidget {
  final EdgeInsets padding;
  const GridCards({super.key, required this.padding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postCollection = ref.watch(postCollectionProvider);
    List<dynamic> data = postCollection['data'] ?? [];
    final screenSize = MediaQuery.of(context).size;
    int columns = 2;
    double spacing = 12;
    double screenWidth =
        (MediaQuery.of(context).size.width) - (padding.left + padding.right + spacing);

    if (screenSize.width >= 600 && screenSize.width < 1200) {
      columns = 3;
    } else if (screenSize.width >= 1200) {
      columns = 6;
    }
    print(screenWidth);
    print('width ${screenSize.width}');
    print('actual ${(162 / 375 * screenSize.width)}');

    return Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns, // Number of columns
          childAspectRatio:
              (162 / 375 * screenWidth) / (212 / 375 * screenWidth), // Aspect ratio of each item
          crossAxisSpacing: spacing,
          mainAxisSpacing: 16,
        ),

        // addAutomaticKeepAlives: false,
        // crossAxisSpacing: 12,
        // mainAxisSpacing: 16,
        itemCount: data.length,
        itemBuilder: ((context, index) {
          var post = data[index];
          return GridCard(
            screenWidth: screenWidth,
            onTap: () {
              GoRouter.of(context).push('/post/${post['id']}');
            },
            image: post['thumbnail_media_url'],
            title: post['title'],
            description: post['sub_title'],
          );
        }),
      ),
    );
  }
}

class GridCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onTap;
  final double screenWidth;

  const GridCard(
      {super.key,
      required this.screenWidth,
      required this.image,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    //  Text('향기 가득한 입생로랑 리브르 르 퍼퓸 5종류의 선물')
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
              color: primaryColor[50],
            )),
            imageBuilder: (context, imageProvider) => AspectRatio(
              aspectRatio: (162 / 375 * screenWidth) / (162 / 375 * screenWidth),
              child: Container(
                // width: 162,
                // height: 162,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SizedBox(height: (10 / 375 * screenWidth)),
          Text(
            title.replaceAll('\n', ' '),
            style: TextStyle(
              fontSize: (14 / 375 * screenWidth),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

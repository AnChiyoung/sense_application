import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/screens/layouts/post_page_layout.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/content_body.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/content_header.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/post_thumbnail.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/store_products.dart';
import 'package:sense_flutter_application/store/providers/Post/post_collection_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class SinglePostScreen extends StatefulWidget {
  final int id;

  const SinglePostScreen({super.key, required this.id});
  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> with WidgetsBindingObserver {
  Future<Map<String, dynamic>> getPost(String id) async {
    return await PostApi().getPost(id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.light(
          primary: primaryColor[50] ?? Colors.white,
          secondary: secondary1Color[50] ?? Colors.white,
          onPrimary: primaryColor[50] ?? Colors.white,
        ),
      ),
      home: Consumer(
        builder: ((context, ref, child) {
          return PostPageLayout(
            title: '',
            body: RefreshIndicator(
                onRefresh: () async {
                  ref.read(postCollectionProvider.notifier).refreshPosts();
                },
                child: SingleChildScrollView(
                    // controller: scrollController,
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    child: FutureBuilder(
                        future: getPost(widget.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryColor[50] ?? Colors.white),
                                ),
                              ),
                            );
                          }

                          Map<String, dynamic> post = snapshot.data as Map<String, dynamic>;

                          print(post['data']['id']);
                          print(post['data']['store_products']);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PostThumbnail(
                                imageUrl: post['data']['thumbnail_media_url'],
                                title: post['data']['title'],
                                subTitle: post['data']['sub_title'],
                                date: DateTime.parse(post['data']['created'])
                                    .toString()
                                    .substring(0, 10)
                                    .replaceAll('-', '.'),
                                likeCount: post['data']['like_count'].toString(),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ContentHeader(
                                      title: post['data']['content_title'] ?? '',
                                      startDate: post['data']['start_date'],
                                      endDate: post['data']['end_date'],
                                    ),
                                    ContentBody(body: post['data']['content'] ?? []),
                                    const StoreProducts()
                                  ],
                                ),
                              )
                            ],
                          );
                        }))),
          );
        }),
      ),
    );
  }
}

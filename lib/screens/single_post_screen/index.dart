import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/chip_list_tab.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/grid_cards.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/single_cards.dart';
import 'package:sense_flutter_application/screens/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/layouts/post_page_layout.dart';
import 'package:sense_flutter_application/screens/widgets/banner_area.dart';
import 'package:sense_flutter_application/store/providers/Post/post_collection_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';

class SinglePostScreen extends StatefulWidget {
  final int id;

  const SinglePostScreen({super.key, required this.id});
  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> with WidgetsBindingObserver {
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
                child: const SingleChildScrollView(
                    // controller: scrollController,
                    padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [],
                    ))),
          );
        }),
      ),
    );
  }
}

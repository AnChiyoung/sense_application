import 'package:flutter/widgets.dart';
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
                child: SingleChildScrollView(
                    // controller: scrollController,
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 375 / 420,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('lib/assets/images/cover.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color.fromRGBO(21, 21, 21, 0.60),
                                      Color.fromRGBO(21, 21, 21, 0.00),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        child: Text(
                                          '이번 여름은\n'
                                          '‘카캉스\' 어때요?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text('카페에서 보내는 바캉스 스팟 5곳',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 24),
                                      IntrinsicHeight(
                                          child: Row(
                                        children: [
                                          const Text('2023.02.01',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500)),
                                          const VerticalDivider(
                                            color: Colors.white,
                                            thickness: 1,
                                            width: 20,
                                          ),
                                          SvgPicture.asset('lib/assets/images/icons/svg/heart.svg',
                                              width: 16, height: 16, color: Colors.white),
                                          const SizedBox(width: 4),
                                          const Text('4.8 M',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500))
                                        ],
                                      ))
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ))),
          );
        }),
      ),
    );
  }
}

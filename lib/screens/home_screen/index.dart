import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/chip_list_tab.dart';
import 'package:sense_flutter_application/screens/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import '../../utils/global_extentions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.light(
          primary: primaryColor[50] ?? Colors.white,
          secondary: secondary1Color[50] ?? Colors.white,
          onPrimary: primaryColor[50] ??  Colors.white,
        ),
      ),
      home: const MainLayout(
      title: '',
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChipListTab(chipList: ['추천', '디저트', '케이크', '비빔밥', '내가 찜한 콘텐츠', '맛집', '추천', '디저트', '케이크', '비빔밥', '내가 찜한 콘텐츠', '맛집']),
          ],
        )
      ),
      // floating: 
        // FloatingActionButton(
        //   onPressed: () {
        //     // 
        //   },
        //   shape: const CircleBorder(),
        //   child: 
        //     SvgPicture
        //       .asset(
        //         'lib/assets/images/icons/svg/plus.svg',
        //         color: Colors.white,
        //         width: 24,
        //         height: 24,
        //         fit: BoxFit.cover,
        //       ),
        // ),
    ),
    );
  }
}
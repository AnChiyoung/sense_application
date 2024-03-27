// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/chip_list_tab.dart';
import 'package:sense_flutter_application/screens/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/widgets/banner_area.dart';
import 'package:sense_flutter_application/screens/widgets/common/post_card.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
    bottom: 110,
    left: 0,
    right: 0,
    child: Center(
      child: ElevatedButton.icon(
      onPressed: () {
        // Add your button action here
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(85, 85, 85, 1)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      icon: SvgPicture.asset('lib/assets/images/icons/svg/grid_view.svg', width: 20, height: 20, color: Colors.white,),
      label: Text('모아보기', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),)
      ),
    ),
    ),
  );

  @override
  dispose() {
    super.dispose();
    overlayEntry.remove();
  }
  
  @override
  Widget build(BuildContext context) {

    Future<void> showButtonFormat() async {
      await Future.delayed(Duration(seconds: 2));
      if (context.mounted) {
        floatingButtonAction(context);
      }
    }

    showButtonFormat();

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.light(
          primary: primaryColor[50] ?? Colors.white,
          secondary: secondary1Color[50] ?? Colors.white,
          onPrimary: primaryColor[50] ??  Colors.white,
        ),
      ),
      home: Consumer(
        builder: ((context, ref, child) {

            // ref.watch();

          return 
          MainLayout(
            title: '',
            body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  BannerArea(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.amber[200]?.withOpacity(0.7)
                        ),
                        child: Image.asset('lib/assets/images/banner_1.png', fit: BoxFit.cover,),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.amber[200]?.withOpacity(0.7)
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.red[200]?.withOpacity(0.7)
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.green[200]?.withOpacity(0.7)
                        ),
                      )
                    ]
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 20),
                    child: 
                      ChipListTab(
                        chipList: [
                          '추천',
                          '디저트',
                          '케이크',
                          '비빔밥',
                          '내가 찜한 콘텐츠',
                          '맛집',
                          '추천',
                          '디저트',
                          '케이크',
                          '비빔밥',
                          '내가 찜한 콘텐츠',
                          '맛집'
                        ]
                      ),
                  ),

                  // Content
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(top: 16),
                    constraints: BoxConstraints(
                      maxWidth: 500
                    ),
                    child: Column(
                      children: [
                      ...List.generate(10, 
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: PostCard(
                            subject: '향기 가득한 입생로랑 리브르 르 퍼퓸 - ${index + 1}',
                            subtext: '향기 가득한 입생로랑 리브르 르 퍼퓸 외 5종',)
                          ),
                        )
                    ],),
                  )
                ],
              )
            ),
          );
        }
    ),
      
      ),
    );
  }

  void floatingButtonAction(BuildContext context) {
    Overlay.of(context).insert(overlayEntry);
  }
}
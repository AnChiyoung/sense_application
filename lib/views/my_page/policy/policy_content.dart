import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyContent extends StatefulWidget {
  const PolicyContent({super.key});

  @override
  State<PolicyContent> createState() => _PolicyContentState();
}

class _PolicyContentState extends State<PolicyContent> with TickerProviderStateMixin {

  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SingleChildScrollView(child: SizedBox(width: double.infinity,
        child:
        FutureBuilder(
            future: rootBundle.loadString('assets/policy/policy01.md'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if(snapshot.hasData) {
                return ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                        child: MarkdownBody(
                          data: snapshot.data!,
                          styleSheet: MarkdownStyleSheet(
                            h1: TextStyle(fontSize: 20.0.sp, color: Colors.black, fontWeight: FontWeight.w700),
                            h3: TextStyle(fontSize: 16.0.sp, color: Colors.black, fontWeight: FontWeight.w600),
                            // h2: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w400),
                            blockquoteDecoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if(snapshot.hasError) {
                return const SizedBox.shrink();
              } else {
                return const SizedBox.shrink();
              }
            }
        )
    )
    )
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 20.0.w),
    //   child: DefaultTabController(
    //     length: 3,
    //     child: Column(
    //       children: [
    //         TabBar(
    //           controller: _controller,
    //           labelColor: StaticColor.mainSoft,
    //           labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
    //           unselectedLabelColor: StaticColor.grey70055,
    //           indicatorWeight: 3,
    //           indicator: UnderlineTabIndicator(
    //             borderSide: BorderSide(color: StaticColor.mainSoft, width: 3.0),
    //           ),
    //           unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
    //           tabs: [
    //             SizedBox(
    //               height: 37.0.h,
    //               child: const Tab(
    //                   text: '개인정보 처리방침'
    //               ),
    //             ),
    //             SizedBox(
    //               height: 37.0.h,
    //               child: const Tab(
    //                   text: '이용약관'
    //               ),
    //             ),
    //           ],
    //         ),
    //         Expanded(
    //           child: TabBarView(
    //             controller: _con,
    //             children: [
    //               SettingPersonalPolicy(),
    //               SettingUsePolicy(),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    // return FutureBuilder(
    //     future: rootBundle.loadString('assets/policy/policy01.md'),
    //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //       if(snapshot.hasData) {
    //         return SingleChildScrollView(
    //           child: Expanded(
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
    //               child: MarkdownBody(
    //                 data: snapshot.data!,
    //                 styleSheet: MarkdownStyleSheet(
    //                   h3: TextStyle(fontSize: 16.0.sp, color: Colors.black, fontWeight: FontWeight.w700),
    //                   // h2: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w400),
    //                   blockquoteDecoration: BoxDecoration(
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       } else if(snapshot.hasError) {
    //         return Text('no data..');
    //       } else {
    //         return Text('no data..');
    //       }
    //     }
    // );
  }
}

class SettingPersonalPolicy extends StatelessWidget {
  const SettingPersonalPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SettingUsePolicy extends StatelessWidget {
  const SettingUsePolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

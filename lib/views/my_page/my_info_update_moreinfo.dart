import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/constants.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class MyMoreInfo extends StatefulWidget {
  final double? topPadding;
  const MyMoreInfo({super.key, this.topPadding});

  @override
  State<MyMoreInfo> createState() => _MyMoreInfoState();
}

class _MyMoreInfoState extends State<MyMoreInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserRequest().userInfoRequest(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
            } else if (snapshot.connectionState == ConnectionState.done) {
              UserModel userModel = UserModel();
              bool fromMyPage =
                  context.read<MyPageProvider>().prevRoute == MyPagePrevRouteEnum.fromMyPage;

              if (fromMyPage) {
                userModel = snapshot.data ?? UserModel();
              }

              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(children: [
                      if (fromMyPage) ...[
                        SizedBox(height: 40.0.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '성별',
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              color: StaticColor.grey70055,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0.h),
                        MoreInfoGender(initializeGender: userModel.gender),
                        // BasicInfoName(initializeName: userModel.username!),
                        SizedBox(height: 24.0.h),
                      ],
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('현재상태',
                              style: TextStyle(
                                  fontSize: 16.0.sp,
                                  color: StaticColor.grey70055,
                                  fontWeight: FontWeight.w700))),
                      SizedBox(height: 8.0.h),
                      MoreInfoPresentState(initializeState: userModel.relationshipStatus),
                      SizedBox(height: 24.0.h),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('MBTI',
                              style: TextStyle(
                                  fontSize: 16.0.sp,
                                  color: StaticColor.grey70055,
                                  fontWeight: FontWeight.w700))),
                      SizedBox(height: 8.0.h),
                      MoreInfoMBTI(initializeMBTI: userModel.mbti, topPadding: widget.topPadding),
                      SizedBox(height: 24.0.h),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('자차여부',
                              style: TextStyle(
                                  fontSize: 16.0.sp,
                                  color: StaticColor.grey70055,
                                  fontWeight: FontWeight.w700))),
                      SizedBox(height: 8.0.h),
                      MoreInfoOwnCar(initializeOwnCar: userModel.isOwnCar),
                    ]),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: MyMoreInfoButton(),
                  ),
                ],
              );
            } else {
              return Center(
                  child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
            }
          } else if (snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class MoreInfoGender extends StatefulWidget {
  final String? initializeGender;
  const MoreInfoGender({super.key, this.initializeGender});

  @override
  State<MoreInfoGender> createState() => _MoreInfoGenderState();
}

class _MoreInfoGenderState extends State<MoreInfoGender> {
  int trueOrder = -1;

  @override
  void initState() {
    if (widget.initializeGender == 'MALE') {
      trueOrder = 0;
    } else if (widget.initializeGender == 'FEMALE') {
      trueOrder = 1;
    }
    context.read<MyPageProvider>().genderInit(trueOrder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      trueOrder = data.genderState;

      return Row(
        children: [
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<MyPageProvider>().genderStateChange(0);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: trueOrder == 0 ? StaticColor.mainSoft : StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('남',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: trueOrder == 0 ? Colors.white : StaticColor.grey70055,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
          ),
          SizedBox(width: 12.0.w),
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<MyPageProvider>().genderStateChange(1);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: trueOrder == 1 ? StaticColor.mainSoft : StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('여',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: trueOrder == 1 ? Colors.white : StaticColor.grey70055,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class MoreInfoPresentState extends StatefulWidget {
  final String? initializeState;
  const MoreInfoPresentState({super.key, this.initializeState});

  @override
  State<MoreInfoPresentState> createState() => _MoreInfoPresentStateState();
}

class _MoreInfoPresentStateState extends State<MoreInfoPresentState> {
  int trueOrder = -1;

  @override
  void initState() {
    if (widget.initializeState == '솔로') {
      trueOrder = 0;
    } else if (widget.initializeState == '연애중') {
      trueOrder = 1;
    } else if (widget.initializeState == '기혼') {
      trueOrder = 2;
    } else {
      trueOrder = -1;
    }
    context.read<MyPageProvider>().relationInit(trueOrder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      trueOrder = data.relationState;

      return Row(
        children: [
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<MyPageProvider>().relationStateChange(0);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: trueOrder == 0 ? StaticColor.mainSoft : StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('솔로',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: trueOrder == 0 ? Colors.white : StaticColor.grey70055,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
          ),
          SizedBox(width: 12.0.w),
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<MyPageProvider>().relationStateChange(1);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: trueOrder == 1 ? StaticColor.mainSoft : StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('연애중',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: trueOrder == 1 ? Colors.white : StaticColor.grey70055,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
          ),
          SizedBox(width: 12.0.w),
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<MyPageProvider>().relationStateChange(2);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: trueOrder == 2 ? StaticColor.mainSoft : StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('기혼',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: trueOrder == 2 ? Colors.white : StaticColor.grey70055,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class MoreInfoMBTI extends StatefulWidget {
  final String? initializeMBTI;
  final double? topPadding;
  const MoreInfoMBTI({super.key, this.initializeMBTI, this.topPadding});

  @override
  State<MoreInfoMBTI> createState() => _MoreInfoMBTIState();
}

class _MoreInfoMBTIState extends State<MoreInfoMBTI> {
  String mbti = '';
  int mbtiOrder = -1;

  @override
  void initState() {
    String temp = widget.initializeMBTI ?? '';
    if (temp.isEmpty) {
      mbtiOrder = -1;
    } else {
      for (int i = 0; i < Constants.mbtiTypes.length; i++) {
        if (Constants.mbtiTypes.elementAt(i).contains(temp.toUpperCase())) {
          mbtiOrder = i;
        }
      }
      context.read<MyPageProvider>().mbtiInit(mbtiOrder);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      mbtiOrder = data.saveMbti;
      if (mbtiOrder == -1) {
        mbti = 'MBTI를 설정해 주세요';
      } else {
        mbti = Constants.mbtiTypes.elementAt(mbtiOrder);
      }

      return Row(
        children: [
          Flexible(
            flex: 1,
            child: Material(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(4.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    builder: (context) {
                      return SizedBox(
                        height: 460.0.h,
                        child: const MBTIview(),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 16.0.w),
                  width: double.infinity,
                  child: Text(
                    mbti,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: mbtiOrder == -1 ? StaticColor.grey400BB : StaticColor.grey70055,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class MoreInfoOwnCar extends StatefulWidget {
  final bool? initializeOwnCar;
  const MoreInfoOwnCar({super.key, this.initializeOwnCar});

  @override
  State<MoreInfoOwnCar> createState() => _MoreInfoOwnCarState();
}

class _MoreInfoOwnCarState extends State<MoreInfoOwnCar> {
  int trueOrder = -1;

  @override
  void initState() {
    if (widget.initializeOwnCar == true) {
      trueOrder = 0;
    }
    if (widget.initializeOwnCar == false) {
      trueOrder = 1;
    }
    context.read<MyPageProvider>().ownCarInit(trueOrder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      trueOrder = data.ownCar;

      return Row(
        children: [
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<MyPageProvider>().ownCarChange(0);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: trueOrder == 0 ? StaticColor.mainSoft : StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('자차 있음',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: trueOrder == 0 ? Colors.white : StaticColor.grey70055,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
          ),
          SizedBox(width: 12.0.w),
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<MyPageProvider>().ownCarChange(1);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: trueOrder == 1 ? StaticColor.mainSoft : StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('자차 없음',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: trueOrder == 1 ? Colors.white : StaticColor.grey70055,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class MyMoreInfoButton extends StatefulWidget {
  const MyMoreInfoButton({super.key});

  @override
  State<MyMoreInfoButton> createState() => _MyMoreInfoButtonState();
}

/// @todo 리팩토링 하기
class _MyMoreInfoButtonState extends State<MyMoreInfoButton> {
  void skipAdditionalInfo() {
    UserRequest().userAdditionalInfoUpdate();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          initPage: 0,
        ),
      ),
      (route) => false,
    );
  }

  void saveOnMypage() {
    UserRequest().userMoreInfoUpdate(context).then((isUpdated) {
      if (isUpdated) {
        context.read<MyPageProvider>().updateInfoInit();
        Navigator.of(context).pop();
      }
    });
  }

  void saveOnFirstLogin() {
    UserRequest().userAdditionalInfoUpdate();
    UserRequest().userMoreInfoUpdate(context).then((isUpdated) {
      if (isUpdated) {
        context.read<MyPageProvider>().updateInfoInit();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              initPage: 0,
            ),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      bool state = data.moreButton;
      MyPagePrevRouteEnum prevRoute = data.prevRoute;

      return SizedBox(
        width: double.infinity,
        height: 76.0.h,
        child: prevRoute == MyPagePrevRouteEnum.fromMyPage
            ? primaryButton(state: state, onPressed: saveOnMypage)
            : Row(
                children: [
                  Expanded(
                    child: defaultButton(onPressed: skipAdditionalInfo),
                  ),
                  Expanded(
                    child: primaryButton(state: state, onPressed: saveOnFirstLogin),
                  ),
                ],
              ),
      );
    });
  }

  Widget defaultButton({required void Function() onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: StaticColor.grey100F6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 56,
            child: Center(
              child: Text(
                '다음에 하기',
                style: TextStyle(
                  fontSize: 16.0.sp,
                  color: StaticColor.grey70055,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget saveButton(bool state, MyPagePrevRouteEnum prevRoute) {
    void onPressedSaveButton() async {
      if (!state) return;
      bool updateResult = await UserRequest().userMoreInfoUpdate(context);
      if (!updateResult) return;

      if (!context.mounted) return;
      context.read<MyPageProvider>().updateInfoInit();
      if (prevRoute == MyPagePrevRouteEnum.fromMyPage) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              initPage: 0,
            ),
          ),
          (route) => false,
        );
      }
    }

    return ElevatedButton(
      onPressed: onPressedSaveButton,
      style: ElevatedButton.styleFrom(
        backgroundColor: state == true ? StaticColor.mainSoft : StaticColor.grey400BB,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 56,
            child: Center(
              child: Text(
                '저장하기',
                style: TextStyle(
                  fontSize: 16.0.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget primaryButton({bool? state, void Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: state == true ? StaticColor.mainSoft : StaticColor.grey400BB,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 56,
            child: Center(
              child: Text(
                '저장하기',
                style: TextStyle(
                  fontSize: 16.0.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MBTIview extends StatefulWidget {
  final String? mbti;
  const MBTIview({super.key, this.mbti});

  @override
  State<MBTIview> createState() => _MBTIviewState();
}

class _MBTIviewState extends State<MBTIview> {
  int mbtiOrder = -1;
  List<Widget> mbtiWidgets = [];

  @override
  void initState() {
    String temp = widget.mbti ?? '';
    if (temp.isEmpty) {
    } else {
      for (int i = 0; i < Constants.mbtiTypes.length; i++) {
        if (Constants.mbtiTypes.elementAt(i).contains(temp.toUpperCase())) {
          mbtiOrder = i;
        }
      }
      context.read<MyPageProvider>().mbtiInit(mbtiOrder);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      mbtiWidgets.clear();
      for (int i = 0; i < Constants.mbtiTypes.length; i++) {
        mbtiWidgets.add(mbtiSelector(data.mbti, Constants.mbtiTypes.elementAt(i), i));
      }

      // ScrollConfiguration(
      //   behavior: const ScrollBehavior().copyWith(overscroll: false),
      //   child: const SingleChildScrollView(child: Text('안녕하세요')

      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h, bottom: 16.0.h),
                  child: Center(
                      child: Image.asset('assets/feed/comment_header_bar.png',
                          width: 75.0.w, height: 4.0.h, color: StaticColor.dividerColor)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0.h),
                  child: Center(
                      child: Text('MBTI',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: StaticColor.black90015,
                              fontWeight: FontWeight.w500))),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0.h),
                      child: Column(
                        children: mbtiWidgets,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 70.0.h)
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 70.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MyPageProvider>().saveMbtiChange();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: StaticColor.categorySelectedColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                  child: const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                        height: 56,
                        child: Center(
                            child: Text('저장',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)))),
                  ]),
                ),
              ),
            ),
          ],
        ),
      );
      // return Container(
      //   width: double.infinity,
      //   decoration: const BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      //   ),
      //   child: Stack(
      //     children: [
      //       Column(
      //         children: [
      //           Padding(
      //             padding: EdgeInsets.only(top: 8.0.h, bottom: 16.0.h),
      //             child: Center(
      //                 child: Image.asset('assets/feed/comment_header_bar.png',
      //                     width: 75.0.w, height: 4.0.h, color: StaticColor.dividerColor)),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(bottom: 24.0.h),
      //             child: Center(
      //                 child: Text('MBTI',
      //                     style: TextStyle(
      //                         fontSize: 16.sp,
      //                         color: StaticColor.black90015,
      //                         fontWeight: FontWeight.w500))),
      //           ),
      //           Expanded(
      //             child: Column(
      //               children: mbtiWidgets,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: SizedBox(
      //           width: double.infinity,
      //           height: 70.h,
      //           child: ElevatedButton(
      //             onPressed: () {
      //               // context.read<CreateEventProvider>().sumCostChange(getSelectCost(index), index);
      //               context.read<MyPageProvider>().saveMbtiChange();
      //               Navigator.of(context).pop();
      //             },
      //             style: ElevatedButton.styleFrom(
      //                 backgroundColor: StaticColor.categorySelectedColor,
      //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
      //             child: const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      //               SizedBox(
      //                   height: 56,
      //                   child: Center(
      //                       child: Text('저장',
      //                           style: TextStyle(
      //                               fontSize: 16,
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.w700)))),
      //             ]),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    });
  }

  Widget mbtiSelector(int selectIndex, String mbtiString, int mbtiIndex) {
    return GestureDetector(
      onTap: () {
        context.read<MyPageProvider>().mbtiChange(mbtiIndex);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0.h),
        margin: EdgeInsets.symmetric(horizontal: 20.0.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selectIndex == mbtiIndex ? StaticColor.grey100F6 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mbtiString,
                  style: TextStyle(
                      fontSize: 16.0.sp,
                      color:
                          selectIndex == mbtiIndex ? StaticColor.mainSoft : StaticColor.grey70055,
                      fontWeight: FontWeight.w500)),
              selectIndex == mbtiIndex
                  ? Image.asset('assets/create_event/check.png', width: 24, height: 24)
                  : const SizedBox.shrink(),
              // const SizedBox(width: 24.0, height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

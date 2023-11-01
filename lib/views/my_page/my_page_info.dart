import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/screens/my_page/my_info_update_screen.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class MyPageInfo extends StatefulWidget {
  const MyPageInfo({super.key});

  @override
  State<MyPageInfo> createState() => _MyPageInfoState();
}

class _MyPageInfoState extends State<MyPageInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: StaticColor.grey100F6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const MyPageProfile(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
            width: double.infinity,
            height: 1.0.h,
            decoration: BoxDecoration(
              color: StaticColor.grey300E0,
            ),
          ),
          const MyPageIntroduce(),
        ],
      ),
    );
  }
}

class MyPageProfile extends StatefulWidget {
  const MyPageProfile({super.key});

  @override
  State<MyPageProfile> createState() => _MyPageProfileState();
}

class _MyPageProfileState extends State<MyPageProfile> {

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    context.read<MyPageProvider>().myPageNameInit(PresentUserInfo.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(
      builder: (context, data, child) {
        
        String initName = data.myPageName;
        XFile? selectImage = data.selectImage;

        return FutureBuilder(
          future: UserRequest().userInfoRequest(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {

              if(snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              } else if(snapshot.connectionState == ConnectionState.done) {

                UserModel userModel = snapshot.data ?? UserModel();

                return Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 12.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children: [
                            UserProfileImage(size: 48.0, profileImageUrl: userModel.profileImageString),
                            SizedBox(width: 10.0.w),
                            Text(userModel.username == null ? 'User${PresentUserInfo.id}' : initName, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                          ]
                      ),
                      Material(
                          color: Colors.transparent,
                          child: SizedBox(
                            height: 40.0,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25.0),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => MyInfoUpdate(page: 0)));
                              },
                              child: Center(
                                child: Row(
                                  children: [
                                    Text('편집', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400)),
                                    SizedBox(width: 4.0.w),
                                    Image.asset('assets/my_page/caret_right.png', width: 16.0, height: 16.0),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                );

              } else {
                return const SizedBox.shrink();
              }

            } else if(snapshot.hasError) {
              return const SizedBox.shrink();
            } else {
              return const SizedBox.shrink();
            }
          }
        );
      }
    );
  }
}

class MyPageIntroduce extends StatefulWidget {
  const MyPageIntroduce({super.key});

  @override
  State<MyPageIntroduce> createState() => _MyPageIntroduceState();
}

class _MyPageIntroduceState extends State<MyPageIntroduce> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 12.0.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('소개', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
          SizedBox(height: 16.0.h),
          Text('등록된 소개 글이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
          SizedBox(height: 16.0.h),
        ],
      ),
    );
  }
}

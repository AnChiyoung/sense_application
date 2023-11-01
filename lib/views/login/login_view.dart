import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/signin_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/token_model.dart';
import 'package:sense_flutter_application/public_widget/password_search_guide_dialog.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/screens/sign_in/policy_screen.dart';
import 'package:sense_flutter_application/views/login/login_provider.dart';
import 'package:toast/toast.dart';

class LogoView extends StatefulWidget {
  const LogoView({Key? key}) : super(key: key);

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            count++;
            if (count > 20) {
              count = 0;
              ApiUrl.setEnvironmentState().then((value) => 
                Toast.show('$value 환경설정 변경')
              );
            }
          },
          child: Image.asset('assets/login/logo_title.png', width: 200, height: 80)),
      ),
    );
  }
}

class LoginFormView extends StatefulWidget {
  const LoginFormView({Key? key}) : super(key: key);

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {

  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  UserInfoModel userInfoModel = UserInfoModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _isAutoLogin();
    });
  }

  _isAutoLogin() async {
    String? a = await LoginRequest.storage.read(key: 'id');
    if(a != null) {
      PresentUserInfo.id = int.parse(a);
      PresentUserInfo.username = (await LoginRequest.storage.read(key: 'username'))!;
      PresentUserInfo.profileImage = (await LoginRequest.storage.read(key: 'profileImage'))!;
      PresentUserInfo.loginToken = (await LoginRequest.storage.read(key: 'loginToken'))!;
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 0)));
    } else {
      if (kDebugMode) {
        print('auto login disabled. when login, set plz.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    String autoLoginImage = 'check_empty.png';
    final autoLoginState = context.watch<LoginProvider>().autoLoginState;
    autoLoginState == true ? autoLoginImage = 'check_done.png' : autoLoginImage = 'check_empty.png';

    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 56.0.h),
        child: Column(
          children: [
            /// email input field
            Container(
              height: 48.0.h,
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: emailFieldController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: '이메일 주소',
                  hintStyle: TextStyle(fontSize: 14.0.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 8.0.h),
            /// password input field
            Container(
              height: 48.0.h,
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: passwordFieldController,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(fontSize: 14.0.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 16.0.h),
            Material(
              color: StaticColor.mainSoft,
              borderRadius: BorderRadius.circular(4.0),
              child: InkWell(
                onTap: () async {

                  /// when state of keyboard focus,
                  /// according to next process.
                  FocusManager.instance.primaryFocus!.unfocus();

                  UserInfoModel? userInfoModel;
                  userInfoModel = await LoginRequest().emailLoginReqeust(emailFieldController.text.toString(), passwordFieldController.text.toString());
                  if(userInfoModel == null) {

                    /// snackbar version
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(milliseconds: 2000),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - safeAreaTopPadding - safeAreaBottomPadding - 150,
                        ),
                        content: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: StaticColor.textErrorColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/signin/snackbar_error_icon.png', width: 24.0.w, height: 24.0.h),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text('이메일 또는 비밀번호가 일치하지 않아요.',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.0.sp, color: StaticColor.textErrorColor, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    autoLoginState == true ? {
                      await LoginRequest.storage.write(key: 'id', value: userInfoModel.id.toString()),
                      await LoginRequest.storage.write(key: 'username', value: userInfoModel.username ?? '${userInfoModel.id}user'),
                      await LoginRequest.storage.write(key: 'profileImage', value: userInfoModel.profileImageUrl.toString()),
                      await LoginRequest.storage.write(key: 'loginToken', value: userInfoModel.joinToken!.accessToken.toString()),
                    } : {};
                    PresentUserInfo.id = userInfoModel.id!;
                    PresentUserInfo.username = userInfoModel.username ?? '${userInfoModel.id}user';
                    PresentUserInfo.profileImage = userInfoModel.profileImageUrl!;
                    PresentUserInfo.loginToken = userInfoModel.joinToken!.accessToken!;
                    /// text form field clear
                    emailFieldController.clear();
                    passwordFieldController.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 0)));
                  }
                },
                borderRadius: BorderRadius.circular(4.0),
                child: SizedBox(
                  height: 50.0.h,
                  child: Center(child: Text('로그인', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, letterSpacing: -0.22, fontWeight: FontWeight.w600))),
                ),
              ),
            ),
            /// 자동 로그인 및 비밀번호 찾기 터치 범위 개선을 위해 margin대신 content padding 사용
            // const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      context.read<LoginProvider>().autoLoginBoxState(!autoLoginState);
                    },
                    child: SizedBox(
                      height: 35.0.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/login/$autoLoginImage', width: 20, height: 20),
                          const SizedBox(width: 8),
                          Text('자동로그인', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.loginTextColor03, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => PasswordSearchScreen()));
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const PasswordSearchGuideDialog();
                        }
                      );
                    },
                    child: SizedBox(
                      height: 35,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('비밀번호 찾기', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500))),
                    )
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KakaoLoginButton extends StatefulWidget {
  const KakaoLoginButton({Key? key}) : super(key: key);

  @override
  State<KakaoLoginButton> createState() => _KakaoLoginButtonState();
}

class _KakaoLoginButtonState extends State<KakaoLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w,top: 40.0.h, bottom: 72.0.h),
        child: Material(
          color: StaticColor.loginKakaoColor,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () async {
              SigninModel.signinType = 0;
              kakaoLoginTry(context);
            },
            borderRadius: BorderRadius.circular(4.0), // inkwell effect's borderradius
            child: SizedBox(
              height: 50.0.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/login/kakao_simple_icon.png', width: 24.0.w, height: 24.0.h),
                  SizedBox(width: 4.0.w),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.0.h),
                    child: Text(
                      '카카오로 로그인',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 14.0.sp,
                        // textBaseline: TextBaseline.alphabetic,
                        color: StaticColor.loginTextColor02,
                        fontWeight: FontWeight.w600,
                        height: 1.5
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void kakaoLoginTry(BuildContext context) async {

    /// 카카오톡 설치 유무 확인
    bool isInstalled = await isKakaoTalkInstalled();
    KakaoUserModel? userModel = KakaoUserModel();
    AccessTokenResponseModel tokenModel = AccessTokenResponseModel();
    UserInfoModel? userInfoModel = UserInfoModel();

    /// auth code get
    OAuthToken? token;

    /// get key hash 20230812 bug fix
    print('release key : ${await KakaoSdk.origin}');

    if(isInstalled == true) {
      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        // token = await UserApi.instance.loginWithKakaoAccount();
        token == null ? print('kakao token is empty') : {
          userModel = await KakaoUserInfoModel().getUserInfo(token),
          tokenModel = await SigninCheckModel().tokenLoginRequest(token),
          if(tokenModel.isSignUp == false) {
            KakaoUserInfoModel.userAccessToken = tokenModel.joinToken!.accessToken,
            Navigator.push(context, MaterialPageRoute(builder: (_) => PolicyScreen(kakaoUserModel: userModel))),
          } else {
            if(tokenModel.isSignUp == true) {
              SenseLogger().debug('login success'),
              PresentUserInfo.id = tokenModel.id!,
              PresentUserInfo.username = tokenModel.username!,
              PresentUserInfo.profileImage = tokenModel.profileImageUrl!,
              PresentUserInfo.loginToken = tokenModel.joinToken!.accessToken!,

              // move to home
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 0)), (route) => false),
            }
          }
        };
      } catch (error) {
        rethrow;
      }
    } else if(isInstalled == false) {
      token = await UserApi.instance.loginWithKakaoAccount();
      token == null ? print('kakao token is empty') : {
        userModel = await KakaoUserInfoModel().getUserInfo(token),
        tokenModel = await SigninCheckModel().tokenLoginRequest(token),
        if(tokenModel.isSignUp == false) {
          KakaoUserInfoModel.userAccessToken = tokenModel.joinToken!.accessToken,
          Navigator.push(context, MaterialPageRoute(builder: (_) => PolicyScreen(kakaoUserModel: userModel))),
        } else if(tokenModel.isSignUp == true) {
            SenseLogger().debug('login success'),
            PresentUserInfo.id = tokenModel.id!,
            PresentUserInfo.username = tokenModel.username ?? '${userInfoModel.id}user',
            PresentUserInfo.profileImage = tokenModel.profileImageUrl!,
            PresentUserInfo.loginToken = tokenModel.joinToken!.accessToken!,
            Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 0))),
          }
      };
    }
  }
}

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            /// text
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 14.0.sp, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500),
                        children: [
                          const TextSpan(text: '아직 '),
                          TextSpan(text: 'SENSE', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500)),
                          const TextSpan(text: ' 회원이 아니신가요?')
                        ]
                      )
                    )

                    // Text('아직 ', style: TextStyle(fontSize: 16, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500)),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text('SENSE', style: TextStyle(fontSize: 16, color: StaticColor.mainSoft, fontWeight: FontWeight.w500))),
                    // Text(' 회원이 아니신가요?', style: TextStyle(fontSize: 16, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            /// sign in button
            Padding(
              padding: const EdgeInsets.only(bottom: 51),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    SigninModel.signinType = 1;
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PolicyScreen()));
                  },
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: StaticColor.mainSoft, width: 1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('회원가입', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500)),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

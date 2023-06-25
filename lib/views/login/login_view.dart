import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/signin_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/token_model.dart';
import 'package:sense_flutter_application/public_widget/password_search_guide_dialog.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/screens/login/password_search_screen.dart';
import 'package:sense_flutter_application/screens/sign_in/policy_screen.dart';
import 'package:sense_flutter_application/views/login/login_provider.dart';

class LogoView extends StatefulWidget {
  const LogoView({Key? key}) : super(key: key);

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset('assets/login/logo_title.png', width: 200, height: 80),
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
    print('what is a? : $a');
    if(a != null) {
      PresentUserInfo.id = int.parse(a!);
      PresentUserInfo.username = (await LoginRequest.storage.read(key: 'username'))!;
      PresentUserInfo.profileImage = (await LoginRequest.storage.read(key: 'profileImage'))!;
      PresentUserInfo.loginToken = (await LoginRequest.storage.read(key: 'loginToken'))!;
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      print('로그인이 필요합니다');
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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 56),
        child: Column(
          children: [
            /// email input field
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: emailFieldController,
                decoration: InputDecoration(
                  hintText: '이메일 주소',
                  hintStyle: TextStyle(fontSize: 16, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 8),
            /// password input field
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: passwordFieldController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(fontSize: 16, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            Material(
              color: StaticColor.mainSoft,
              borderRadius: BorderRadius.circular(4.0),
              child: InkWell(
                onTap: () async {
                  UserInfoModel? userInfoModel;
                  userInfoModel = await LoginRequest().emailLoginReqeust(emailFieldController.text.toString(), passwordFieldController.text.toString());
                  if(userInfoModel == null) {
                    /// dialog version
                    // showDialog(
                    //     context: context,
                    //     //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) {
                    //       return const LoginDialog();
                    //     }
                    // );

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
                              Image.asset('assets/signin/snackbar_error_icon.png', width: 24, height: 24),
                              const SizedBox(width: 8),
                              Text('이메일 또는 비밀번호가 일치하지 않아요.',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: StaticColor.textErrorColor, fontWeight: FontWeight.w500),
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
                      // await LoginRequest.storage.write(key: 'loginToken', value: userInfoModel.loginToken!.accessToken.toString()),
                    } : {};
                    PresentUserInfo.id = userInfoModel.id!;
                    PresentUserInfo.username = userInfoModel.username ?? '${userInfoModel.id}user';
                    PresentUserInfo.profileImage = userInfoModel.profileImageUrl!;
                    PresentUserInfo.loginToken = userInfoModel.joinToken!.accessToken!;
                    /// text form field clear
                    emailFieldController.clear();
                    passwordFieldController.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                  }
                },
                borderRadius: BorderRadius.circular(4.0), // inkwell effect's borderradius
                child: const SizedBox(
                  height: 50,
                  child: Center(child: Text('로그인', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600))),
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
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/login/$autoLoginImage', width: 20, height: 20),
                          const SizedBox(width: 8),
                          Text('자동로그인', style: TextStyle(fontSize: 14, color: StaticColor.loginTextColor03, fontWeight: FontWeight.w500)),
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
                        child: Text('비밀번호 찾기', style: TextStyle(fontSize: 14, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500))),
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
        padding: const EdgeInsets.only(left: 20, right: 20,top: 40, bottom: 72),
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
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/login/kakao_simple_icon.png', width: 24, height: 24),
                  const SizedBox(width: 4),
                  Text('카카오로 로그인', style: TextStyle(fontSize: 16, color: StaticColor.loginTextColor02, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void kakaoLoginTry(BuildContext context) async {
    /// logger setting
    var logger = Logger(
      printer: PrettyPrinter(
        lineLength: 120,
        colors: true,
        printTime: true,
      ),
    );

    /// 카카오톡 설치 유무 확인
    bool isInstalled = await isKakaoTalkInstalled();
    KakaoUserModel? userModel = KakaoUserModel();
    AccessTokenResponseModel tokenModel = AccessTokenResponseModel();
    UserInfoModel? userInfoModel = UserInfoModel();

    /// auth code get
    OAuthToken? token;

    if(isInstalled == true) {
      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        token == null ? print('kakao token is empty') : {
          userModel = await KakaoUserInfoModel().getUserInfo(token),
          tokenModel = await SigninCheckModel().tokenLoginRequest(token),
          if(tokenModel.isSignUp == false) {
            KakaoUserInfoModel.userAccessToken = tokenModel.joinToken!.accessToken,
            Navigator.push(context, MaterialPageRoute(builder: (_) => PolicyScreen(kakaoUserModel: userModel))),
          } else {
            if(tokenModel.isSignUp == true) {
              logger.d('login success'),
              PresentUserInfo.id = tokenModel.id!,
              PresentUserInfo.username = tokenModel.username!,
              PresentUserInfo.profileImage = tokenModel.profileImageUrl!,
              PresentUserInfo.loginToken = tokenModel.joinToken!.accessToken!,
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen())),
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
            logger.d('login success'),
            PresentUserInfo.id = tokenModel.id!,
            PresentUserInfo.username = tokenModel.username ?? '${userInfoModel.id}user',
            PresentUserInfo.profileImage = tokenModel.profileImageUrl!,
            PresentUserInfo.loginToken = tokenModel.joinToken!.accessToken!,
            Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen())),
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
                    Text('아직 ', style: TextStyle(fontSize: 16, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500)),
                    Align(
                      alignment: Alignment.center,
                      child: Text('SENSE', style: TextStyle(fontSize: 16, color: StaticColor.mainSoft, fontWeight: FontWeight.w500))),
                    Text(' 회원이 아니신가요?', style: TextStyle(fontSize: 16, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500)),
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
                      child: Text('회원가입', style: TextStyle(fontSize: 16, color: StaticColor.mainSoft, fontWeight: FontWeight.w500)),
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

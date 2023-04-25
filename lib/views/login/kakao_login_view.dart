// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/models/login/login_home_model.dart';
// import 'package:sense_flutter_application/models/login/login_provider.dart';
//
// import '../../screens/sign_up/sign_up_home_screen.dart';
//
// class kakaoLoginButtonView extends StatefulWidget {
//   const kakaoLoginButtonView({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _KakaoLoginPageState createState() => _KakaoLoginPageState();
// }
//
// class _KakaoLoginPageState extends State<kakaoLoginButtonView> {
//   @override
//   Widget build(BuildContext context) {
//     print('카카오 로그인 페이지 진입!');
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: CupertinoButton(
//           onPressed: () async {
//             try {
//               OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
//               print('카카오톡으로 로그인 성공! : ${token}');
//               kakaoLoginSequence(param: token);
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => LoginPageScreen()));
//               context.read<StepProvider>().resetStep();
//             } catch (error) {
//               print('카카오톡으로 로그인 실패! : $error');
//             }
//           },
//           color: Colors.yellow,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     right: 4), //apply padding to some sides only
//                 child: Image.asset('assets/login/simpleicon_kakao.png',
//                     width: 24, height: 24),
//               ),
//               const Text(
//                 '카카오 로그인',
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/forgot_password_screen/index.dart';
import 'package:sense_flutter_application/screens/home_screen/index.dart';
import 'package:sense_flutter_application/screens/login_screen.dart';
import 'package:sense_flutter_application/screens/my_page.dart';
import 'package:sense_flutter_application/screens/signup_screen/index.dart';
import 'package:sense_flutter_application/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/service/auth_service.dart';

class RouterView extends StatelessWidget {
  const RouterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return FutureBuilder(
          future: AuthService.getRefreshToken(),
          builder: (context, snapshot) {
            bool isLogin = snapshot.data?.isNotEmpty ?? false;

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: GoRouter(routes: [
                GoRoute(
                    path: '/',
                    redirect: (context, state) {
                      return Future.value('/home');
                    }),
                GoRoute(
                  path: '/login',
                  redirect: (context, state) {
                    print('states $isLogin');
                    if (isLogin) {
                      return '/home';
                    } else {
                      return null;
                    }
                  },
                  builder: (context, state) => const LoginScreen(),
                ),
                GoRoute(
                    name: 'signup',
                    path: '/signup',
                    redirect: (context, state) {
                      return null;
                    },
                    routes: [
                      GoRoute(
                        path: 'step1',
                        builder: (context, state) => const Step1(),
                      ),
                      GoRoute(
                        path: 'step2',
                        builder: (context, state) => const Step2(),
                      ),
                    ]),
                GoRoute(
                    name: 'forgot-password',
                    path: '/forgot-password',
                    redirect: (context, state) {
                      return null;
                    },
                    routes: [
                      GoRoute(
                        path: 'step1',
                        builder: (context, state) => const PasswordChangeStep1(),
                      ),
                      GoRoute(
                        path: 'step2',
                        builder: (context, state) => const PasswordChangeStep2(),
                      ),
                    ]),
                GoRoute(
                  path: '/home',
                  builder: (context, state) => const HomeScreen(),
                ),
                GoRoute(
                  path: '/list',
                  builder: (context, state) => const ListScreen(),
                ),
                GoRoute(
                  path: '/my-page',
                  builder: (context, state) => const MyPage(),
                ),
              ]),
            );
          },
        );
      },
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/forgot_password_screen/index.dart';
import 'package:sense_flutter_application/screens/home_screen/index.dart';
import 'package:sense_flutter_application/screens/login_screen.dart';
import 'package:sense_flutter_application/screens/my_page.dart';
import 'package:sense_flutter_application/screens/schedule_screen/index.dart';
import 'package:sense_flutter_application/screens/signup_screen/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/screens/single_post_screen/index.dart';
import 'package:sense_flutter_application/screens/splash_screen.dart';
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

            final router = GoRouter(routes: [
              GoRoute(
                  path: '/',
                  builder: (context, state) {
                    return const SplashScreen();
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
                  path: '/post/:id',
                  builder: (context, state) {
                    return SinglePostScreen(id: int.parse(state.pathParameters['id'] ?? ''));
                  }),
              GoRoute(
                path: '/schedule',
                builder: (context, state) => const ScheduleScreen(),
              ),
              GoRoute(
                path: '/my-page',
                builder: (context, state) => const MyPage(),
              ),
            ]);

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              // routeInformationParser: router.routeInRformationParser,
              // routerDelegate: router.routerDelegate,
              title: 'GoRouter Example',
            );
          },
        );
      },
    );
  }
}

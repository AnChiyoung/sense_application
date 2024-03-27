import 'package:sense_flutter_application/screens/forgot_password_screen/index.dart';
import 'package:sense_flutter_application/screens/home_screen/index.dart';
import 'package:sense_flutter_application/screens/login_screen.dart';
import 'package:sense_flutter_application/screens/signup_screen/index.dart';
import 'package:sense_flutter_application/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class RouterView extends StatelessWidget {

  RouterView({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', redirect: (context, state) {
        return Future.value('/home');
      }),
      GoRoute(path: '/login', 
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
        ]
      ),
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
        ]
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/list',
        builder: (context, state) => const ListScreen(),
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
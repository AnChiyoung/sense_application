import 'package:sense_flutter_application/screens/home_screen.dart';
import 'package:sense_flutter_application/screens/login_screen.dart';
import 'package:sense_flutter_application/screens/signup_screen/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterView extends StatelessWidget {

  RouterView({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', redirect: (context, state) {
        return Future.value('/auth');
      }),
      GoRoute(path: '/auth', 
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            name: 'signup',
            path: 'signup',
            redirect: (context, state) {
              print(state.topRoute?.name);
              // return ''
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
          )
        ]
      ),
      GoRoute(
        name: 'screen1',
        path: '/home',
        builder: (context, state) => const HomeScreen(),
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
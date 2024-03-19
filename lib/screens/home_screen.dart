import 'package:sense_flutter_application/screens/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../utils/global_extentions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      theme: ThemeData(
        // brightness: Brightness.light,
        // primaryColor: primaryColor[50],
        colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 34, 115, 236),
          secondary: Colors.blue.shade500,
          onPrimary: Colors.blue.shade900,
          // onSecondary: Colors.blue.shade900,
        ),
      ),
      home: const MainLayout(
      title: '',
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 35, right: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
          ],
        )
      ),
    ),
    );
  }
}
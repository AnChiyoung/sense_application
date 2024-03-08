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
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
      home: MainLayout(
      title: '',
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              // height: 200,
              child: Align(
                alignment:Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text("Today's Blog", textAlign: TextAlign.end, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                )
              )
            ),
            Card(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: NetworkImage('https://picsum.photos/id/27/3264/1836'), fit: BoxFit.cover)
                ),
                height: 250,
              ),
            ),
            SizedBox(
              // height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Latest', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: Text('See All', style: TextStyle(color: Colors.grey.shade400),))
                ],
              )
            )
          ],
        )
      ),
    ),
    );
  }
}
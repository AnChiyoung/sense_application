
import 'package:sense_flutter_application/providers/global_provider.dart';
import 'package:sense_flutter_application/screens/widgets/app_bar/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainLayout extends ConsumerWidget {

  final String ?title;
  final Widget body;
  final Widget ?floating;
  
  const MainLayout({super.key, required this.title, required this.body, this.floating});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: no_leading_underscores_for_local_identifiers
    final int _screenIndex = ref.watch(screenIndexProvider);

    return Scaffold(
      appBar: const TopNavBar(),
      body: body,
      bottomNavigationBar: 
        BottomNavigationBar(
          onTap: (index) {
            // ref.read(screenIndexProvider.notifier).state = index;
            // int r = index + 1;
            // context.goNamed('screen$r');
          },
          elevation: 20,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          currentIndex: _screenIndex,
          items: 
            const [
              BottomNavigationBarItem(
                icon:  Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: '스토리'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: '일정'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store_mall_directory_outlined),
                label: '일정'
              )
            ],
        ),
      floatingActionButton: floating,
    );
  }
}

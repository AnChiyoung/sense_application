
import 'package:flutter_svg/flutter_svg.dart';
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
          onTap: (index) async {
            ref.read(screenIndexProvider.notifier).state = index;
            await Future.delayed(const Duration(milliseconds: 200), () {
              switch(index) {
                case 0:
                  GoRouter.of(context).go('/home');
                  break;
                case 1:
                  GoRouter.of(context).go('/login');
                  break;
                case 2:
                  GoRouter.of(context).go('/schedule');
                  break;
                case 3:
                  GoRouter.of(context).go('/store');
                  break;
              }
            });
          },
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          currentIndex: _screenIndex,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          items: 
            [
              BottomNavigationBarItem(
                icon:  SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/home.svg', width: 24, height: 24),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon:  SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/list.svg', width: 24, height: 24),
                label: '스토리'
              ),
              BottomNavigationBarItem(
                icon:  SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/calendar_blank.svg', width: 24, height: 24),
                label: '일정'
              ),
              BottomNavigationBarItem(
                icon:  SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/storefront.svg', width: 24, height: 24),
                label: '일정'
              )
            ],
        ),
      floatingActionButton: floating,
    );
  }
}

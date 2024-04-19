import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/providers/global_provider.dart';
import 'package:sense_flutter_application/screens/widgets/app_bar/schedule_top_bar.dart';
import 'package:sense_flutter_application/screens/widgets/app_bar/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class MainLayout extends ConsumerWidget {
  final String? title;
  final Widget body;
  final Widget? floating;
  final String pathName;

  const MainLayout(
      {super.key, required this.pathName, required this.title, required this.body, this.floating});

  PreferredSizeWidget getTopBar() {
    switch (pathName) {
      case 'home':
      case 'store':
      case 'my-page':
        return const TopNavBar();
      case 'schedule':
        return const ScheduleTopBar();
      default:
        return const TopNavBar();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: no_leading_underscores_for_local_identifiers
    final int _screenIndex = ref.watch(screenIndexProvider);

    return Scaffold(
      appBar: getTopBar(),
      body: body,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.10),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 10,
          onTap: (index) async {
            ref.read(screenIndexProvider.notifier).state = index;
            await Future.delayed(const Duration(milliseconds: 200), () {
              switch (index) {
                case 0:
                  GoRouter.of(context).go('/home');
                  break;
                case 1:
                  // GoRouter.of(context).go('/login');
                  break;
                case 2:
                  GoRouter.of(context).go('/schedule');
                  break;
                case 3:
                  GoRouter.of(context).go('/store');
                  break;

                case 4:
                  GoRouter.of(context).go('/my-page');
                  break;
              }
            });
          },
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          currentIndex: _screenIndex,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          // unselectedIconTheme: const IconThemeData(color: Color.fromRGBO(119, 119, 119, 1)),
          // selectedIconTheme: IconThemeData(color: primaryColor[50]),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/home.svg',
                  width: 24,
                  height: 24,
                  color: _screenIndex == 0
                      ? primaryColor[50]
                      : const Color.fromRGBO(119, 119, 119, 1)),
              label: '홈',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/list.svg',
                    width: 24,
                    height: 24,
                    color: _screenIndex == 1
                        ? primaryColor[50]
                        : const Color.fromRGBO(119, 119, 119, 1)),
                label: '스토리'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/calendar_blank.svg',
                    width: 24,
                    height: 24,
                    color: _screenIndex == 2
                        ? primaryColor[50]
                        : const Color.fromRGBO(119, 119, 119, 1)),
                label: '일정'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/storefront.svg',
                    width: 24,
                    height: 24,
                    color: _screenIndex == 3
                        ? primaryColor[50]
                        : const Color.fromRGBO(119, 119, 119, 1)),
                label: '쇼핑'),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('lib/assets/images/icons/svg/bottom_bar/user.svg',
                  width: 24,
                  height: 24,
                  color: _screenIndex == 4
                      ? primaryColor[50]
                      : const Color.fromRGBO(119, 119, 119, 1)),
              label: 'MY',
            )
          ],
        ),
      ),
      floatingActionButton: floating,
    );
  }
}

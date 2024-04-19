import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/service/auth_service.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class ScheduleTopBar extends StatefulWidget implements PreferredSizeWidget {
  const ScheduleTopBar({super.key});

  @override
  State<ScheduleTopBar> createState() => _ScheduleTopBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}

class _ScheduleTopBarState extends State<ScheduleTopBar> {
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    // authService.removeTokens();
    AuthService.getAccessToken().then((value) {
      setState(() {
        isAuthenticated = value != null;
      });
    });

    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Color(0xFFEEEEEE)))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20, bottom: 10),
        child: SafeArea(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              backgroundColor: Colors.transparent,
              textColor: const Color(0xFF151515),
              suffixIcon: SvgPicture.asset('lib/assets/images/icons/svg/caret_down.svg'),
              onPressed: () {},
              labelText: DateFormat('yyyy년 MM월').format(DateTime.now()).toString(),
              fontSize: 18,
            ),
            isAuthenticated
                ? Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'lib/assets/images/icons/svg/top_bar/search.svg',
                            color: const Color(0XFF333333),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'lib/assets/images/icons/svg/top_bar/refresh.svg',
                            color: const Color(0XFF333333),
                          )),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      if (context.mounted) {
                        GoRouter.of(context).go('/login');
                      }
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(color: primaryColor[50]),
                    )),
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/scroll/year_month_picker.dart';
import 'package:sense_flutter_application/service/auth_service.dart';
import 'package:sense_flutter_application/store/providers/Schedule/event_collection.dart';
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
  DateTime? selectedDate;
  String year = '';
  String month = '';

  @override
  Widget build(BuildContext context) {
    // authService.removeTokens();
    AuthService.getAccessToken().then((value) {
      setState(() {
        isAuthenticated = value != null;
      });
    });

    return Consumer(
        builder: (context, ref, child) => Container(
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
                      onPressed: () {
                        showModalBottomSheet(
                          // onDispose: () {},
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 516 / 375 * MediaQuery.of(context).size.width,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: YearMonthPicker(
                                    currentValue: selectedDate ?? DateTime.now(),
                                    onChange: (Map<String, String> value) {
                                      setState(() {
                                        year = value['year']!;
                                        month = value['month']!;
                                      });
                                    }),
                              ),
                            );
                          },
                        ).then((value) {
                          setState(() {
                            selectedDate = DateTime(int.parse(year), int.parse(month));
                          });
                          ref.read(calendarSelectorProvider.notifier).state =
                              DateTime(int.parse(year), int.parse(month));
                        });
                      },
                      labelText: DateFormat('yyyy년 MM월')
                          .format(ref.watch(calendarSelectorProvider))
                          .toString(),
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
            ));
  }
}

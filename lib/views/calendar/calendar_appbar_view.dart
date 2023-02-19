import 'package:flutter/material.dart';

class CalendarAppBar extends StatefulWidget {
  const CalendarAppBar({Key? key}) : super(key: key);

  @override
  State<CalendarAppBar> createState() => _CalendarAppBarState();
}

class _CalendarAppBarState extends State<CalendarAppBar> {
  List<String> monthList = [];
  String selectMonth = '';

  void monthListCreate() {
    for (int i = 1; i < 13; i++) {
      monthList.add('$i월');
    }
    selectMonth = monthList.first;
  }

  @override
  void initState() {
    monthListCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              DropdownButton(
                iconSize: 20,
                icon: const Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                underline: Container(),
                value: selectMonth,
                items: monthList
                    .map((String e) => DropdownMenuItem<String>(value: e, child: Text(e, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600))))
                    .toList(),
                onChanged: (changeValue) {
                  setState(() {
                    selectMonth = monthList.elementAt(monthList.indexOf(changeValue!));
                  });
                },
              ),
              Image.asset('assets/calendar/select_month_dropdown_button.png', width: 7.21, height: 4.6),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: '캘린더',
                  child: GestureDetector(
                    child: Container(
                      width: 24,
                      height: 24,
                      child: Image.asset('assets/calendar/action_blank.png', width: 24, height: 24),
                    ),
                    onTap: () {print('tap the blank calendar');}
                  ),
                ),
                SizedBox(width: 16),
                Tooltip(
                  message: '검색',
                  child: GestureDetector(
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/calendar/action_search.png', width: 24, height: 24),
                      ),
                      onTap: () {print('tap the search');}
                  ),
                ),
                SizedBox(width: 16),
                Tooltip(
                  message: '알람',
                  child: GestureDetector(
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/calendar/action_bell.png', width: 24, height: 24),
                      ),
                      onTap: () {print('tap the alarm');}
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
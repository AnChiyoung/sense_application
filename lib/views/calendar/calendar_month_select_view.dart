import 'package:flutter/material.dart';
import 'package:sense_flutter_application/internal_libraries/src/table_calendar.dart';

import '../../constants/public_color.dart';

class MonthSelectHeader extends StatefulWidget {
  const MonthSelectHeader({Key? key}) : super(key: key);

  @override
  State<MonthSelectHeader> createState() => _MonthSelectHeaderState();
}

class _MonthSelectHeaderState extends State<MonthSelectHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 63.63,
              child: GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                      'assets/calendar/left_button.png', width: 10.85,
                      height: 18.95),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('2023', style: TextStyle(fontSize: 34,
                color: StaticColor.selectScreenYear,
                fontWeight: FontWeight.w700)),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 63.63,
              child: GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                      'assets/calendar/right_button.png', width: 10.85,
                      height: 18.95),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MonthSelect extends StatefulWidget {
  const MonthSelect({Key? key}) : super(key: key);

  @override
  State<MonthSelect> createState() => _MonthSelectState();
}

class _MonthSelectState extends State<MonthSelect> {
  @override
  Widget build(BuildContext context) {
    return SemiMonthWidget();
  }
}

class SemiMonthWidget extends StatelessWidget {
  const SemiMonthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
    );
  }
}


import 'package:flutter/material.dart';

import '../../constants/public_color.dart';

class MonthSelectHeader extends StatefulWidget {
  const MonthSelectHeader({super.key});

  @override
  State<MonthSelectHeader> createState() => _MonthSelectHeaderState();
}

class _MonthSelectHeaderState extends State<MonthSelectHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
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
            child: SizedBox(
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
  const MonthSelect({super.key});

  @override
  State<MonthSelect> createState() => _MonthSelectState();
}

class _MonthSelectState extends State<MonthSelect> {
  @override
  Widget build(BuildContext context) {
    return const SemiMonthWidget();
  }
}

class SemiMonthWidget extends StatelessWidget {
  const SemiMonthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      height: 100,
    );
  }
}


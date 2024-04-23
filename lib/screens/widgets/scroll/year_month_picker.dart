import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class YearMonthPicker extends StatefulWidget {
  final Function(Map<String, String> value) onChange;
  final DateTime currentValue;
  const YearMonthPicker({super.key, required this.onChange, required this.currentValue});

  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  final FixedExtentScrollController yearController = FixedExtentScrollController();
  final FixedExtentScrollController monthController = FixedExtentScrollController();

  List<String> years = List.generate(30, (index) => (2020 + index).toString());
  List<String> months = List.generate(12, (index) => (index + 1).toString());
  int? selectedIndex;
  int? selectedIndex2;

  void setValue() {
    if (selectedIndex != null &&
            selectedIndex2 != null &&
            years[selectedIndex ?? 0] != widget.currentValue.year.toString() ||
        months[selectedIndex2 ?? 0] != widget.currentValue.month.toString()) {
      widget.onChange({
        'year': years[selectedIndex ?? 0],
        'month': months[selectedIndex2 ?? months.indexOf(widget.currentValue.month.toString())]
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        yearController.jumpToItem(years.indexOf(widget.currentValue.year.toString()));
      });
    }

    if (selectedIndex2 == null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        monthController.jumpToItem(months.indexOf(widget.currentValue.month.toString()));
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(2),
            ),
            alignment: Alignment.topCenter,
            width: 75,
            height: 4,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '날짜 설정',
            style: TextStyle(
              fontSize: 16 / 375 * MediaQuery.of(context).size.width,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF151515),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: WheelPicker(
                    controller: yearController,
                    items: years,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                      setValue();
                    },
                    selectedIndex: selectedIndex ?? 0,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: WheelPicker(
                    controller: monthController,
                    items: months,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex2 = index;
                      });
                      setValue();
                    },
                    selectedIndex: selectedIndex2 ?? 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    yearController.dispose();
    super.dispose();
  }
}

class WheelPicker extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<String> items;
  final Function(int) onSelectedItemChanged;
  final int selectedIndex;

  const WheelPicker({
    super.key,
    required this.controller,
    required this.items,
    required this.onSelectedItemChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      physics: const FixedExtentScrollPhysics(),
      controller: controller,
      itemExtent: 60,
      perspective: 0.001,
      diameterRatio: 10.0,
      onSelectedItemChanged: onSelectedItemChanged,
      children: items
          .map((e) => Center(
                child: items[selectedIndex] == e
                    ? Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color.fromRGBO(246, 246, 246, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              e,
                              style: TextStyle(
                                fontSize: 16 / 375 * MediaQuery.of(context).size.width,
                                fontWeight:
                                    items[selectedIndex] == e ? FontWeight.w700 : FontWeight.w400,
                                color: items[selectedIndex] == e
                                    ? primaryColor[50]
                                    : const Color(0XFF555555),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(
                              'lib/assets/images/icons/svg/check.svg',
                              width: 16,
                              height: 16,
                              color: primaryColor[50],
                            ),
                          ],
                        ),
                      )
                    : Text(
                        e,
                        style: TextStyle(
                          fontSize: 16 / 375 * MediaQuery.of(context).size.width,
                          fontWeight: items[selectedIndex] == e ? FontWeight.w700 : FontWeight.w400,
                          color: items[selectedIndex] == e
                              ? primaryColor[50]
                              : const Color(0XFF555555),
                        ),
                      ),
              ))
          .toList(),
    );
  }
}

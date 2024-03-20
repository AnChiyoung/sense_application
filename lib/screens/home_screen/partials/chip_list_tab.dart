import 'package:flutter/material.dart';

class ChipListTab extends StatefulWidget {
  final List<String> chipList;

  const ChipListTab({super.key, required this.chipList});
  
  @override
  State<ChipListTab> createState() => _ChipListTabState();

}

class _ChipListTabState extends State<ChipListTab> {

  String selectedChip = '';
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.chipList.map((chipText) {
          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: ActionChip(
              onPressed: () {
                setState(() {
                  selectedChip = chipText;
                });
              },
              label: 
                Text(
                  chipText,
                  style: 
                  TextStyle(
                    height: 0,
                    fontSize: 14,
                    fontWeight:
                      selectedChip == chipText ? FontWeight.w700 : FontWeight.w500,
                    color: selectedChip == chipText ? Colors.white : const Color(0XFF777777)
                  )
                ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              side: BorderSide.none,
              backgroundColor: selectedChip == chipText ? const Color(0xFF333333) : const Color(0XFFF6F6F6),
            ),
          );
        }).toList(),
      ),
    );
  }
}
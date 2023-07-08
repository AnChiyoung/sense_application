import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

Widget birthdayLabel = Container(
  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
  decoration: BoxDecoration(
    color: StaticColor.birthdayLabelColor,
    borderRadius: BorderRadius.circular(16.0),
  ),
  child: const Text('생일', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
);

Widget dateLabel = Container(
  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
  decoration: BoxDecoration(
    color: StaticColor.dateLabelColor,
    borderRadius: BorderRadius.circular(16.0),
  ),
  child: const Text('데이트', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
);

Widget travelLabel = Container(
  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
  decoration: BoxDecoration(
    color: StaticColor.travelLabelColor,
    borderRadius: BorderRadius.circular(16.0),
  ),
  child: const Text('여행', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
);

Widget meetLabel = Container(
  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
  decoration: BoxDecoration(
    color: StaticColor.meetLabelColor,
    borderRadius: BorderRadius.circular(16.0),
  ),
  child: const Text('모임', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
);

Widget businessLabel = Container(
  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
  decoration: BoxDecoration(
    color: StaticColor.businessLabelColor,
    borderRadius: BorderRadius.circular(16.0),
  ),
  child: const Text('비즈니스', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
);
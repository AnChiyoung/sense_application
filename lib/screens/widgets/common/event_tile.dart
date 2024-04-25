import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/event_color.dart';

class EventTile extends StatelessWidget {
  final int eventType;
  final bool isPublic;
  final DateTime date;
  final String title;
  final String withSomeone;
  final String location;
  final String eventName;

  const EventTile(
      {super.key,
      required this.eventType,
      required this.isPublic,
      required this.date,
      required this.title,
      required this.withSomeone,
      required this.eventName,
      required this.location});

  @override
  Widget build(BuildContext context) {
    Color eventColor = EventColor(id: eventType).getColor();

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: eventColor,
              borderRadius: BorderRadius.circular(4),
            ),
            width: 4,
            height: double.infinity,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ColoredBox(
                            color: primaryColor[99]!,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 6,
                              ),
                              child: Text(
                                'D-2',
                                style: TextStyle(
                                  color: primaryColor[40],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          if (!isPublic) ...[
                            const SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(
                              'lib/assets/images/icons/svg/lock_fill.svg',
                              width: 16,
                              height: 16,
                            )
                          ]
                        ],
                      ),
                      SizedBox(
                        height: 32,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          // iconSize: 5,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz_outlined,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  IntrinsicHeight(
                    child: Row(
                      children: [
                        // Event With
                        SvgPicture.asset(
                          'lib/assets/images/icons/svg/user.svg',
                          color: const Color(0xFFBBBBBB),
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          withSomeone,
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const VerticalDivider(
                          thickness: 1,
                          width: 16,
                          color: Color(0xFFEEEEEE),
                        ),

                        // Event Location

                        if (location.isNotEmpty) ...[
                          SvgPicture.asset(
                            'lib/assets/images/icons/svg/pin_outlined.svg',
                            color: const Color(0xFFBBBBBB),
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            location,
                            style: const TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            width: 16,
                            color: Color(0xFFEEEEEE),
                          ),
                        ],

                        // Date
                        SvgPicture.asset(
                          'lib/assets/images/icons/svg/bottom_bar/calendar_blank.svg',
                          color: const Color(0xFFBBBBBB),
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(date),
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const VerticalDivider(
                          thickness: 1,
                          width: 16,
                          color: Color(0xFFEEEEEE),
                        ),

                        // Star
                        SvgPicture.asset(
                          'lib/assets/images/icons/svg/star_outlined.svg',
                          color: const Color(0xFFBBBBBB),
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          eventName,
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Event Members
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFF6F6F6),
                        width: 1,
                      ),
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            '연인',
                            style: TextStyle(
                              color: Color(0xFF464646),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('https://i.pravatar.cc/50?random=1'),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 1,
                            width: 16,
                            color: Color(0xFFEEEEEE),
                          ),
                          Text(
                            '멤버',
                            style: TextStyle(
                              color: Color(0xFF464646),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('https://i.pravatar.cc/50?random=2'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  // Event action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: 4,
                      //   child: Expanded(
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: primaryColor[50],
                      //         borderRadius: BorderRadius.circular(999),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'lib/assets/images/icons/svg/heart.svg',
                          color: const Color(0xFF555555),
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '7',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'lib/assets/images/icons/svg/share.svg',
                          color: const Color(0xFF555555),
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '공유',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'lib/assets/images/icons/svg/chat.svg',
                          color: const Color(0xFF999999),
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '4',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'lib/assets/images/icons/svg/eye.svg',
                          color: const Color(0xFF999999),
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '4,575',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

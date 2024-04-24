import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/screens/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/screens/schedule_screen/partials/calendar.dart';
import 'package:sense_flutter_application/screens/schedule_screen/partials/event_list.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_modal.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_toast.dart';
import 'package:sense_flutter_application/store/providers/Schedule/event_collection.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  double setSize(double size, double screenHeight) {
    return size / screenHeight;
  }

  DraggableScrollableController controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        kBottomNavigationBarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    double initialRatio = ((104 / 375) * screenWidth);
    double initialSize = setSize(screenHeight - initialRatio, screenHeight);
    double halfSize = setSize(screenHeight - ((344 / 375) * screenWidth), screenHeight);

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.light(
          primary: primaryColor[50] ?? Colors.white,
          secondary: secondary1Color[50] ?? Colors.white,
          onPrimary: primaryColor[50] ?? Colors.white,
        ),
      ),
      home: MainLayout(
          pathName: 'schedule',
          title: '',
          body: Consumer(
            builder: (context, ref, child) => Stack(
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  DateTime calendar = ref.watch(calendarSelectorProvider);

                  return AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        double scrollSize = controller.isAttached
                            ? (controller.size > 0.3 ? halfSize : controller.size)
                            : initialSize;
                        double layoutHeight = constraints.maxHeight -
                            ((controller.isAttached ? scrollSize : initialSize) *
                                constraints.maxHeight);

                        return GestureDetector(
                          onVerticalDragEnd: (details) {
                            if (details.velocity.pixelsPerSecond.dy < 0 &&
                                controller.size.round() <= 0) {
                              controller.animateTo(setSize(screenHeight - 104, screenHeight),
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                              left: 20,
                              right: 20,
                            ),
                            width: screenWidth,
                            height: layoutHeight,
                            // child: const ColoredBox(
                            //   color: Colors.red,
                            // ),
                            child: Calendar(
                              presentDate: calendar,
                              height: layoutHeight,
                              widgetSize: controller.isAttached ? controller.size : initialSize,
                            ),
                          ),
                        );
                      });
                }),
                DraggableScrollableSheet(
                  controller: controller,
                  maxChildSize: initialSize,
                  initialChildSize: initialSize,
                  snapSizes: [halfSize, initialSize],
                  minChildSize: 0,
                  snap: true,
                  builder: (BuildContext context, ScrollController scrollController) {
                    // print();
                    // scrollController.detach(scrollController.position);

                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1,
                        )),
                      ),
                      // List of Events
                      child: Column(
                        // Dragger Bar
                        children: [
                          GestureDetector(
                            onVerticalDragUpdate: (event) {
                              if (event.delta.dy < 0) {
                                controller.jumpTo(controller
                                    .pixelsToSize(controller.pixels + event.delta.distance));
                              } else {
                                controller.jumpTo(controller
                                    .pixelsToSize(controller.pixels - event.delta.distance));
                              }
                            },
                            onVerticalDragEnd: (event) {
                              if (controller.size > halfSize &&
                                  event.velocity.pixelsPerSecond.dy < 0) {
                                controller.animateTo(initialSize,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              } else if (controller.size <= initialSize &&
                                  controller.size > halfSize) {
                                controller.animateTo(halfSize,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              } else if (controller.size < halfSize) {
                                controller.animateTo(0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              }
                            },
                            child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: 8, bottom: 10),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    width: 74,
                                    height: 4,
                                  ),
                                )),
                          ),
                          // Scroll List
                          Expanded(
                              child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              // Calculate the new position immediately in response to the drag.
                              double scale =
                                  2.0; // This scale factor can be adjusted to control sensitivity
                              double newPosition =
                                  scrollController.position.pixels - details.primaryDelta! * scale;
                              scrollController.jumpTo(newPosition.clamp(
                                  0.0, scrollController.position.maxScrollExtent));
                            },
                            onVerticalDragEnd: (details) {
                              // When the drag ends, we apply some additional inertia
                              double velocity = details.primaryVelocity! *
                                  0.2; // Adjust the multiplier to control the inertia effect
                              double targetPosition = scrollController.position.pixels - velocity;

                              if (targetPosition < 0 ||
                                  targetPosition > scrollController.position.maxScrollExtent) {
                                // If the target position is out of range, use a bounce effect.
                                targetPosition = targetPosition.clamp(
                                    0.0, scrollController.position.maxScrollExtent);
                              }

                              scrollController.animateTo(
                                targetPosition,
                                duration: const Duration(
                                    milliseconds:
                                        500), // Adjust timing to simulate natural deceleration
                                curve: Curves
                                    .decelerate, // This curve gives a natural "slow down" effect
                              );
                            },
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(top: 8),
                              controller: scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: EventList()),
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          floating: SizedBox(
            width: 116,
            child: CustomButton(
              height: 44,
              borderRadius: const BorderRadius.all(Radius.circular(999)),
              prefixIcon: SvgPicture.asset(
                'lib/assets/images/icons/svg/plus.svg',
                color: Colors.white,
                width: 14,
                height: 14,
              ),
              backgroundColor: primaryColor[50] ?? Colors.transparent,
              textColor: Colors.white,
              labelText: '이벤트 생성',
              fontSize: 14,
            ),
          )),
    );
  }
}

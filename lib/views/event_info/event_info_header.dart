import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/public_widget/event_info_recommend_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class EventInfoHeader extends StatefulWidget {
  Key drawerKey;
  EventInfoHeader({super.key, required this.drawerKey});

  @override
  State<EventInfoHeader> createState() => _EventInfoHeaderState();
}

class _EventInfoHeaderState extends State<EventInfoHeader> {

  String title = '이벤트';

  @override
  Widget build(BuildContext context) {
    return Consumer<EventInfoProvider>(
        builder: (context, data, child) {
          bool isStepping = data.isStepping;
          // bool isFinishRecommend = data.recommendRequestState;
          int recommendStep = data.eventRecommendStep;
          title = context.read<CreateEventProvider>().title;

          bool isExistBackCallback = false;

          print('다시 들어옴');

          if(isStepping == true) {
            if(recommendStep == 1) {
              isExistBackCallback = false;
            } else {
              isExistBackCallback = true;
            }
          } else {
            isExistBackCallback = true;
          }

          // if (isStepping == true) {
          //   if (recommendStep == 1) {
          //     isExistBackCallback = false;
          //   } else {
          //     isExistBackCallback = true;
          //   }
          // } else {
          //   isExistBackCallback = true;
          // }
          return HeaderMenu(backCallback: isExistBackCallback == true ? stepBackCallback : null, title: title, rightMenu: rightMenu());
          // return HeaderMenu(backCallback: isRecommendState == true ? recommendCallback : backCallback, title: title, rightMenu: rightMenu());
        }
    );
  }

  void stepBackCallback() {
    int stepNumber = context.read<EventInfoProvider>().eventRecommendStep;
    bool isStepping = context.read<EventInfoProvider>().isStepping;

    if(isStepping == true) {
      if(stepNumber == 1) {

      } else {
        context.read<EventInfoProvider>().eventRecommendStepChange(
            context.read<EventInfoProvider>().eventRecommendStep - 1
        );
      }
    } else {

    }
  }

  void eventInfoBackCallback() {

  }

  void recommendCallback() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const RecommendCancelDialog();
      }
    );
  }

  Widget rightMenu() {
    return Consumer<EventInfoProvider>(
      builder: (context, data, child) {

        bool isStepping = data.isStepping;
        bool isFinishRecommend = data.recommendRequestState;
        int recommendStep = data.eventRecommendStep;

        if(isStepping == true) {
          return Material(
              color: Colors.transparent,
              child: SizedBox(
                width: 40,
                height: 40,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25.0),
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const RecommendCancelDialog();
                        }
                    );
                  },
                  child: Center(child: Image.asset('assets/signin/button_close.png', width: 24, height: 24)),
                ),
              )
          );
        } else {
          return GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Image.asset('assets/recommended_event/menu.png', width: 24, height: 24)
          );
        }
      }
    );
  }
}
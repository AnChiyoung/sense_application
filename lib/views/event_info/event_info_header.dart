import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/public_widget/event_info_recommend_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class EventInfoHeader extends StatefulWidget {
  String title;
  // Key drawerKey;
  EventInfoHeader({super.key, required this.title});

  @override
  State<EventInfoHeader> createState() => _EventInfoHeaderState();
}

class _EventInfoHeaderState extends State<EventInfoHeader> {

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: eventInfoBackCallback, title: widget.title, rightMenu: rightMenu());
    // return HeaderMenu(backCallback: isRecommendState == true ? recommendCallback : backCallback, title: title, rightMenu: rightMenu());
  }

  void stepBackCallback() {
    int stepNumber = context.read<CreateEventProvider>().eventRecommendStep;
    bool isStepping = context.read<CreateEventProvider>().isStepping;

    if(isStepping == true) {
      if(stepNumber == 1) {

      } else if(stepNumber == 2) {
        context.read<CreateEventProvider>().eventRecommendStepChange(
            context.read<CreateEventProvider>().eventRecommendStep - 1
        );
        context.read<CreateEventProvider>().recommendStep02Init();
      } else if(stepNumber == 3) {
        context.read<CreateEventProvider>().eventRecommendStepChange(
            context.read<CreateEventProvider>().eventRecommendStep - 1
        );
      }
    } else {
      eventInfoBackCallback();
    }
  }

  void eventInfoBackCallback() {
    /// one piece
    context.read<CreateEventImproveProvider>().createEventClear(null);
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 3)));
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
    return Consumer<CreateEventProvider>(
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
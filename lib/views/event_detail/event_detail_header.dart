import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/event_info_recommend_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';

class EventDetailHeader extends StatefulWidget {
  const EventDetailHeader({ super.key });

  @override
  State<EventDetailHeader> createState() => _EventDetailHeaderState();
}

class _EventDetailHeaderState extends State<EventDetailHeader> {

  void backCallback() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 3)));
  }

  /// 분기처리
  /// 이벤트 생성중 일때: 취소 버튼
  /// 이벤트 보기중 일때 {
  ///   내꺼일때: drawer 노출
  ///   다른사람꺼일때: 빈칸
  /// }
  Widget rightMenu(EventModel eventModel) {
    if (eventModel.eventHost?.id == PresentUserInfo.id) {
      return GestureDetector(
        onTap: () {
          Scaffold.of(context).openEndDrawer();
        },
        child: Image.asset(
          'assets/recommended_event/menu.png', 
          width: 24, 
          height: 24
        ),
      );


      // return Material(
      //   color: Colors.transparent,
      //   child: SizedBox(
      //     width: 40,
      //     height: 40,
      //     child: InkWell(
      //       borderRadius: BorderRadius.circular(25.0),
      //       onTap: () {
      //         showDialog(
      //           context: context,
      //           barrierDismissible: false,
      //           builder: (BuildContext context) {
      //             return RecommendCancelDialog();
      //           }
      //         );
      //       },
      //       child: Center(
      //         child: Image.asset(
      //           'assets/signin/button_close.png', 
      //           width: 24, 
      //           height: 24,
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    }


    return const SizedBox.shrink();    
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<EDProvider>(
      builder: (context, data, child) {
        return HeaderMenu(
          backCallback: backCallback, 
          title: data.eventModel.eventTitle, 
          rightMenu: rightMenu(data.eventModel),
        );
      },
    );
  }

  void stepBackCallback() {
    // int stepNumber = context.read<CreateEventProvider>().eventRecommendStep;
    // bool isStepping = context.read<CreateEventProvider>().isStepping;

    // if(isStepping == true) {
    //   if(stepNumber == 1) {

    //   } else if(stepNumber == 2) {
    //     context.read<CreateEventProvider>().eventRecommendStepChange(
    //         context.read<CreateEventProvider>().eventRecommendStep - 1
    //     );
    //     context.read<CreateEventProvider>().recommendStep02Init();
    //   } else if(stepNumber == 3) {
    //     context.read<CreateEventProvider>().eventRecommendStepChange(
    //         context.read<CreateEventProvider>().eventRecommendStep - 1
    //     );
    //   }
    // } else {
    //   eventInfoBackCallback();
    // }
  }

  // void eventInfoBackCallback() {
  //   /// one piece
  //   context.read<CreateEventImproveProvider>().createEventClear(null);
  //   context.read<CreateEventProvider>().regionInitialize();
  //   int prevHomeIndex = context.read<HomeProvider>().selectHomeIndex;
  //   if(prevHomeIndex == 2) {
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 2)));
  //   } else {
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 3)));
  //   }
  // }

  void recommendCallback() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RecommendCancelDialog();
      }
    );
  }


}
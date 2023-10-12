import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_category.dart';
import 'package:sense_flutter_application/views/create_event/create_event_date.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_region.dart';
import 'package:sense_flutter_application/views/create_event/create_event_target.dart';

class CreateEventBottomSheetView extends StatefulWidget {
  bool edit;
  CreateEventBottomSheetView({super.key, required this.edit});

  @override
  State<CreateEventBottomSheetView> createState() => _CreateEventBottomSheetViewState();
}

class _CreateEventBottomSheetViewState extends State<CreateEventBottomSheetView> {

  @override
  Widget build(BuildContext context) {

    final safeAreaTopPadding = context.read<CreateEventProvider>().safeAreaTopPadding;
    final safeAreaBottomPadding = context.read<CreateEventProvider>().safeAreaBottomPadding;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - safeAreaTopPadding - 60, /// 마지막 60은 header widget height
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Stack(
        children: [
          const Column(
            children: [
              CreateEventBottomSheetHeaderBar(),
              CreateEventBottomSheetTitle(),
              CreateEventBottomSheetStepField(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CreateEventBottomSheetSubmitButton(bottomPadding: safeAreaBottomPadding, edit: widget.edit),
          )
        ]
      )

    );
  }
}

class CreateEventBottomSheetHeaderBar extends StatelessWidget {
  const CreateEventBottomSheetHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4));
  }
}

class CreateEventBottomSheetTitle extends StatelessWidget {
  const CreateEventBottomSheetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
      builder: (context, data, child) {

        String createEventBottomSheetTitle = '';

        if(data.eventStepNumber == 0) {
          createEventBottomSheetTitle = '이벤트 유형';
        } else if(data.eventStepNumber == 1) {
          createEventBottomSheetTitle = '이벤트 대상';
        } else if(data.eventStepNumber == 2) {
          createEventBottomSheetTitle = '이벤트 날짜';
        } else if(data.eventStepNumber == 3) {
          createEventBottomSheetTitle = '이벤트 지역';
        }

        return Text(createEventBottomSheetTitle, style: TextStyle(fontSize: 16.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500));
      }
    );
  }
}

class CreateEventBottomSheetStepField extends StatefulWidget {
  const CreateEventBottomSheetStepField({super.key});

  @override
  State<CreateEventBottomSheetStepField> createState() => _CreateEventBottomSheetStepFieldState();
}

class _CreateEventBottomSheetStepFieldState extends State<CreateEventBottomSheetStepField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
      builder: (context, data, child) {

        Widget fetchWidget = Container();

        if(data.eventStepNumber == 0) {
          fetchWidget = const CreateEventCategoryView();
        } else if(data.eventStepNumber == 1) {
          fetchWidget = const CreateEventTargetView();
        } else if(data.eventStepNumber == 2) {
          fetchWidget = const CreateEventDateView();
        } else if(data.eventStepNumber == 3) {
          fetchWidget = const CreateEventRegionView();
        }

        return  Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: fetchWidget,
        );
      }
    );
  }
}

class CreateEventBottomSheetSubmitButton extends StatefulWidget {
  double bottomPadding;
  bool edit;
  CreateEventBottomSheetSubmitButton({super.key, required this.bottomPadding, required this.edit});

  @override
  State<CreateEventBottomSheetSubmitButton> createState() => _CreateEventBottomSheetSubmitButtonState();
}

class _CreateEventBottomSheetSubmitButtonState extends State<CreateEventBottomSheetSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
          onPressed: () {
            submitButtonListeners(widget.edit);
          },
          style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
              ]
          )
      ),
    );
  }

  void submitButtonListeners(bool edit) {
    final step = context.read<CreateEventImproveProvider>().eventStepNumber;

    if(step == 0) {
      categoryListener(edit);
    } else if(step == 1) {
      targetListener(edit);
    } else if(step == 2) {
      dateListener(edit);
    } else if(step == 3) {
      regionListener();
    }
  }

  void categoryListener(bool edit) async {
    // int selectCategoryIndex = context.read<CreateEventProvider>().categoryState.indexOf(true);
    context.read<CreateEventImproveProvider>().saveCategoryChange(null, true);
    if(edit == true) {
      bool categoryChangeResult = await EventRequest().personalFieldUpdateEvent(
        context,
        context.read<CreateEventImproveProvider>().eventUniqueId,
        1
      );
      if(categoryChangeResult == true) {
        print('view category change : ${context.read<CreateEventImproveProvider>().category}');
        context.read<CreateEventImproveProvider>().saveCategoryChange(null, true);
      }
    }

    // context.read<CreateEventProvider>().categoryChange(selectCategoryIndex);
    // print(selectCategoryIndex);
    Navigator.pop(context);
  }

  void targetListener(bool edit) async {
    // int selectTargetIndex = context.read<CreateEventProvider>().targetState.indexOf(true);
    context.read<CreateEventImproveProvider>().saveTargetChange(null, true);
    if(edit == true) {
      bool targetChangeResult = await EventRequest().personalFieldUpdateEvent(
        context,
        context.read<CreateEventImproveProvider>().eventUniqueId,
        2
      );
      if(targetChangeResult == true) {
        print('view target change : ${context.read<CreateEventImproveProvider>().target}');
        context.read<CreateEventImproveProvider>().saveTargetChange(null, true);
      }
    }

    // context.read<CreateEventProvider>().targetChange(selectTargetIndex);
    Navigator.pop(context);
  }

  void dateListener(bool edit) async {
    String selectDateToSave = context.read<CreateEventImproveProvider>().selectDate;
    if(edit == true) {
      print('this');
      context.read<CreateEventImproveProvider>().dateChange(selectDateToSave, false);
      bool dateChangeResult = await EventRequest().personalFieldUpdateEvent(
          context,
          context.read<CreateEventImproveProvider>().eventUniqueId,
          3
      );
      if(dateChangeResult == true) {
        context.read<CreateEventImproveProvider>().dateChange(selectDateToSave, true);
        print('view date change : ${context.read<CreateEventImproveProvider>().date}');
      }
      Navigator.pop(context);
    } else {
      context.read<CreateEventImproveProvider>().dateChange(selectDateToSave, true);
      Navigator.pop(context);
    }
  }

  void regionListener() {
    // context.read<CreateEventProvider>().tester('1');
    // context.read<CreateEventProvider>().saveRegionChange();
    context.read<CreateEventProvider>().cityChange();
    Navigator.pop(context);
  }
}
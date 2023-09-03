import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/actions.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/event_info/event_info_screen.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

/// header
class CreateEventHeader extends StatefulWidget {
  const CreateEventHeader({super.key});

  @override
  State<CreateEventHeader> createState() => _CreateEventHeaderState();
}

class _CreateEventHeaderState extends State<CreateEventHeader> {

  TextStyle titleStyle = TextStyle(fontSize: 16.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500);
  Size? size;
  final GlobalKey _containerKey = GlobalKey();

  Size? _getSize() {
    if(_containerKey.currentContext != null) {
      final RenderBox renderBox =
          _containerKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        size = _getSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', titleStyle: titleStyle);
  }

  void backCallback() {
    String title = context.read<CreateEventImproveProvider>().title;
    int category = context.read<CreateEventImproveProvider>().category;
    int target = context.read<CreateEventImproveProvider>().target;
    String date = context.read<CreateEventImproveProvider>().date;
    String memo = context.read<CreateEventImproveProvider>().memo;

    if(title.isEmpty && category == -1 && target == -1 && date.isEmpty && memo.isEmpty) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const AddEventCancelDialog();
          }
      );
    }
  }
}

/// event info
class CreateEventInfoView extends StatefulWidget {
  const CreateEventInfoView({super.key});

  @override
  State<CreateEventInfoView> createState() => _CreateEventInfoViewState();
}

class _CreateEventInfoViewState extends State<CreateEventInfoView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 20.0.h),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          CreateEventTitleView(),
          SizedBox(height: 16.0.h),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: CreateEventCategoryView()),
              SizedBox(width: 26.0.w),
              Expanded(
                flex: 1,
                child: CreateEventTargetView()),
            ]
          ),
          SizedBox(height: 8.0.h),
          Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: CreateEventDateView()),
                SizedBox(width: 26.0.w),
                Expanded(
                    flex: 1,
                    child: CreateEventLocationView()),
              ]
          ),
          SizedBox(height: 16.0.h),
          CreateEventMemoView(),
        ],
      ),
    );
  }
}

class CreateEventTitleView extends StatefulWidget {
  const CreateEventTitleView({super.key});

  @override
  State<CreateEventTitleView> createState() => _CreateEventTitleViewState();
}

class _CreateEventTitleViewState extends State<CreateEventTitleView> {

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text('제목', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: TextFormField(
                controller: titleController,
                autofocus: false,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                maxLength: 20,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: StaticColor.black90015),
                decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: StaticColor.loginInputBoxColor,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    alignLabelWithHint: false,
                    labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                    hintText: 'ex.금요미식회 정기모임',
                    hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide.none,
                    )
                ),
                onChanged: (v) {
                  context.read<CreateEventImproveProvider>().titleChange(v);
                  v.isEmpty ? context.read<CreateEventProvider>().createButtonStateChange(false) : context.read<CreateEventProvider>().createButtonStateChange(true);
                }
            ),
          ),
        )
      ],
    );
  }
}

class CreateEventCategoryView extends StatelessWidget {
  const CreateEventCategoryView({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text('유형', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<CreateEventImproveProvider>().eventStepState(0);
              context.read<CreateEventImproveProvider>().selectCategorySink();
              TriggerActions().showCreateEventView(context);
            },
            child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Consumer<CreateEventImproveProvider>(
                    builder: (context, data, child) {

                      String categoryText = '';

                      if(data.category == -1){
                        categoryText = '선택하기';
                      } else if(data.category == 0) {
                        categoryText = '생일';
                      } else if(data.category == 1) {
                        categoryText = '데이트';
                      } else if(data.category == 2) {
                        categoryText = '여행';
                      } else if(data.category == 3) {
                        categoryText = '모임';
                      } else if(data.category == 4) {
                        categoryText = '비즈니스';
                      } else {
                        categoryText = data.category.toString();
                      }

                      return Center(child: Text(categoryText, style: TextStyle(fontSize: 14.sp, color: data.category == -1 ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
                    }
                )
            ),
          ),
        )
      ],
    );
  }
}

class CreateEventTargetView extends StatelessWidget {
  const CreateEventTargetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('대상', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<CreateEventImproveProvider>().eventStepState(1);
              context.read<CreateEventImproveProvider>().selectTargetSink();
              TriggerActions().showCreateEventView(context);
            },
            child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              child: Consumer<CreateEventImproveProvider>(
                builder: (context, data, child) {

                  String targetText = '';

                  if(data.target == -1) {
                    targetText = '선택하기';
                  } else if(data.target == 0) {
                    targetText = '가족';
                  } else if(data.target == 1) {
                    targetText = '연인';
                  } else if(data.target == 2) {
                    targetText = '친구';
                  } else if(data.target == 3) {
                    targetText = '직장';
                  } else {
                    targetText = data.target.toString();
                  }

                  return Center(child: Text(targetText, style: TextStyle(fontSize: 14.sp, color: data.target == -1 ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
                }
              )
            ),
          ),
        )
      ],
    );
  }
}

class CreateEventDateView extends StatefulWidget {
  const CreateEventDateView({super.key});

  @override
  State<CreateEventDateView> createState() => _CreateEventDateViewState();
}

class _CreateEventDateViewState extends State<CreateEventDateView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('날짜', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<CreateEventImproveProvider>().eventStepState(2);
              TriggerActions().showCreateEventView(context);
            },
            child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              child: Consumer<CreateEventImproveProvider>(
                  builder: (context, data, child) {

                    String dateText = '';

                    if(data.date.isEmpty){
                      dateText = '선택하기';
                    } else {
                      dateText = data.date.toString();
                    }

                    return Center(child: Text(dateText, style: TextStyle(fontSize: 14.sp, color: data.date.isEmpty ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
                  }
              )
            ),
          ),
        )
      ],
    );
  }
}

class CreateEventLocationView extends StatefulWidget {
  const CreateEventLocationView({super.key});

  @override
  State<CreateEventLocationView> createState() => _CreateEventLocationViewState();
}

class _CreateEventLocationViewState extends State<CreateEventLocationView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('위치', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<CreateEventImproveProvider>().eventStepState(3);
              // TriggerActions().showCreateEventView(context);
            },
            child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              child: Consumer<CreateEventProvider>(
                  builder: (context, data, child) {

                    String regionText = '';
                    int city = data.city;
                    List<int> subCity = data.subCity;

                    if(data.subCity.isEmpty) {
                      regionText = '선택하기';
                    } else {
                      regionText = '서울';
                      if(subCity.length == 2) {
                        regionText = '서울 강남 외 1';
                      } else {
                        subCity.contains(1) ? regionText = '서울 강남' : regionText = '서울 삼성';
                      }
                    }

                    // if(data.city == -1) {
                    //   regionText = '선택하기';
                    // } else {
                    //   if(data.city == 0) {
                    //
                    //   } else if(data.city == 1) {
                    //
                    //   } else if(data.city == 2) {
                    //
                    //   }
                    // }

                    // if(data.city == '0') {
                    //   regionText = '선택하기';
                    // } else {
                    //   print('aa ${context.read<CreateEventProvider>().cityList.elementAt(int.parse(data.city) - 1).title}');
                    //   regionText = context.watch<CreateEventProvider>().cityList.elementAt(int.parse(data.city) - 1).title.toString();
                    //   regionText = context.read<CreateEventProvider>().cityList.elementAt(int.parse(data.city) - 1).title.toString();
                    // }

                    return Center(child: Text(regionText, style: TextStyle(fontSize: 14.sp, color: data.city == -1 ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
                  }
              )
            ),
          ),
        )
      ],
    );
  }
}

class CreateEventMemoView extends StatefulWidget {
  const CreateEventMemoView({super.key});

  @override
  State<CreateEventMemoView> createState() => _CreateEventMemoViewState();
}

class _CreateEventMemoViewState extends State<CreateEventMemoView> {

  TextEditingController memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text('메모', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
        const SizedBox(width: 14.0),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: 500.h,
              child: TextFormField(
                  controller: memoController,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  maxLines: 6,
                  maxLength: 200,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(color: StaticColor.black90015),
                  decoration: InputDecoration(
                    counterText: '',
                      filled: true,
                      fillColor: StaticColor.grey100F6,
                      // fillColor: Colors.black,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      alignLabelWithHint: false,
                      labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                      hintText: '이벤트에 대한 메모를 기록해보세요\n(최대 200자)',
                      hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide.none,
                      )
                  ),
                  onChanged: (v) {
                    context.read<CreateEventImproveProvider>().memoChange(v);
                  }
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CreateEventButton extends StatefulWidget {
  const CreateEventButton({super.key});

  @override
  State<CreateEventButton> createState() => _CreateEventButtonState();
}

class _CreateEventButtonState extends State<CreateEventButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
      builder: (context, data, child) {

        bool buttonState = data.createEventButtonState;

        return SizedBox(
          width: double.infinity,
          height: 70.h,
          child: ElevatedButton(
              onPressed: () async {
                if(buttonState == true) {
                  bool result = await EventRequest().eventCreateRequest(context);
                  if(result == true) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventInfoScreen()));
                  } else {
                    /// nothing!!!
                  }
                } else {
                  /// nothing!!!
                }
                // if(buttonCallbackActiveState() == true) {
                //   bool result = await EventRequest().eventCreateRequest(context);
                //   if(result == true) {
                //     /// navigator push => to event info
                //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventInfoScreen()));
                //   } else {
                //     print('model request check plz..');
                //   }
                // } else {
                //   print('event create no actions');
                // }
              },
              style: ElevatedButton.styleFrom(backgroundColor: buttonState == false ? StaticColor.grey400BB : StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 56, child: Center(child: Text('완료', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
                  ]
              )
          ),
        );
      }
    );
  }

  /// 제목만 입력되면 이벤트 생성 가능
  bool buttonCallbackActiveState() {
    return context.read<CreateEventProvider>().title != '';
        // && context.read<CreateEventProvider>().category != -1
        // && context.read<CreateEventProvider>().target != -1
        // && context.read<CreateEventProvider>().date != '';
        // && context.read<CreateEventProvider>().memo != ''
  }
}

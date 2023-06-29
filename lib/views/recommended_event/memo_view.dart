import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/models/recommended_event/recommended_model.dart';
import 'package:sense_flutter_application/models/recommended_event/memo_model.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/public_widget/show_loading.dart';
import 'package:sense_flutter_application/screens/recommended_event/event_info_screen.dart';
import 'package:sense_flutter_application/screens/recommended_event/recommended_screen.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';

class MemoHeaderMenu extends StatefulWidget {
  const MemoHeaderMenu({Key? key}) : super(key: key);

  @override
  State<MemoHeaderMenu> createState() => _MemoHeaderMenuState();
}

class _MemoHeaderMenuState extends State<MemoHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: AddEventModel.editorMode == true ? null : backCallback, title: '이벤트 생성', closeCallback: closeCallback);
  }

  void backCallback() {
    Navigator.of(context).pop();
    context.read<RecommendedEventProvider>().memoNextButtonStateReset();
  }

  void closeCallback() {
    AddEventModel.editorMode == true ? Navigator.of(context).pop() : showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AddEventCancelDialog();
        });
  }
}

class MemoTitle extends StatelessWidget {
  const MemoTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('자세한 요청사항을\n알려주세요', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
          ],
        )
    );
  }
}

class MemoDescription extends StatefulWidget {
  const MemoDescription({Key? key}) : super(key: key);

  @override
  State<MemoDescription> createState() => _MemoDescriptionState();
}

class _MemoDescriptionState extends State<MemoDescription> {

  late TextEditingController teController;

  @override
  void initState() {
    // teController = TextEditingController(text: memoDummyModel);
    teController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 200),
      child: TextField(
        controller: teController,
        maxLength: 500,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (text) {
          if(text.isNotEmpty) {
            context.read<RecommendedEventProvider>().memoNextButtonState(true);
          } else if(text.isEmpty) {
            context.read<RecommendedEventProvider>().memoNextButtonState(false);
          }
          AddEventModel.memoModel = teController.text;
          // 메모 더미 모델

        },
        cursorHeight: 22,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            // counterText: '',
            hintText: '예)다른 선물은 이미 준비했고 꽃다발만 사면 될 거\n같아요. 파스텔톤 분홍색이 들어간 꽃다발로\n추천해주세요.',
            hintStyle: TextStyle(fontSize: 14, color: StaticColor.memoHintColor, fontWeight: FontWeight.w400), // line height: 20
            contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
            filled: true,
            fillColor: StaticColor.textFormFieldFillColor,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(8.0),
            )
        ),
      ),
    );
  }
}

class MemoNextButton extends StatefulWidget {
  const MemoNextButton({Key? key}) : super(key: key);

  @override
  State<MemoNextButton> createState() => _MemoNextButtonState();
}

class _MemoNextButtonState extends State<MemoNextButton> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  Future backButtonAction(BuildContext context) async {
    context.read<RecommendedEventProvider>().nextButtonReset();
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final buttonEnabled = context.watch<RecommendedEventProvider>().memoNextButton;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () {
              // FutureBuilder<bool>(
              //     future: RecommendedApi().getRecommendList(AddEventModel.recommendedModel.elementAt(0)),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if(snapshot.hasData) {
              //         return Container();
              //       } else if(snapshot.hasError){
              //         return Container();
              //       } else {
              //         return Container();
              //       }
              //     }
              // );



              // var aa = {
              //   "title": "test",
              //   "type": "BIRTHDAY",
              //   // "recommend_type": AddEventModel.recommendedModel.elementAt(0),
              //   "recommend_type": "ACTIVITY",
              //   "start_date": "2023-04-15T17:25:03.903Z",
              //   "max_cost": "25",
              //   "description": "test",
              //   "address": ["일산", "대구"],
              //   "event_users": [1,2,3]
              // };
              // var createEventModel = CreateEventModel(
              //   title: AddEventModel.eventTypeModel,
              //   eventType: AddEventModel.eventTypeModel,
              //   recommendedType: AddEventModel.recommendedModel.toString(),
              //   date: AddEventModel.dateModel,
              //   cost: AddEventModel.costModel,
              //   description: AddEventModel.memoModel,
              //   region: AddEventModel.regionModel.toString(),
              //   // user: [1],
              // ).toJson();
              // print(aa);

              Loading().showLoading(RecommendedScreen(), context, controller, null);
              // AddEventModel.editorMode == true ? {AddEventModel.editorMode = false, Navigator.of(context).pop(), context.read<RecommendedEventProvider>().titleChange()} :
              // buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => EventInfoScreen())) : (){};
            },
            style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled == true ? StaticColor.categorySelectedColor : StaticColor.unSelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(height: 56, child: Center(child: Text('완료', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)))),
                ]
            )
        ),
      ),
    );
  }


}

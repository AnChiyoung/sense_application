import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

/// header
class CreateEventHeader extends StatefulWidget {
  const CreateEventHeader({super.key});

  @override
  State<CreateEventHeader> createState() => _CreateEventHeaderState();
}

class _CreateEventHeaderState extends State<CreateEventHeader> {

  TextStyle titleStyle = TextStyle(fontSize: 16, color: StaticColor.black90015, fontWeight: FontWeight.w500);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', titleStyle: titleStyle);
  }

  void backCallback() {
    Navigator.of(context).pop();
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
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        children: [
          CreateEventTitleView(),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CreateEventCategoryView()),
              // SizedBox(width: 20.6),
              Expanded(
                flex: 1,
                child: CreateEventTargetView()),
            ]
          ),
          SizedBox(height: 8.0),
          // Row(
          //   children: [
          //     CreateEventDateView(),
          //     CreateEventLocationView(),
          //   ]
          // ),
          // CreateEventMemoView(),
        ],
      ),
    );
  }
}

class CreateEventTitleView extends StatelessWidget {
  const CreateEventTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('제목', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        const SizedBox(width: 14.0),
        GestureDetector(
          onTap: () {},
          child: Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                // color: StaticColor.grey100F6,
                color: Colors.black,
                borderRadius: BorderRadius.circular(4.0),
              )
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
        Text('유형', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        const SizedBox(width: 14.0),
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                // color: StaticColor.grey100F6,
                color: Colors.black,
                borderRadius: BorderRadius.circular(4.0),
              )
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
        Text('대상', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        const SizedBox(width: 14.0),
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                // color: StaticColor.grey100F6,
                color: Colors.black,
                borderRadius: BorderRadius.circular(4.0),
              )
          ),
        )
      ],
    );
  }
}
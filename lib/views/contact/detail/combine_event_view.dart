import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class CombineEventView extends StatefulWidget {
  const CombineEventView({super.key});

  @override
  State<CombineEventView> createState() => _CombineEventViewState();
}

class _CombineEventViewState extends State<CombineEventView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 33.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('친구와의 이벤트', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    showDialog(context: context, builder: (context) => AlertDialog(icon: Container(color: Colors.white)));
                  },
                  child: Row(
                    children: [
                      Text('더보기', style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 2.0),
                      Image.asset('assets/contact/additional_view_arrow.png', width: 20, height: 20),
                    ]
                  )
                ),
              )
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: StaticColor.grey100F6,
            ),
            child: Text('dd', overflow: TextOverflow.ellipsis, ),
          ),
        ],
      ),
    );
  }
}

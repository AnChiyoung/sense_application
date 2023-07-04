import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class AiAnalyticsView extends StatefulWidget {
  const AiAnalyticsView({super.key});

  @override
  State<AiAnalyticsView> createState() => _AiAnalyticsViewState();
}

class _AiAnalyticsViewState extends State<AiAnalyticsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 33.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AI 분석', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
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
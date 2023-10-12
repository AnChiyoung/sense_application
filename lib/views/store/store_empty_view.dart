import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

/// empty page
class StoreEmptyView extends StatefulWidget {
  const StoreEmptyView({super.key});

  @override
  State<StoreEmptyView> createState() => _StoreEmptyViewState();
}

class _StoreEmptyViewState extends State<StoreEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
              height: double.infinity,
                child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/public/loading_logo_image.png', width: 200),
                        SizedBox(height: 24.0.h),
                        Text('서비스 준비중 입니다', style: TextStyle(fontSize: 18.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w700)),
                      ],
                    )
                )
            )
        )
    );
  }
}
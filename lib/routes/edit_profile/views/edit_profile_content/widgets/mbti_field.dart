import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/constants.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';

class MbtiField extends StatefulWidget {
  const MbtiField({super.key});

  @override
  State<MbtiField> createState() => _MBTIFieldState();
}

class _MBTIFieldState extends State<MbtiField> {
  void onPressed(String? mbti) {
    void selectMbti(String? mbti) {
      context.read<EditProfileProvider>().onChangeMbti(mbti, true);
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 460.h,
          child: MbtiBottomSheet(mbti: mbti, onTapItem: selectMbti),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<EditProfileProvider, String?>(
      selector: (context, data) => data.mbti,
      builder: (context, mbti, child) {
        return SizedBox(
          width: double.infinity,
          height: 38.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: mbti == null ? StaticColor.grey300E0 : StaticColor.mainSoft,
            ),
            onPressed: () => onPressed(mbti),
            child: Text(
              mbti ?? 'MBTI를 선택해 주세요',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}

class MbtiBottomSheet extends StatefulWidget {
  final String? mbti;
  final Function(String? mbti)? onTapItem;
  const MbtiBottomSheet({super.key, this.mbti, this.onTapItem});

  @override
  State<MbtiBottomSheet> createState() => _MbtiBottomSheetState();
}

class _MbtiBottomSheetState extends State<MbtiBottomSheet> {
  List<Widget> mbtiWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (context, data, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.h,
                      bottom: 16.h,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/feed/comment_header_bar.png',
                        width: 75.w,
                        height: 4.h,
                        color: StaticColor.dividerColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: Center(
                      child: Text(
                        'MBTI',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: StaticColor.black90015,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Column(
                          children: ['선택안함', ...Constants.mbtiTypes]
                              .map(
                                (e) => mbtiSelector(
                                  mbti: data.mbti,
                                  mbtiString: e,
                                  onTapItem: widget.onTapItem,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 70.h)
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 70.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: StaticColor.categorySelectedColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 56.h,
                          child: const Center(
                            child: Text(
                              '저장',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget mbtiSelector({
    String? mbti,
    String mbtiString = '',
    Function(String? mbti)? onTapItem,
  }) {
    return GestureDetector(
      onTap: () {
        onTapItem?.call(mbtiString);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: mbti == mbtiString ? StaticColor.grey100F6 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24.h,
                alignment: Alignment.center,
                child: Text(
                  mbtiString,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: mbti == mbtiString ? StaticColor.mainSoft : StaticColor.grey70055,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
              mbti == mbtiString
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Image.asset(
                        'assets/create_event/check.png',
                        width: 20.dm,
                        height: 20.dm,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

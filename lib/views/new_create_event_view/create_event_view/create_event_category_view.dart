import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/new_create_event_view/bottom_sheet/category_bottom_sheet.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class CreateEventCategoryView extends StatefulWidget {
  bool? edit;
  CreateEventCategoryView({super.key, this.edit = false});

  @override
  State<CreateEventCategoryView> createState() => _CreateEventCategoryViewState();
}

class _CreateEventCategoryViewState extends State<CreateEventCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('유형', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        widget.edit == true ? CategoryContainer(edit: widget.edit!) :
        Expanded(
          child: CategoryContainer(edit: widget.edit!),
        )
      ],
    );
  }
}

class CategoryContainer extends StatefulWidget {
  bool edit;
  CategoryContainer({super.key, required this.edit});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            useSafeArea: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return CreateEventBottomSheetView();
            }
        );
      },
      child: Container(
          padding: widget.edit == true ? EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h) : EdgeInsets.symmetric(vertical: 18.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: widget.edit == true ? BorderRadius.circular(18.0) : BorderRadius.circular(4.0),
          ),
          child: Consumer<CEProvider>(
              builder: (context, data, child) {
                return Center(child: Text(data.categoryString, style: TextStyle(fontSize: 14.0.sp, color: data.categoryString == "선택하기" ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
              }
          )
      ),
    );
  }
}

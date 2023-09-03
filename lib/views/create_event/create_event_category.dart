import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/create_event_select_tab.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/add_event/add_event_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class CreateEventCategoryView extends StatefulWidget {
  const CreateEventCategoryView({super.key});

  @override
  State<CreateEventCategoryView> createState() => _CreateEventCategoryViewState();
}

class _CreateEventCategoryViewState extends State<CreateEventCategoryView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CategorySelect(),
      ],
    );
  }
}

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
      builder: (context, data, child) {

        // List<bool> state = data.categoryState;
        int selectState = data.selectCategory;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CreateEventSelectTab(
                        checkState: selectState == 0,
                        iconPath: 'assets/create_event/birthday.png',
                        title: '생일',
                        onPressed: () {
                          context.read<CreateEventImproveProvider>().selectCategoryChange(0);
                          // context.read<CreateEventProvider>().categoryStateChange([true, false, false, false, false]);
                        }
                    ),
                  ),
                  SizedBox(width: 13.0.w),
                  Expanded(
                    flex: 1,
                    child: CreateEventSelectTab(
                        checkState: selectState == 1,
                        iconPath: 'assets/create_event/date.png',
                        title: '데이트',
                        onPressed: () {
                          context.read<CreateEventImproveProvider>().selectCategoryChange(1);
                        }
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CreateEventSelectTab(
                        checkState: selectState == 2,
                        iconPath: 'assets/create_event/travel.png',
                        title: '여행',
                        onPressed: () {
                          context.read<CreateEventImproveProvider>().selectCategoryChange(2);
                        }
                    ),
                  ),
                  SizedBox(width: 13.0.w),
                  Expanded(
                    flex: 1,
                    child: CreateEventSelectTab(
                        checkState: selectState == 3,
                        iconPath: 'assets/create_event/meet.png',
                        title: '모임',
                        onPressed: () {
                          context.read<CreateEventImproveProvider>().selectCategoryChange(3);
                        }
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CreateEventSelectTab(
                        checkState: selectState == 4,
                        iconPath: 'assets/create_event/business.png',
                        title: '비즈니스',
                        onPressed: () {
                          context.read<CreateEventImproveProvider>().selectCategoryChange(4);
                        }
                    ),
                  ),
                  SizedBox(width: 13.0.w),
                  const Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                ],
              ),

              // Container(
              //   width: double.infinity,
              //   height: 80,
              //   color: StaticColor.mainSoft,
              // ),
            ],
          ),
        );
      }
    );
  }
}

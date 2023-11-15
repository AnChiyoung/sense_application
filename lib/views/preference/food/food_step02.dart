import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/selectable_preference_element.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep02 extends StatefulWidget {
  const FoodStep02({super.key});

  @override
  State<FoodStep02> createState() => _FoodStep02State();
}

class _FoodStep02State extends State<FoodStep02> {
  late Future<List<PreferenceFoodModel>> loadFoodElementList;

  @override
  void initState() {
    super.initState();

    loadFoodElementList = PreferenceRepository().getPreferenceFoodList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadFoodElementList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('데이터를 불러오는데 실패했습니다.'));
        }

        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
            child: Column(
              children: [
                const ContentDescription(
                  presentPage: 2,
                  totalPage: 7,
                  description: '선호하는 음식의 종류를\n순서대로 선택해 주세요',
                ),
                SizedBox(height: 24.0.h),
                Selector<PreferenceProvider, List<int>>(
                  selector: (context, value) => value.foodList,
                  builder: (context, data, child) {
                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0.w,
                      runSpacing: 24.0.h,
                      children: snapshot.data!.map(
                        (foodElement) {
                          bool isSelected = data.contains(foodElement.id);
                          int selectedNumber = data.indexOf(foodElement.id);

                          return SelectablePreferenceElement(
                            title: foodElement.title,
                            imageUrl: foodElement.imageUrl,
                            isSelected: isSelected,
                            onTap: () => context.read<PreferenceProvider>().selectFoodElement(
                                  foodElement.id,
                                  notify: true,
                                ),
                            selectedNumber: selectedNumber,
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/selectable_preference_taste.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep03 extends StatefulWidget {
  const FoodStep03({super.key});

  @override
  State<FoodStep03> createState() => _FoodStep03State();
}

class _FoodStep03State extends State<FoodStep03> {
  late Future<List<PreferenceTasteModel>> loadTasteSpicyElementList;

  @override
  void initState() {
    super.initState();

    loadTasteSpicyElementList = PreferenceRepository().getPreferenceTasteSpicyList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadTasteSpicyElementList,
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
                  presentPage: 3,
                  totalPage: 7,
                  description: '선호하는 매운맛의\n수준을 선택해 주세요',
                ),
                SizedBox(height: 24.0.h),
                Selector<PreferenceProvider, List<int>>(
                  selector: (context, value) => value.spicyList,
                  builder: (context, data, child) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!.reversed.map(
                            (tasteItem) {
                              int level = ((5 - tasteItem.id) % 5) + 1;
                              return SelectablePreferenceTaste(
                                onTap: () => context
                                    .read<PreferenceProvider>()
                                    .onTapSpicy(level, notify: true),
                                title: tasteItem.title,
                                subtitle: tasteItem.subtitle,
                                level: level,
                                imageUrl: tasteItem.imageUrl,
                                assetPath: 'assets/preference/spicy_on.png',
                                isSelected: data.contains(level),
                              );
                            },
                          ).toList(),
                        ),
                      ),
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

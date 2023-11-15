import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/selectable_preference_taste.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep04 extends StatefulWidget {
  const FoodStep04({super.key});

  @override
  State<FoodStep04> createState() => _FoodStep04State();
}

class _FoodStep04State extends State<FoodStep04> {
  late Future<List<PreferenceTasteModel>> loadTasteSweetElementList;

  @override
  void initState() {
    super.initState();

    loadTasteSweetElementList = PreferenceRepository().getPreferenceTasteSweetList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadTasteSweetElementList,
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
                  presentPage: 4,
                  totalPage: 7,
                  description: '선호하는 단맛의\n수준을 선택해 주세요',
                ),
                SizedBox(height: 24.0.h),
                Selector<PreferenceProvider, List<int>>(
                  selector: (context, value) => value.sweetList,
                  builder: (context, data, child) {
                    void onTap(int id) {
                      context.read<PreferenceProvider>().onTapSweet(id, notify: true);
                    }

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!.reversed
                              .map(
                                (e) => SelectablePreferenceTaste(
                                  onTap: () => onTap(e.id),
                                  title: e.title,
                                  subtitle: e.subtitle,
                                  level: ((5 - e.id) % 5) + 1,
                                  imageUrl: e.imageUrl,
                                  assetPath: 'assets/preference/sweet_on.png',
                                  isSelected: data.contains(e.id),
                                ),
                              )
                              .toList(),
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

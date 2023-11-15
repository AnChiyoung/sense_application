import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/selectable_preference_element.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class TravelStep04 extends StatefulWidget {
  const TravelStep04({super.key});

  @override
  State<TravelStep04> createState() => _TravelStep04State();
}

class _TravelStep04State extends State<TravelStep04> {
  late Future<List<PreferenceTravelModel>> loadTravelElementList;

  @override
  void initState() {
    super.initState();

    loadTravelElementList = PreferenceRepository().getPreferenceTravelMateList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadTravelElementList,
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
                  totalPage: 6,
                  description: '함께하고 싶은\n지인을 알려주세요',
                ),
                SizedBox(height: 24.0.h),
                Selector<PreferenceProvider, List<int>>(
                  selector: (context, value) => value.travelMateList,
                  builder: (context, data, child) {
                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0.w,
                      runSpacing: 24.0.h,
                      children: snapshot.data!.map(
                        (travelMate) {
                          bool isSelected = data.contains(travelMate.id);
                          int selectedNumber = data.indexOf(travelMate.id);

                          return SelectablePreferenceElement(
                            title: travelMate.title,
                            imageUrl: travelMate.imageUrl,
                            isSelected: isSelected,
                            onTap: () => context.read<PreferenceProvider>().onTapTravelMate(
                                  travelMate.id,
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

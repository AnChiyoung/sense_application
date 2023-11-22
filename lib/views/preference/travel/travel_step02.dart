import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_element_banner.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class TravelStep02 extends StatefulWidget {
  const TravelStep02({super.key});

  @override
  State<TravelStep02> createState() => _TravelStep02State();
}

class _TravelStep02State extends State<TravelStep02> {
  late Future<List<PreferenceTravelModel>> loadTravelElementList;

  @override
  void initState() {
    super.initState();

    loadTravelElementList = PreferenceRepository().getPreferenceTravelDistanceList();
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
                  presentPage: 2,
                  totalPage: 6,
                  description: '선호하는 여행지의\n거리 정도를 선택해 주세요',
                ),
                SizedBox(height: 24.0.h),
                Selector<PreferenceProvider, List<int>>(
                  selector: (context, value) => value.travelDistanceList,
                  builder: (context, data, child) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!.map(
                            (travelDistance) {
                              return PreferenceElementBanner(
                                onTap: () => context
                                    .read<PreferenceProvider>()
                                    .onTapTravelDistance(travelDistance.id, notify: true),
                                title: travelDistance.subtitle,
                                label: travelDistance.title,
                                imageUrl: travelDistance.imageUrl,
                                isSelected: data.contains(travelDistance.id),
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

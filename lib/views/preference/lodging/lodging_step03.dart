import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/selectable_preference_element.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class LodgingStep03 extends StatefulWidget {
  const LodgingStep03({super.key});

  @override
  State<LodgingStep03> createState() => _LodgingStep03State();
}

class _LodgingStep03State extends State<LodgingStep03> {
  late Future<List<PreferenceLodgingModel>> loadLodgingElementList;

  @override
  void initState() {
    super.initState();

    loadLodgingElementList = PreferenceRepository().getPreferenceLodgingEnvironmentList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadLodgingElementList,
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
                  totalPage: 6,
                  description: '선호하는 숙소 주변 환경을\n순서대로 선택해 주세요',
                ),
                SizedBox(height: 24.0.h),
                Selector<PreferenceProvider, List<int>>(
                  selector: (context, value) => value.lodgingEnvironmentList,
                  builder: (context, data, child) {
                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0.w,
                      runSpacing: 24.0.h,
                      children: snapshot.data!.map(
                        (lodgingEnvironment) {
                          bool isSelected = data.contains(lodgingEnvironment.id);
                          int selectedNumber = data.indexOf(lodgingEnvironment.id);

                          return SelectablePreferenceElement(
                            title: lodgingEnvironment.title,
                            imageUrl: lodgingEnvironment.imageUrl,
                            isSelected: isSelected,
                            onTap: () => context.read<PreferenceProvider>().onTapLodgingEnvironment(
                                  lodgingEnvironment.id,
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

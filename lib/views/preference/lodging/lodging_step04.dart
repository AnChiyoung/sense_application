import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/selectable_preference_element.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class LodgingStep04 extends StatefulWidget {
  const LodgingStep04({super.key});

  @override
  State<LodgingStep04> createState() => _LodgingStep04State();
}

class _LodgingStep04State extends State<LodgingStep04> {
  late Future<List<PreferenceLodgingModel>> loadLodgingElementList;

  @override
  void initState() {
    super.initState();

    loadLodgingElementList = PreferenceRepository().getPreferenceLodgingOptionList();
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
                  presentPage: 4,
                  totalPage: 6,
                  description: '숙소에 꼭 필요한 비품을\n순서대로 선택해 주세요',
                ),
                SizedBox(height: 24.0.h),
                Selector<PreferenceProvider, List<int>>(
                  selector: (context, value) => value.lodgingOptionList,
                  builder: (context, data, child) {
                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0.w,
                      runSpacing: 24.0.h,
                      children: snapshot.data!.map(
                        (lodgingOption) {
                          bool isSelected = data.contains(lodgingOption.id);
                          int selectedNumber = data.indexOf(lodgingOption.id);

                          return SelectablePreferenceElement(
                            title: lodgingOption.title,
                            imageUrl: lodgingOption.imageUrl,
                            isSelected: isSelected,
                            onTap: () => context.read<PreferenceProvider>().onTapLodgingOption(
                                  lodgingOption.id,
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

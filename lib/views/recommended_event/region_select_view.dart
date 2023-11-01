import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/add_event_model.dart';
import 'package:sense_flutter_application/models/recommended_event/region_select_model.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';

class RegionSelectHeaderMenu extends StatefulWidget {
  const RegionSelectHeaderMenu({Key? key}) : super(key: key);

  @override
  State<RegionSelectHeaderMenu> createState() => _RegionSelectHeaderMenuState();
}

class _RegionSelectHeaderMenuState extends State<RegionSelectHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', closeCallback: closeCallback);
  }

  void backCallback() {
    Navigator.of(context).pop();
    context.read<RecommendedEventProvider>().regionNextButtonReset();
  }

  void closeCallback() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AddEventCancelDialog();
        });
  }
}

class RegionSelectTitle extends StatelessWidget {
  const RegionSelectTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('지역을\n선택해 주세요', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
          ],
        )
    );
  }
}

class RegionSelectCategory extends StatefulWidget {
  const RegionSelectCategory({Key? key}) : super(key: key);

  @override
  State<RegionSelectCategory> createState() => _RegionSelectCategoryState();
}

class _RegionSelectCategoryState extends State<RegionSelectCategory> {

  late List<RegionModel> regionModel;
  late List<Widget> regionList;
  int? selectRegion;
  List<bool> state = [];

  @override
  void initState() {
    regionModel = regionDummyModel.map((e) => RegionModel.fromJson(e)).toList();
    regionClickReset();
    state[0] = true;
    super.initState();
  }

  void regionClickReset() {
    state.clear();
    for(int i = 0; i < regionModel.length; i++) {
      state.add(false);
    }
  }

  List<Widget> regionSet(List<RegionModel> model) {
    return model.map((e) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                AddEventModel.regionModel.clear();
                regionClickReset();
                state[model.indexOf(e)] = true;
                context.read<RecommendedEventProvider>().regionSelectStateChange(model.indexOf(e));
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 36,
              decoration: BoxDecoration(
                color: state.elementAt(model.indexOf(e)) == true ? StaticColor.regionBoxSelectColor : StaticColor.regionBoxNonSelectColor,
                // color: Colors.black,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Center(child: Text(e.regionList, style: TextStyle(fontSize: 14, color: state.elementAt(model.indexOf(e)) == true ? Colors.white : StaticColor.regionBoxTextColor, fontWeight: FontWeight.w500))),
            ),
          ),
          model.indexOf(e) == model.length - 1 ? const SizedBox() : const SizedBox(width: 6)
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    regionList = regionSet(regionModel);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: regionList,
        )
      ),
    );
    // return Container();
  }
}

class RegionSelectSubCategory extends StatefulWidget {
  const RegionSelectSubCategory({Key? key}) : super(key: key);

  @override
  State<RegionSelectSubCategory> createState() => _RegionSelectSubCategoryState();
}

class _RegionSelectSubCategoryState extends State<RegionSelectSubCategory> {

  late List<RegionModel> regionModel;
  List<Widget> subRegionRowList = [];
  List<Widget> subRegionRow = [];
  List<List<bool>> regionCheckState = [];
  int lastIndex = -1;
  int presentIndex = -1;

  @override
  void initState() {
    regionModel = regionDummyModel.map((e) => RegionModel.fromJson(e)).toList();
    // regionCheckState.clear();
    super.initState();
  }

  void allStateChange(bool state) {
    for(int i = 1; i < regionCheckState.length; i++) {
      for(int j = 0; j < regionCheckState[i].length; j++) {
        regionCheckState[i][j] = state;
      }
    }
  }

  bool containFalseCheck() {
    bool result = false;
    for(int i = 1; i < regionCheckState.length; i++) {
      for(int j = 0; j < regionCheckState[i].length; j++) {
        if(regionCheckState[i][j] == false) {
          result = true;
        }
      }
    }
    return result;
  }

  bool containTrueCheck() {
    bool result = false;
    for(int i = 1; i < regionCheckState.length; i++) {
      for(int j = 0; j < regionCheckState[i].length; j++) {
        if(regionCheckState[i][j] == true) {
          result = true;
        }
      }
    }
    return result;
  }

  List subRegionListWidget(List<Set<String>> model) {
    return model.map((e) { // e => Set<String>
      if(regionCheckState.length <= model.length - 1) {
        regionCheckState.add(<bool>[]);
      }
      subRegionRow = subRegionRowWidget(e, model.indexOf(e)) as List<Widget>;
      return Column(
        children: [
          Row(
            children: subRegionRow
          ),
          model.indexOf(e) == model.length - 1 ? const SizedBox() : const SizedBox(height: 12),
        ],
      );
    }).toList();
  }

  void listReset(int e) {
    /// 위 가로 슬라이드 지역셀이 변경되면 아래는 초기화되도록 변경
    if(lastIndex != presentIndex) {
      subRegionRowList.clear();
      subRegionRow.clear();
      regionCheckState.clear();
      lastIndex = presentIndex;
    }
    subRegionRowList = subRegionListWidget(regionModel.elementAt(e).subRegionList) as List<Widget>;
  }

  List subRegionRowWidget(Set<String> model, int rowIndex) {
    return model.map((e) { // e => String
      if(regionCheckState[rowIndex].length <= model.length - 1) {
        regionCheckState[rowIndex].add(false);
      }
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                regionCheckState[rowIndex][model.toList().indexOf(e)] = !regionCheckState[rowIndex][model.toList().indexOf(e)];
                if(rowIndex == 0) {
                  allStateChange(regionCheckState[rowIndex][0]);
                } else {
                  containFalseCheck() == true ? regionCheckState[0][0] = false : regionCheckState[0][0] = true;
                }
                containTrueCheck() == true ? context.read<RecommendedEventProvider>().regionNextButtonState(true) : context.read<RecommendedEventProvider>().regionNextButtonState(false);

                /// region model add
                regionCheckState[rowIndex][model.toList().indexOf(e)] == true ? (AddEventModel.regionModel.contains(e) ? {} : AddEventModel.regionModel.add(e)) : (AddEventModel.regionModel.contains(e) ? AddEventModel.regionModel.remove(e) : {});
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: regionCheckState[rowIndex][model.toList().indexOf(e)] == true ? StaticColor.subRegionBoxSelectColor : StaticColor.subRegionBoxNonSelectColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(e, style: TextStyle(fontSize: 14, color: regionCheckState[rowIndex][model.toList().indexOf(e)] == true ? Colors.white : StaticColor.subRegionBoxTextColor, fontWeight: FontWeight.w400)),
            ),
          ),
          model.toList().indexOf(e) == model.length - 1 ? const SizedBox() : const SizedBox(width: 8)
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    final stateNumber = context.watch<RecommendedEventProvider>().regionSelectState;
    presentIndex = stateNumber;

    if(stateNumber != -1) {
      // subRegionRowList = subRegionListWidget(regionModel.elementAt(stateNumber).subRegionList) as List<Widget>;
      listReset(stateNumber);
    }
    /// 초기 진입 시, 서울 선택이 디폴트
    else if(stateNumber == -1) {
      listReset(0);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
      /// 아래 주석 줄은 초기 진입 시 빈 컨테이너 노출
      // child: stateNumber == -1 ? Container() : Column(
      child: Column(
        children: subRegionRowList,
      )
    );
  }
}

class RegionSelectNextButton extends StatefulWidget {
  const RegionSelectNextButton({Key? key}) : super(key: key);

  @override
  State<RegionSelectNextButton> createState() => _RegionSelectNextButtonState();
}

class _RegionSelectNextButtonState extends State<RegionSelectNextButton> {

  Future backButtonAction(BuildContext context) async {
    context.read<RecommendedEventProvider>().nextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    final buttonEnabled = context.watch<RecommendedEventProvider>().regionNextButton;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () {
              // buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => PresentMemoScreen())) : (){};
            },
            style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled == true ? StaticColor.categorySelectedColor : StaticColor.unSelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 56, child: Center(child: Text('다음', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)))),
                ]
            )
        ),
      ),
    );
  }
}

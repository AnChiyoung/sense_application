import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class RecommendedTitle extends StatefulWidget {
  const RecommendedTitle({Key? key}) : super(key: key);

  @override
  State<RecommendedTitle> createState() => _RecommendedTitleState();
}

class _RecommendedTitleState extends State<RecommendedTitle> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '추천', rightMenu: menu());
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  Widget menu() {
    return GestureDetector(
        onTap: () {
        },
        child: Image.asset('assets/recommended_event/menu.png', width: 24, height: 24)
    );
  }
}

class RecommendedTagSection extends StatefulWidget {
  const RecommendedTagSection({Key? key}) : super(key: key);

  @override
  State<RecommendedTagSection> createState() => _RecommendedTagSectionState();
}

class _RecommendedTagSectionState extends State<RecommendedTagSection> {

  List<Widget> categoryListWidget = [];
  List<bool> categorySelectList = [];


  void createCategory() {
    categoryListWidget = AddEventModel.eventRecommendedModel.map((e) {
      categorySelectList.add(false);
      return Row(
        children: [
          e.isEmpty ? Container() : GestureDetector(
              onTap: () {
                setState(() {
                  for(int i = 0; i < categorySelectList.length; i++) {
                    categorySelectList[i] = false;
                  }
                  categorySelectList[AddEventModel.eventRecommendedModel.indexOf(e)] = true;
                });
                print(categorySelectList);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                height: 36,
                decoration: BoxDecoration(
                  color: categorySelectList[AddEventModel.eventRecommendedModel.indexOf(e)] == true ? StaticColor.recommendedCategorySelectColor : StaticColor.recommendedCategoryNonSelectColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(e, style: TextStyle(fontSize: 14, color: categorySelectList[AddEventModel.eventRecommendedModel.indexOf(e)] == true ? Colors.white : StaticColor.recommendedCategoryNonSelectTextColor, fontWeight: FontWeight.w500)),
              )
          ),
          AddEventModel.eventRecommendedModel.indexOf(e) == e.length - 1 || AddEventModel.eventRecommendedModel[AddEventModel.eventRecommendedModel.indexOf(e)] == '' ? const SizedBox() : const SizedBox(width: 4),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    createCategory();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
      child: Row(
        children: categoryListWidget,
      ),
    );
  }
}

class RecommendedItemSection extends StatefulWidget {
  const RecommendedItemSection({Key? key}) : super(key: key);

  @override
  State<RecommendedItemSection> createState() => _RecommendedItemSectionState();
}

class _RecommendedItemSectionState extends State<RecommendedItemSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 250),
              Image.asset('assets/recommended_event/searching.png', width: 40, height: 40),
              SizedBox(height: 24),
              Text('플래너가 추천 할 상품을 찾는 중이예요.', style: TextStyle(fontSize: 14, color: StaticColor.recommendedSearchingTextColor, fontWeight: FontWeight.w700)),
            ],
          ),
        )
      ),
    );
  }
}

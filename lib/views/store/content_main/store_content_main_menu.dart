import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/store/store_model.dart';
import 'package:sense_flutter_application/screens/store/store_detail_screen.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';

class StoreContentMainMenu extends StatefulWidget {
  const StoreContentMainMenu({super.key});

  @override
  State<StoreContentMainMenu> createState() => _StoreContentMainMenuState();
}

class _StoreContentMainMenuState extends State<StoreContentMainMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 16.0.h, bottom: 24.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('필요한 것만 골라보세요', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w700),),
          ),
          SizedBox(height: 16.0.h),
          Consumer<StoreProvider>(
            builder: (context, data, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/present.png', '선물', data.storeMenuSelector.elementAt(0), 0),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/hotel.png', '호텔', data.storeMenuSelector.elementAt(1), 1),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/lunch.png', '점심', data.storeMenuSelector.elementAt(2), 2),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/dinner.png', '저녁', data.storeMenuSelector.elementAt(3), 3),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/activity.png', '액티비티', data.storeMenuSelector.elementAt(4), 4),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/pub.png', '술집', data.storeMenuSelector.elementAt(5), 5),
                      ),
                    ],
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }

  /// icon position 개선 필요
  Widget menuItem(String imagePath, String menuName, bool checkState, int index) {
    return AspectRatio(
      aspectRatio: 104 / 88,
      child: ElevatedButton(
        onPressed: () {
          /// 선택된 아이템이 하나일 때는, 선택 해제할 수 없음.
          int trueCount = context.read<StoreProvider>().storeMenuSelector.where((e) => true == e).length;

          if(trueCount == 1) {
            if(checkState == true) {
              return ;
            } else if(checkState == false) {
              context.read<StoreProvider>().recommendCategoryValueChange(!checkState, index);
            }
          } else {
            context.read<StoreProvider>().recommendCategoryValueChange(!checkState, index);
          }
        },
        style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: checkState == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(imagePath, color: checkState == true ? Colors.white : StaticColor.grey80033, width: 33.0.w, height: 35.0.h),
              SizedBox(height: 8.0.h),
              Text(menuName, style: TextStyle(fontSize: 14.0.sp, color: checkState == true ? Colors.white : StaticColor.grey80033, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}

class StoreContentMainProduct extends StatefulWidget {
  const StoreContentMainProduct({super.key});

  @override
  State<StoreContentMainProduct> createState() => _StoreContentMainProductState();
}

class _StoreContentMainProductState extends State<StoreContentMainProduct> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StoreRequest().productListRequest(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.connectionState == ConnectionState.done) {

            List<ProductModel> loadProductModels = snapshot.data ?? [];
            SenseLogger().debug(loadProductModels.toString());

            return ProductWidgets(models: loadProductModels);

          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        } else if(snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}

class ProductWidgets extends StatefulWidget {
  List<ProductModel> models;
  ProductWidgets({super.key, required this.models});

  @override
  State<ProductWidgets> createState() => _ProductWidgetsState();
}

class _ProductWidgetsState extends State<ProductWidgets> {
  late List<ProductModel> models;
  String? imageUrl;
  String? discountRate;
  String? discountPrice;
  String? title;
  String? brandTitle;

  @override
  void initState() {
    models = widget.models;
    super.initState();
  }

  @override
  void productDataInit(ProductModel model) {
    if(model.imageUrl!.isEmpty || model.imageUrl == null) {
      imageUrl = "";
    } else {
      imageUrl = model.imageUrl;
    }

    if(model.discountRate!.isEmpty) {
      discountRate = "";
    } else {
      discountRate = "${model.discountRate}%";
    }

    if(model.discountPrice!.isEmpty || model.discountPrice == null) {
      discountPrice = "가격 없음";
    } else {
      int parseNumber = double.parse(model.discountPrice!).toInt();
      var f = NumberFormat('###,###,###,###');
      discountPrice = '${f.format(parseNumber)}원';
    }

    if(model.title!.isEmpty || model.title == null) {
      title = "-";
    } else {
      title = model.title;
    }

    if(model.brandTitle!.isEmpty || model.brandTitle == null) {
      brandTitle = "브랜드 미상";
    } else {
      brandTitle = model.brandTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: GridView.builder(
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 1.0 / 1.4,
                // childAspectRatio: 1 / 1,
              ),
              itemCount: models.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                productDataInit(models.elementAt(index));

                index == 1 ? discountRate = "70%" : {};

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(productId: models.elementAt(index).id!)));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        imageUrl!.isEmpty ? const SizedBox.shrink() : ProductImage(imageUrl: imageUrl!),
                        SizedBox(height: 8.0.h),
                        Row(
                          children: [
                            _discountRate(discountRate!),
                            discountRate!.isEmpty ? const SizedBox.shrink() : SizedBox(width: 4.0.w),
                            _discountPrice(discountPrice!),
                          ],
                        ),
                        SizedBox(height: 4.0.h),
                        _title(title!),
                        brandTitle!.isEmpty ? const SizedBox.shrink() : SizedBox(height: 4.0.h),
                        _brandTitle(brandTitle!),
                      ],
                    ),
                  ),
                );
              }
          ),
        )
    );
  }

  Widget _discountRate(String discountRate) {
    return Text(discountRate, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w700));
  }

  Widget _discountPrice(String discountPrice) {
    return Text(discountPrice, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w700));
  }

  Widget _title(String title) {
    return Text(title, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400));
  }

  Widget _brandTitle(String brandTitle) {
    return Text(brandTitle, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400));
  }
}

class ProductImage extends StatefulWidget {
  String imageUrl;
  ProductImage({super.key, required this.imageUrl});

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: CachedNetworkImage(
        width: double.infinity,
        imageUrl: widget.imageUrl,
        fit: BoxFit.fitHeight,
        // imageBuilder: (context, imageProvider) => Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12.0),
        //     image: DecorationImage(
        //         image: imageProvider, fit: BoxFit.fill),
        //   ),
        // ),
        placeholder: (context, url) => Center(child: Image.asset('assets/public/loading_logo_image.png', width: 70.0.w)),
        errorWidget: (context, url, error) => Center(child: Container(width: double.infinity, height: double.infinity, child: const Text("상품 이미지가 없습니다."))), // 디자인 필요
      ),
    );
  }
}
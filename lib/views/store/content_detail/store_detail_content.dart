import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/store/store_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class StoreDetailHeader extends StatefulWidget {
  const StoreDetailHeader({super.key});

  @override
  State<StoreDetailHeader> createState() => _StoreDetailHeaderState();
}

class _StoreDetailHeaderState extends State<StoreDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, isThin: true, title: "", rightMenu: shareMenu());
  }

  void backCallback() {
    Navigator.pop(context);
  }

  Widget shareMenu() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.0.w,
        height: 40.0.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (_) => MyPageScreen()));
          },
          child: Center(
              child: Image.asset('assets/store/share_button.png', width: 24.0.w, height: 24.0.h)),
        ),
      ),
    );
  }
}

class StoreDetailContent extends StatefulWidget {
  int productId;
  StoreDetailContent({super.key, required this.productId});

  @override
  State<StoreDetailContent> createState() => _StoreDetailContentState();
}

class _StoreDetailContentState extends State<StoreDetailContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: StoreRequest().productRequest(widget.productId),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(snapshot.connectionState == ConnectionState.done) {

                ProductModel loadProductModel = snapshot.data ?? ProductModel();
                SenseLogger().debug(loadProductModel.toString());

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImage(imageUrl: loadProductModel.imageUrl!),
                    SizedBox(height: 20.0.h),
                    ProductMetaInfo(model: loadProductModel),
                    Container(
                      width: double.infinity,
                      height: 8.0.h,
                      color: StaticColor.grey100F6,
                    ),
                    ProductBasicInfo(),
                  ],
                );
                // return ProductWidgets(models: loadProductModels);

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
      ),
    );
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
    return widget.imageUrl.isNotEmpty ? CachedNetworkImage(
      imageUrl: widget.imageUrl,
      // imageBuilder: (context, imageProvider) => Container(
      //   width: double.infinity,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(12.0),
      //     image: DecorationImage(
      //         image: imageProvider, fit: BoxFit.cover),
      //   ),
      // ),
      // placeholder: (context, url) => Container(width: 30, height: 30, color: Colors.green),
      // errorWidget: (context, url, error) => const Center(child: Text("상품 이미지가 없습니다.")), // 디자인 필요
    ) : Container(width: double.infinity, height: 300.0.h, child: Center(child: Text("상품 이미지가 없습니다")));
  }
}

class ProductMetaInfo extends StatefulWidget {
  ProductModel model;
  ProductMetaInfo({super.key, required this.model});

  @override
  State<ProductMetaInfo> createState() => _ProductMetaInfoState();
}

class _ProductMetaInfoState extends State<ProductMetaInfo> {

  late ProductModel model;
  String title = '';
  String brandTitle = '';
  String originalPrice = '';
  String discountRate = '';
  String discountPrice = '';

  @override
  void initState() {
    model = widget.model;
    dataInit();
    super.initState();
  }

  void dataInit() {

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
      title = model.title!;
    }

    if(model.brandTitle!.isEmpty || model.brandTitle == null) {
      brandTitle = "브랜드 미상";
    } else {
      brandTitle = model.brandTitle!;
    }

    if(model.originPrice!.isEmpty || model.originPrice == null) {
      originalPrice = "";
    } else {
      int parseNumber = double.parse(model.originPrice!).toInt();
      var f = NumberFormat('###,###,###,###');
      originalPrice = '${f.format(parseNumber)}원';
    }

    print(discountPrice);

    discountPrice == "123원" ? discountRate = "70%" : {};
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(brandTitle, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
          SizedBox(height: 2.0.h),
          Text(title, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          SizedBox(height: 4.0.h),
          discountRate.isNotEmpty ? Text(originalPrice, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey60077, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough)) : const SizedBox.shrink(),
          SizedBox(height: 4.0.h),
          discountRate.isNotEmpty ? Row(
            children: [
              Text(discountRate, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.dateLabelColor, fontWeight: FontWeight.w500)),
              SizedBox(width: 8.0.w),
              Text(discountPrice, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w500)),
            ],
          ) : Text(originalPrice, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class ProductBasicInfo extends StatefulWidget {
  const ProductBasicInfo({super.key});

  @override
  State<ProductBasicInfo> createState() => _ProductBasicInfoState();
}

class _ProductBasicInfoState extends State<ProductBasicInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          color: Colors.white,
          child: Center(
            child: Text("기본정보", style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
          )
        )
      ],
    );
  }
}

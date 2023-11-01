import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/store/content_detail/store_detail_content.dart';
import 'package:sense_flutter_application/views/store/content_detail/store_detail_like.dart';

class StoreDetailScreen extends StatefulWidget {
  int productId;
  StoreDetailScreen({super.key, required this.productId});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        top: true,
        bottom: true,
        topColor: Colors.white,
        bottomColor: StaticColor.grey200EE,
        child: Stack(
          children: [
            Column(
              children: [
                const StoreDetailHeader(),
                Expanded(
                  child: StoreDetailContent(productId: widget.productId),
                ),
              ],
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height - 150.0,
              bottom: 0.0,
              child: const StoreDetailLike(),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/store/content_main/store_detail_content.dart';

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
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            StoreDetailHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: StoreDetailContent(productId: widget.productId))
            ),
          ],
        ),
      ),
    );
  }
}

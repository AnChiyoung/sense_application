import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';

class StoreDetailLike extends StatefulWidget {
  const StoreDetailLike({super.key});

  @override
  State<StoreDetailLike> createState() => _StoreDetailLikeState();
}

class _StoreDetailLikeState extends State<StoreDetailLike> {

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<StoreProvider>().isLikedChange(!isLiked);
        },
        child: Container(
          width: double.infinity,
          color: StaticColor.grey200EE,
          child: Center(
            child: Consumer<StoreProvider>(
              builder: (context, data, child) {

                isLiked = data.isLiked;

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: ((child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  }),
                  child: !isLiked
                      ? Image.asset('assets/store/product_like_button.png', width: 24.0.w, height: 24.0.h, key: const ValueKey('UNLIKE'))
                      : Image.asset('assets/store/product_like_button.png', width: 24.0.w, height: 24.0.h, color: Colors.red, key: const ValueKey('LIKE'))
                );
              }
            )
          )
        ),
      ),
    );
  }
}

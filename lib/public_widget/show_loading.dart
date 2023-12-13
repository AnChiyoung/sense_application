import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading {
  void showLoading(
      Widget showWidget, BuildContext context, AnimationController controller, Stream? stream) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Transform.scale(
          scale: 0.5,
          child: Lottie.asset(
            'assets/lottie/loading.json',
            repeat: false,
            reverse: false,
            animate: true,
            controller: controller,
            onLoaded: (composition) {
              controller
                ..duration = composition.duration
                ..forward().whenComplete(
                  () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => showWidget));
                  },
                );
            },
          ),
        );
      },
    );
  }
}

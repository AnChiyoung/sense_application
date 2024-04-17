import 'package:flutter/material.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class CustomToast {
  static const _toastDuration = Duration(seconds: 3);
  static OverlayEntry? _overlayEntry;

  static errorToast(BuildContext context, String message, {double? bottom}) {
    print('toast errorr');
    showToast(
      context,
      Row(
        children: [
          Icon(Icons.error, color: errorColor[0]),
          const SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(color: errorColor[0]),
          ),
        ],
      ),
      bottom: bottom,
      backgroundColor: Colors.white,
      border: Border.all(color: errorColor[0] ?? Colors.red),
    );
  }

  static warningToast(BuildContext context, String message) {
    showToast(
      context,
      Row(
        children: [
          Icon(Icons.error, color: warningColor[0]),
          const SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(color: warningColor[0]),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      border: Border.all(color: warningColor[0] ?? Colors.yellow),
    );
  }

  static successToast(BuildContext context, String message, {double? bottom}) {
    showToast(
      context,
      Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0XFF56EBFF)),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(color: Color(0XFF56EBFF)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      border: Border.all(color: const Color(0xFF56EBFF)),
      bottom: bottom,
    );
  }

  static void showToast(BuildContext context, Widget child,
      {
      // Background color of the toast
      Color backgroundColor = Colors.black,
      // Parameters for positioning the toast
      double? top,
      double? bottom = 50.0,
      double? right = 20.0,
      double? left = 20.0,
      Border border = const Border(),
      double radius = 0}) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (ctx) => Positioned(
        bottom: bottom,
        left: left,
        right: right,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
                boxShadow: List.of([
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.14),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ]),
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
                border: border),
            child: child,
          ),
        ),
      ),
    );

    // Insert the overlay entry into the Overlay
    Overlay.of(context).insert(_overlayEntry!);
    Future.delayed(_toastDuration).then((value) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
      _overlayEntry = null;
    });
  }
}

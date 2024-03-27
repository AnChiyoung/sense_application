import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class CustomModal extends StatefulWidget{
  static OverlayEntry? _overlayEntry;

  const CustomModal({super.key});

  
  @override
  State<StatefulWidget> createState() => _CustomModalState();

  static void showModal(
    BuildContext context,
    {
      // Background color of the toast
      Color backgroundColor = Colors.black,
      // Parameters for positioning the toast
      double ?top,
      double ?bottom =0,
      double ?right = 0,
      double ?left = 0,
      Border border = const Border(),
      double radius = 0
    }
  ) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (ctx) => Positioned(
        bottom: bottom,
        left: left,
        right: right,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: List.of([
                const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.14),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                )
              ]),
              color: const Color.fromRGBO(21, 21, 21, 0.60),
              borderRadius: BorderRadius.circular(radius),
              border: border
            ),
            child: ModalFrame(
              callback: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
}

class _CustomModalState extends State<CustomModal> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ModalFrame extends StatelessWidget {
  final Color backgroundColor;
  final Border border;
  final double radius;
  final Function callback;


  const ModalFrame({
    super.key,
    this.backgroundColor = Colors.white,
    this.border = const Border(),
    this.radius = 0,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            width: double.infinity,
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
            border: border
          ),
          child: Column(
            children: [
              const Text(
                'Modal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '비밀번호가 정상적으로 변경되었어요.'
                '변경된 비밀번호로 로그인을 시도해 주세요!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: 
                  CustomButton(
                    backgroundColor: primaryColor[50] ?? Colors.transparent,
                    textColor: Colors.white,
                    labelText: 'Close Modal',
                    onPressed: () {
                      callback();
                    },
                  )
              ),
          ],
        ),
      )
      ],)
    );
  }
}

import 'package:flutter/material.dart';
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
      title,
      message,
      buttonLabel,
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
              modalTitle: title,
              modalMessage: message,
              modalButtonLabel: buttonLabel ?? '',
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
  final String modalTitle;
  final String modalMessage;
  final String modalButtonLabel;


  const ModalFrame({
    super.key,
    this.backgroundColor = Colors.white,
    this.border = const Border(),
    this.radius = 0,
    required this.modalTitle,
    required this.modalMessage,
    this.modalButtonLabel = '확인',
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
              Text(
                // Modal Title
                modalTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                // Modal Message
                modalMessage,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: 
                  // Modal Button Label
                  CustomButton(
                    backgroundColor: primaryColor[50] ?? Colors.transparent,
                    textColor: Colors.white,
                    labelText: modalButtonLabel,
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

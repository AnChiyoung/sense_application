import 'package:flutter/material.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/modals/report_modal.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class CustomModal extends StatefulWidget {
  static OverlayEntry? _overlayEntry;

  const CustomModal({super.key});

  @override
  State<StatefulWidget> createState() => _CustomModalState();

  static void closeModal() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  static void showModal(BuildContext context,
      {
      // Background color of the toast
      Color backgroundColor = Colors.black,
      title,
      message,
      buttonLabel,
      // Parameters for positioning the toast
      double? top,
      double? bottom = 0,
      double? right = 0,
      double? left = 0,
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
                color: const Color.fromRGBO(21, 21, 21, 0.70),
                borderRadius: BorderRadius.circular(radius),
                border: border),
            child: ModalFrame(
              modalTitle: title,
              modalMessage: message,
              modalButtonLabel: buttonLabel ?? '',
              callback: (value) {
                _overlayEntry?.remove();
                _overlayEntry?.dispose();
                _overlayEntry = null;
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void showConfirmModal(BuildContext context,
      {
      // Background color of the toast
      Color backgroundColor = Colors.black,
      title,
      message,
      buttonLabel,

      // Parameters for positioning the toast
      double? top,
      double? bottom = 0,
      double? right = 0,
      double? left = 0,
      Border border = const Border(),
      double radius = 0,
      required Null Function(bool) callback}) {
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
                color: const Color.fromRGBO(21, 21, 21, 0.70),
                borderRadius: BorderRadius.circular(radius),
                border: border),
            child: ModalFrame(
              isConfirm: true,
              modalTitle: title,
              modalButtonLabel: buttonLabel ?? '',
              callback: (isConfirm) {
                callback(isConfirm ?? false);
                _overlayEntry?.remove();
                _overlayEntry?.dispose();
                _overlayEntry = null;
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void showWidgetModal(
    BuildContext context, {
    // Background color of the toast
    Color backgroundColor = Colors.black,
    title,
    message,
    buttonLabel,

    // Parameters for positioning the toast
    double? top,
    double? bottom = 0,
    double? right = 0,
    double? left = 0,
    Border border = const Border(),
    double radius = 0,
    required Widget child,
  }) {
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
                color: const Color.fromRGBO(21, 21, 21, 0.70),
                borderRadius: BorderRadius.circular(radius),
                border: border),
            child: child,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static showBottomSheet(BuildContext context, List<Widget> Function(Function callback) callback) {
    showModalBottomSheet(
      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, maxHeight: 192),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 24, bottom: 35, left: 12, right: 12),
          child: Flex(
            direction: Axis.vertical,
            children: callback(() {
              Navigator.of(context).pop();
            }),
          ),
        );
      },
    );
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
  final Function(dynamic) callback;
  final String modalTitle;
  final String modalMessage;
  final String modalButtonLabel;
  final String modalCancelButtonLabel;
  final bool isConfirm;

  const ModalFrame(
      {super.key,
      this.isConfirm = false,
      this.backgroundColor = Colors.white,
      this.border = const Border(),
      this.radius = 0,
      required this.modalTitle,
      this.modalMessage = '',
      this.modalButtonLabel = '확인',
      this.modalCancelButtonLabel = 'Cancel',
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24, bottom: 16, left: 12, right: 12),
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
                  border: border),
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
                  if (modalMessage.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      // Modal Message
                      modalMessage,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  if (isConfirm)
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child:
                                  // Modal Button Label
                                  CustomButton(
                                backgroundColor: const Color(0xFFF6F6F6),
                                textColor: const Color(0XFF555555),
                                labelText: modalCancelButtonLabel,
                                onPressed: () {
                                  callback(false);
                                },
                              )),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child:
                                  // Modal Button Label
                                  CustomButton(
                                backgroundColor: primaryColor[50] ?? Colors.transparent,
                                textColor: Colors.white,
                                labelText: modalButtonLabel,
                                onPressed: () {
                                  callback(true);
                                },
                              )),
                        )
                      ],
                    ),
                  if (!isConfirm)
                    SizedBox(
                        width: double.infinity,
                        child:
                            // Modal Button Label
                            CustomButton(
                          backgroundColor: primaryColor[50] ?? Colors.transparent,
                          textColor: Colors.white,
                          labelText: modalButtonLabel,
                          onPressed: () {
                            callback(null);
                          },
                        ))
                ],
              ),
            )
          ],
        ));
  }
}

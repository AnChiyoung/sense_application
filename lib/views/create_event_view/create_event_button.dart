import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/event_create_finish_dialog.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class CreateEventButton extends StatefulWidget {
  const CreateEventButton({super.key});

  @override
  State<CreateEventButton> createState() => _CreateEventButtonState();
}

class _CreateEventButtonState extends State<CreateEventButton> {

  // late Future myFuture;
  //
  // Future<String> _fetchData() async {
  //   await Future.delayed(Duration(seconds: 10));
  //   return 'DATA';
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<CEProvider>(
        builder: (context, data, child) {
          bool buttonState = data.createEventButtonState;
          bool multipleListenerNonActive = false;

          return IgnorePointer(
            ignoring: multipleListenerNonActive,
            child: SizedBox(
              width: double.infinity,
              height: 70.h,
              child: ElevatedButton(
                  onPressed: () async {
                    if (buttonState == true) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return FutureBuilder(
                                future: EventRequest().eventCreateRequest(
                                    context),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Text(
                                          '이벤트를 생성하고 있습니다', style: TextStyle(
                                          fontSize: 14.0.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)));
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return const CreateEventFinishDialog();
                                    }
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                  return Container();
                                }
                            );
                          }
                      );
                    }


                    // if(buttonState == true) {
                    //   bool result = await EventRequest().eventCreateRequest(context);
                    //   multipleListenerNonActive = true;
                    //   if(result == true) {
                    //     context.read<CreateEventImproveProvider>().createEventClear(false);
                    //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventInfoScreen(visitCount: 0, recommendCount: 0)));
                    //     multipleListenerNonActive = false;
                    //     // Navigator.push(context, MaterialPageRoute(builder: (_) => EventInfoLoadView()));
                    //   } else {
                    //     /// nothing!!!
                    //   }
                    // } else {
                    //   /// nothing!!!
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonState == false ? StaticColor
                          .grey400BB : StaticColor.categorySelectedColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0))),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 56,
                            child: Center(child: Text('완료',
                                style: TextStyle(fontSize: 16, color: Colors
                                    .white, fontWeight: FontWeight.w700)))),
                      ]
                  )
              ),
            ),
          );
        }
    );
  }
}
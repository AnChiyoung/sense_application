import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/screens/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_modal.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_toast.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.light(
          primary: primaryColor[50] ?? Colors.white,
          secondary: secondary1Color[50] ?? Colors.white,
          onPrimary: primaryColor[50] ??  Colors.white,
        ),
      ),
      home: MainLayout(
      title: '',
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(onPressed: () {
                CustomModal.showModal(
                  context,
                );
              }, child: Text('Show Modal')),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  CustomToast.errorToast(context, 'Invalid system input');

                }, 
                child: Text('Show Error Toast')),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  CustomToast.warningToast(context, 'Invalid system input');

                }, 
                child: Text('Show Warning Toast')),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  CustomToast.successToast(context, 'Invalid system input');

                }, 
                child: Text('Show Success Toast')),
            ),
          ],
        )
      
      ),
      floating: 
        FloatingActionButton(
          onPressed: () {
            // 
          },
          shape: const CircleBorder(),
          child: 
            SvgPicture
              .asset(
                'lib/assets/images/icons/svg/plus.svg',
                color: Colors.white,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
        ),
    ),
    );
  }
}
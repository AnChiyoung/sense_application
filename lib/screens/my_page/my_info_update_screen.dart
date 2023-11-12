import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_content.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_header.dart';

class MyInfoUpdate extends StatefulWidget {
  final int page;
  const MyInfoUpdate({super.key, required this.page});

  @override
  State<MyInfoUpdate> createState() => _MyInfoUpdateState();
}

class _MyInfoUpdateState extends State<MyInfoUpdate> {
  @override
  Widget build(BuildContext context) {
    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    // final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
    // print(MediaQuery.of(context).viewPadding.bottom);
    // print(MediaQuery.of(context).viewPadding.top);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const MyInfoUpdateHeader(),
            Expanded(
              child: MyInfoUpdateContent(
                page: widget.page,
                topPadding: safeAreaTopPadding,
              ),
            ),
            // SizedBox(height: bp)
          ],
        ),
      ),
      // bottomNavigationBar: const MyInfoUpdateButton(),
    );
  }
}

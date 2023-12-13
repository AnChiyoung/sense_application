import 'package:flutter/material.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_header.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/edit_profile_content.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            EditProfileHeader(),
            Expanded(
              child: EditProfileContent(),
            ),
          ],
        ),
      ),
    );
  }
}

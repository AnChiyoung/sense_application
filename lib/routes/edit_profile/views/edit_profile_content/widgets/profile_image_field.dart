import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/api/media.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';
import 'package:sense_flutter_application/utils/utility.dart';
import 'package:sense_flutter_application/widgets/user_avatar.dart';

class ProfileImageField extends StatefulWidget {
  const ProfileImageField({super.key});

  @override
  State<ProfileImageField> createState() => _ProfileImageFieldState();
}

class _ProfileImageFieldState extends State<ProfileImageField> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.dm,
      height: 80.dm,
      child: GestureDetector(
        onTap: onTapProfile,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Selector<EditProfileProvider, String>(
              selector: (context, data) => data.profileImageUrl,
              builder: (context, profileImageUrl, child) {
                return UserAvatar(
                  size: 80.dm,
                  profileImageUrl: profileImageUrl,
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: -4,
              child: Container(
                width: 30.dm,
                height: 30.dm,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: StaticColor.grey200EE,
                    width: 1.dm,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/pencil.png',
                    width: 20.dm,
                    height: 20.dm,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapProfile() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      PostImageResponseData? imageResponse = await MediaRepository().postImage(image: image);
      if (imageResponse == null) return;
      if (!context.mounted) return;

      context.read<EditProfileProvider>().onChangeProfileImageUrl(imageResponse.url, true);
    } catch (e) {
      console.log(e);
    }
  }
}

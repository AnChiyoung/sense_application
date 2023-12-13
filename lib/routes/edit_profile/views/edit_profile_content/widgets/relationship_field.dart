import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';
import 'package:sense_flutter_application/widgets/animated_elevated_button.dart';

class RelationshipField extends StatefulWidget {
  const RelationshipField({super.key});

  @override
  State<RelationshipField> createState() => _RelationshipFieldState();
}

class _RelationshipFieldState extends State<RelationshipField> {
  onSelected(EnumUserRelationshipStatus relationship) {
    context.read<EditProfileProvider>().onChangeRelationshipStatus(relationship, true);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<EditProfileProvider, EnumUserRelationshipStatus?>(
      selector: (context, data) => data.relationshipStatus,
      builder: (context, relationshipStatus, child) {
        return Row(
          children: [
            _button(
              text: EnumUserRelationshipStatus.solo.label,
              isSelected: relationshipStatus == EnumUserRelationshipStatus.solo,
              onPressed: () {
                onSelected(EnumUserRelationshipStatus.solo);
              },
            ),
            SizedBox(width: 8.w),
            _button(
              text: EnumUserRelationshipStatus.couple.label,
              isSelected: relationshipStatus == EnumUserRelationshipStatus.couple,
              onPressed: () {
                onSelected(EnumUserRelationshipStatus.couple);
              },
            ),
            SizedBox(width: 8.w),
            _button(
              text: EnumUserRelationshipStatus.married.label,
              isSelected: relationshipStatus == EnumUserRelationshipStatus.married,
              onPressed: () {
                onSelected(EnumUserRelationshipStatus.married);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _button({
    required String text,
    required bool isSelected,
    void Function()? onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: 38.h,
        child: AnimatedElevatedButton(
          text: text,
          isSelected: isSelected,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

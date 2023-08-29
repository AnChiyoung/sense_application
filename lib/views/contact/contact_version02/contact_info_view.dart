import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactInfoHeader extends StatefulWidget {
  const ContactInfoHeader({super.key});

  @override
  State<ContactInfoHeader> createState() => _ContactInfoHeaderState();
}

class _ContactInfoHeaderState extends State<ContactInfoHeader> {

  TextStyle titleStyle = TextStyle(fontSize: 16, color: StaticColor.black90015, fontWeight: FontWeight.w500);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '친구 정보 수정', titleStyle: titleStyle);
  }

  void backCallback() {
    context.read<ContactProvider>().contactModelInit();
    context.read<ContactProvider>().xfileStateClear();
    Navigator.of(context).pop();
  }
}

class ContactInfoUserProfile extends StatefulWidget {
  ContactModel contactModel;
  ContactInfoUserProfile({super.key, required this.contactModel});

  @override
  State<ContactInfoUserProfile> createState() => _ContactInfoUserProfileState();
}

class _ContactInfoUserProfileState extends State<ContactInfoUserProfile> {

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    /// 최초 값은 수정 안된 값으로 저장
    context.read<ContactProvider>().updateImageData(widget.contactModel.profileImage!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, data, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SizedBox(
            width: 80.0,
            height: 80.0,
            child: GestureDetector(
              onTap: () async {
                image = await _picker.pickImage(source: ImageSource.gallery);
                context.read<ContactProvider>().xfileStateChange(image);
              },
              child: UserProfileImage(profileImageUrl: widget.contactModel.profileImage, selectImage: data.selectImage),
            ),
          ),
        );
      }
    );
          // child: UserProfileImage(profileImageUrl: ''))));
  }
}

class ContactInfoBasic extends StatefulWidget {
  ContactModel contactModel;
  ContactInfoBasic({super.key, required this.contactModel});

  @override
  State<ContactInfoBasic> createState() => _ContactInfoBasicState();
}

class _ContactInfoBasicState extends State<ContactInfoBasic> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  String selectDate = '';
  int year = 0;
  int month = 0;
  int day = 0;
  DateTime initdate = DateTime.now();

  @override
  void initState() {
    if(widget.contactModel.birthday != '') {
      year = int.parse(widget.contactModel.birthday!.substring(0, 4));
      month = int.parse(widget.contactModel.birthday!.substring(5, 7));
      day = int.parse(widget.contactModel.birthday!.substring(8));
      initdate = DateTime.utc(year, month, day);
    } else {}

    selectDate = widget.contactModel.birthday!;
    nameController.text = widget.contactModel.name ?? '';
    phoneController.text = widget.contactModel.phone ?? '';
    birthdayController.text = widget.contactModel.birthday ?? '';

    /// 최초 값은 수정 안된 값으로 저장
    context.read<ContactProvider>().updateNameData(widget.contactModel.name!);
    context.read<ContactProvider>().updatePhoneData(widget.contactModel.phone!);
    context.read<ContactProvider>().updateBirthdayData(widget.contactModel.birthday!);
    context.read<ContactProvider>().updateImageData('');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('기본정보', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: nameController,
            autofocus: true,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(color: Colors.black),
            maxLength: 7,
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
              filled: true,
              fillColor: StaticColor.loginInputBoxColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              alignLabelWithHint: false,
              hintText: '이름을 입력해주세요',
              hintStyle: TextStyle(fontSize: 16, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
              border: InputBorder.none,
              errorText: null,
              counterText: '',
            ),
            onTap: () {},
            onChanged: (value) {
              context.read<ContactProvider>().updateNameData(value);
            },
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: phoneController,
            inputFormatters: [
              MultiMaskedTextInputFormatter(masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'], separator: '-')
            ],
            autofocus: true,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
              filled: true,
              fillColor: StaticColor.loginInputBoxColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              alignLabelWithHint: false,
              hintText: '전화번호를 입력해주세요',
              hintStyle: TextStyle(fontSize: 16, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
              border: InputBorder.none,
              errorText: null,
              counterText: '',
            ),
            onTap: () {
            },
            onChanged: (value) {
              context.read<ContactProvider>().updatePhoneData(value);
            },
          ),
          const SizedBox(height: 12.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: TextFormField(
              controller: birthdayController,
              autofocus: true,
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                filled: true,
                fillColor: StaticColor.loginInputBoxColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                alignLabelWithHint: false,
                hintText: '생일을 선택해주세요',
                hintStyle: TextStyle(fontSize: 16, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                border: InputBorder.none,
                errorText: null,
                counterText: '',
              ),
              onTap: () {
                showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) {
                  return Wrap(children: [dateSelect(context)]);
                });
              },
              onChanged: (value) {
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget dateSelect(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  if(selectDate == '') {
                    initdate = DateTime.now();
                    birthdayController.text = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString().substring(0, 10);
                  } else {
                    birthdayController.text = selectDate;
                    initdate = DateTime.utc(int.parse(selectDate.substring(0, 4)), int.parse(selectDate.substring(5, 7)), int.parse(selectDate.substring(8)));
                  }

                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 250,
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    initialDateTime: initdate,
                    onDateTimeChanged: (date) {
                      selectDate = date.toString().substring(0, 10);
                      context.read<ContactProvider>().updateBirthdayData(selectDate);
                    },
                    mode: CupertinoDatePickerMode.date,

                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInfoGender extends StatefulWidget {
  ContactModel contactModel;
  ContactInfoGender({super.key, required this.contactModel});

  @override
  State<ContactInfoGender> createState() => _ContactInfoGenderState();
}

class _ContactInfoGenderState extends State<ContactInfoGender> {

  /// true : 남성, false, 여성
  bool genderState = true;
  TextStyle nonSelectStyle = TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w500);
  TextStyle selectStyle = const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700);
  Color nonSelectColor = StaticColor.grey100F6;
  Color selectColor = StaticColor.bottomButtonColor;

  @override
  void initState() {
    if(widget.contactModel.gender == '남성') {
      context.read<ContactProvider>().genderStateSet(true);
    } else if(widget.contactModel.gender == '여성') {
      context.read<ContactProvider>().genderStateSet(false);
    } else {
      context.read<ContactProvider>().genderStateSet(true);
    }
    print(widget.contactModel.gender);
    /// 최초 값은 수정 안된 값으로 저장
    context.read<ContactProvider>().updateGenderData(widget.contactModel.gender!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, data, child) {
        genderState = data.genderState;
        print(genderState);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('성별', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ContactProvider>().genderStateChange(true);
                          context.read<ContactProvider>().updateGenderData('남성');
                        },
                        style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: genderState == true ? selectColor : nonSelectColor),
                        child: Text('남', style: genderState == true ? selectStyle : nonSelectStyle),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ContactProvider>().genderStateChange(false);
                          context.read<ContactProvider>().updateGenderData('여성');
                        },
                        style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: genderState == true ? nonSelectColor : selectColor),
                        child: Text('여', style: genderState == true ? nonSelectStyle : selectStyle),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}

class ContactInfoCategory extends StatefulWidget {
  ContactModel contactModel;
  ContactInfoCategory({super.key, required this.contactModel});

  @override
  State<ContactInfoCategory> createState() => _ContactInfoCategoryState();
}

class _ContactInfoCategoryState extends State<ContactInfoCategory> {

  /// 1: 친구, 2: 가족, 3: 연인, 4: 직장
  int selectCategory = 1;
  TextStyle nonSelectStyle = TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w500);
  TextStyle selectStyle = const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700);
  Color nonSelectColor = StaticColor.grey100F6;
  Color selectColor = StaticColor.bottomButtonColor;

  @override
  void initState() {
    context.read<ContactProvider>().categoryStateSet(widget.contactModel.contactCategoryObject!.id!);
    /// 최초 값은 수정 안된 값으로 저장
    context.read<ContactProvider>().updateCategoryData(widget.contactModel.contactCategoryObject!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, data, child) {

          selectCategory = data.categoryState;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('유형', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ContactProvider>().categoryStateChange(1);
                            context.read<ContactProvider>().updateCategoryData(1);
                          },
                          style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: selectCategory == 1 ? selectColor : nonSelectColor),
                          child: Text('친구', style: selectCategory == 1 ? selectStyle : nonSelectStyle),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ContactProvider>().categoryStateChange(2);
                            context.read<ContactProvider>().updateCategoryData(2);
                          },
                          style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: selectCategory == 2 ? selectColor : nonSelectColor),
                          child: Text('가족', style: selectCategory == 2 ? selectStyle : nonSelectStyle),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ContactProvider>().categoryStateChange(3);
                            context.read<ContactProvider>().updateCategoryData(3);
                          },
                          style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: selectCategory == 3 ? selectColor : nonSelectColor),
                          child: Text('연인', style: selectCategory == 3 ? selectStyle : nonSelectStyle),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ContactProvider>().categoryStateChange(4);
                            context.read<ContactProvider>().updateCategoryData(4);
                          },
                          style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: selectCategory == 4 ? selectColor : nonSelectColor),
                          child: Text('직장', style: selectCategory == 4 ? selectStyle : nonSelectStyle),
                        ),
                      ),
                    ),

                    // Expanded(
                    //   flex: 1,
                    //   child: SizedBox(
                    //     height: 40.0,
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         context.read<ContactProvider>().genderStateChange(false);
                    //       },
                    //       style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: genderState == true ? nonSelectColor : selectColor),
                    //       child: Text('여', style: genderState == true ? nonSelectStyle : selectStyle),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}

class ContactInfoSaveButton extends StatefulWidget {
  ContactModel contactModel;
  double topPadding;
  double height;
  ContactInfoSaveButton({super.key, required this.contactModel, required this.topPadding, required this.height});

  @override
  State<ContactInfoSaveButton> createState() => _ContactInfoSaveButtonState();
}

class _ContactInfoSaveButtonState extends State<ContactInfoSaveButton> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          // ContactModel updateResult = await ContactRequest().contactUpdateRequest(
          bool updateSuccessState = await ContactRequest().contactUpdateRequest(
              widget.contactModel.id!,
              context.read<ContactProvider>().updateCategory,
              context.read<ContactProvider>().updateName,
              context.read<ContactProvider>().updatePhone,
              context.read<ContactProvider>().updateBirthday,
              context.read<ContactProvider>().updateGender,
              context.read<ContactProvider>().updateImage,
              context
          );
          // context.read<ContactProvider>().infoReload(updateResult);
          context.read<ContactProvider>().viewUpdate(!context.read<ContactProvider>().updateState);

          if(updateSuccessState == true) {
            final updateSnackbar = CustomSnackbar(
              message: '연락처가 업데이트 되었습니다',
              context: context,
              topPadding: widget.topPadding,
              positive: true,
            );
            ScaffoldMessenger.of(context).showSnackBar(updateSnackbar);
          } else {
            final updateSnackbar = CustomSnackbar(
              message: '연락처를 업데이트 하지 못하였습니다',
              context: context,
              topPadding: widget.topPadding,
              positive: false,
            );
            ScaffoldMessenger.of(context).showSnackBar(updateSnackbar);
          }
          // ignore: use_build_context_synchronously

        },
        child: Container(
          height: 76, color: StaticColor.bottomButtonColor,
          child: const Padding(
            padding: EdgeInsets.only(bottom: 18.0),
            child: Align(
              alignment: Alignment.center,
              child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSnackbar extends SnackBar {
  final String message;
  final BuildContext context;
  final double topPadding;
  final bool positive;

  CustomSnackbar({
    Key? key,
    required this.message,
    required this.context,
    required this.topPadding,
    required this.positive,
  }) : super(
    key: key,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    padding: const EdgeInsets.symmetric(horizontal: 30),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 150,
    ),
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: positive == true ? StaticColor.snackbarColor : StaticColor.errorColor, width: 1),
      ),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            positive == true ? Image.asset('assets/signin/snackbar_ok_icon.png', width: 24, height: 24) : Image.asset('assets/signin/snackbar_error_icon.png', width: 24, height: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16, color: positive == true ? StaticColor.snackbarColor : StaticColor.errorColor, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  _getSize(GlobalKey key) {
    if(key.currentContext != null) {
      final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
  }
}


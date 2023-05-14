import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/signin_info_model.dart';
import 'package:sense_flutter_application/screens/sign_in/phone_auth_screen.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_validate.dart';
import 'package:table_calendar/table_calendar.dart';

class BasicInfoHeader extends StatelessWidget {
  const BasicInfoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: true, title: '', closeButton: false);
  }
}

class BasicInfoDescription extends StatefulWidget {
  const BasicInfoDescription({Key? key}) : super(key: key);

  @override
  State<BasicInfoDescription> createState() => _BasicInfoDescriptionState();
}

class _BasicInfoDescriptionState extends State<BasicInfoDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 41, bottom: 25),
        child: SigninDescription(presentPage: 3, totalPage: 3, description: '기본정보를\n입력해 주세요')
    );
  }
}

class BasicInfoInputField extends StatefulWidget {
  const BasicInfoInputField({Key? key}) : super(key: key);

  @override
  State<BasicInfoInputField> createState() => _BasicInfoInputFieldState();
}

class _BasicInfoInputFieldState extends State<BasicInfoInputField> {
  KakaoUserModel? presetModel = KakaoUserInfoModel.presetInfo;
  String gender = '';

  List<bool> widgetManagement = [true, false, false, false];
  List<bool> genderManagement = [true, false];

  TextEditingController nameInputController = TextEditingController();
  TextEditingController birthdayInputController = TextEditingController();
  TextEditingController genderInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode nameFocusNode = FocusNode();
  FocusNode birthdayFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();

  bool nameState = false;
  bool birthdayState = false;
  bool genderState = false;
  bool phoneNumberState = false;

  @override
  void initState() {
    if(presetModel?.gender == 'mail') {
      genderManagement = [true, false];
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<SigninProvider>().genderChangeState(genderManagement);
      });
    } else if(presetModel?.gender == 'femail') {
      genderManagement = [false, true];
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<SigninProvider>().genderChangeState(genderManagement);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<SigninProvider>(
          builder: (context, data, child) => AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            opacity: data.stepChange[3] ? 1 : 0,
            child: Visibility(
              visible: data.stepChange[3],
              child: phoneNumberField(context),
            ),
          ),
        ),
        Consumer<SigninProvider>(
            builder: (context, data, child) =>
            data.stepChange[3] == true ? Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(width: double.infinity, height: 8)) : const SizedBox.shrink()
        ),
        Consumer<SigninProvider>(
          builder: (context, data, child) => AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            opacity: data.stepChange[2] ? 1 : 0,
            child: Visibility(
              visible: data.stepChange[2],
              child: genderField(context),
            ),
          ),
        ),
        Consumer<SigninProvider>(
            builder: (context, data, child) =>
            data.stepChange[2] == true ? Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(width: double.infinity, height: 8)) : const SizedBox.shrink()
        ),
        Consumer<SigninProvider>(
          builder: (context, data, child) => AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            opacity: data.stepChange[1] ? 1 : 0,
            child: Visibility(
              visible: data.stepChange[1],
              child: birthdayField(context),
            ),
          ),
        ),
        Consumer<SigninProvider>(
          builder: (context, data, child) =>
          data.stepChange[1] == true ? Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(width: double.infinity, height: 8)) : const SizedBox.shrink()
        ),

        Visibility(
          child: nameField(context)
        )
      ],
    );
  }

  Widget phoneNumberField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: phoneNumberInputController,
        autofocus: true,
        focusNode: phoneNumberFocusNode,
        inputFormatters: [
          MultiMaskedTextInputFormatter(masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'], separator: '-')
        ],
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.always,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
          filled: true,
          fillColor: StaticColor.loginInputBoxColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          alignLabelWithHint: false,
          labelText: '핸드폰',
          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          hintText: '000-0000-0000',
          hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          errorText: null,
        ),
        onTap: () async {
          // final date = await showDatePicker(
          //   initialEntryMode: DatePickerEntryMode.calendarOnly,
          //   useRootNavigator: false,
          //   context: context, initialDate: DateTime.now(), firstDate: DateTime.utc(1900, 1, 1), lastDate: DateTime.now(),
          // );
          // birthdayInputController.text = date.toString().substring(0, 10);
          // // showDialog(barrierDismissible: false, context: context, builder: (context) {return birthdaySelectDialog(context);});
        },
        onChanged: (value) {
          String sendNumber = value;
          if(value.length > 12) {
            phoneNumberState = true;
          } else {
            phoneNumberState = false;
          }
          // print(nameState.toString() + '/' + birthdayState.toString() + '/' + genderState.toString() + '/' + phoneNumberState.toString());
          nameState && birthdayState && genderState && phoneNumberState == false ?
            context.read<SigninProvider>().basicInfoButtonStateChange(false, '') :
            context.read<SigninProvider>().basicInfoButtonStateChange(true, sendNumber.replaceAll('-', ''));
        },
      ),
    );
  }

  Widget genderField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
          controller: genderInputController,
          readOnly: true,
          autofocus: true,
          focusNode: genderFocusNode,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.always,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
            filled: true,
            fillColor: StaticColor.loginInputBoxColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            alignLabelWithHint: false,
            labelText: '성별',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            hintText: '성별을 선택해 주세요',
            hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
            border: InputBorder.none,
            errorText: null,
          ),
          onTap: () async {
            showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [genderSelect(context)]);});

            // final date = await showDatePicker(
            //   initialEntryMode: DatePickerEntryMode.calendarOnly,
            //   useRootNavigator: false,
            //   context: context, initialDate: DateTime.now(), firstDate: DateTime.utc(1900, 1, 1), lastDate: DateTime.now(),
            // );
            // birthdayInputController.text = date.toString().substring(0, 10);
            // // showDialog(barrierDismissible: false, context: context, builder: (context) {return birthdaySelectDialog(context);});
          },
      ),
    );
  }

  Widget birthdayField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: birthdayInputController,
        readOnly: true,
        autofocus: true,
        focusNode: birthdayFocusNode,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.always,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
          filled: true,
          fillColor: StaticColor.loginInputBoxColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          alignLabelWithHint: false,
          labelText: '생일',
          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          hintText: 'YYYY - MM - DD',
          hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          errorText: null,
        ),
        onTap: () async {
          final date = await showDatePicker(
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              useRootNavigator: false,
              context: context, initialDate: DateTime.now(), firstDate: DateTime.utc(1900, 1, 1), lastDate: DateTime.now(),
          );
          date == null ? {} : {
            birthdayState = true,
            /// data input
            SigninModel.birthday = date.toString(),
          };
          birthdayInputController.text = date.toString().substring(0, 10);
          widgetManagement[2] = true;
          context.read<SigninProvider>().stepChangeState(widgetManagement);
          // showDialog(barrierDismissible: false, context: context, builder: (context) {return birthdaySelectDialog(context);});
        },
      ),
    );
  }

  Widget nameField(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: nameInputController,
          autofocus: true,
          focusNode: nameFocusNode,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.always,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
            filled: true,
            fillColor: StaticColor.loginInputBoxColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            alignLabelWithHint: false,
            labelText: '이름',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            hintText: '실명을 입력해 주세요',
            hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value!.length > 0 && SigninValidate().nameValidate(value!) == false) {
              nameState = false;
              return '이름은 2~7자의 한글만 가능합니다';
            } else {
              value.length > 0 ? nameState = true : nameState = false;
              return null;
            }
          },
          onFieldSubmitted: (f) {
            widgetManagement[1] = true;
            context.read<SigninProvider>().stepChangeState(widgetManagement);
            // FocusScope.of(context).requestFocus(passwordFocusNode);
          },
          onChanged: (_) {
            /// data input
            SigninModel.name = nameInputController.text;

            nameState && birthdayState && genderState && phoneNumberState == true
                ? context.read<SigninProvider>().basicInfoButtonStateChange(true, phoneNumberInputController.text.replaceAll('-', ''))
                : context.read<SigninProvider>().basicInfoButtonStateChange(false, '');
          }
        ),
      ),
    );
  }

  Widget genderSelect(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('성별', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/signin/button_close.png', width: 24, height: 24),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      /// data input
                      SigninModel.gender = '남성';

                      genderState = true;
                      genderManagement[0] = true;
                      genderManagement[1] = false;
                      genderInputController.text = '남자';
                      context.read<SigninProvider>().genderChangeState(genderManagement);
                      widgetManagement[3] = true;
                      context.read<SigninProvider>().stepChangeState(widgetManagement);
                    },
                    child: Consumer<SigninProvider>(
                      builder: (context, data, child) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: data.genderChange[0] == true ? StaticColor.grey100F6 : Colors.transparent,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('남자', style: TextStyle(fontSize: 16, color: data.genderChange[0] == true ? StaticColor.black90015 : StaticColor.grey70055, fontWeight: FontWeight.w700)),
                              data.genderChange[0] == true ? Image.asset('assets/signin/button_check.png', width: 24, height: 24) : const SizedBox.shrink(),
                            ],
                          )),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      /// data input
                      SigninModel.gender = '여성';

                      genderState = true;
                      genderManagement[0] = false;
                      genderManagement[1] = true;
                      genderInputController.text = '여자';
                      context.read<SigninProvider>().genderChangeState(genderManagement);
                      widgetManagement[3] = true;
                      context.read<SigninProvider>().stepChangeState(widgetManagement);
                    },
                    child: Consumer<SigninProvider>(
                      builder: (context, data, child) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: data.genderChange[1] == true ? StaticColor.grey100F6 : Colors.transparent,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('여자', style: TextStyle(fontSize: 16, color: data.genderChange[1] == true ? StaticColor.black90015 : StaticColor.grey70055, fontWeight: FontWeight.w700)),
                                data.genderChange[1] == true ? Image.asset('assets/signin/button_check.png', width: 24, height: 24) : const SizedBox.shrink(),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget birthdaySelectDialog(BuildContext context) {
  //   return Dialog(
  //     child: Container(
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(13.0),
  //       ),
  //       child: CalendarDatePicker2(
  //         config: CalendarDatePicker2Config(
  //           calendarType: CalendarDatePicker2Type.single,
  //         ), value: [DateTime.now()],
  //       )
  //     ),
  //   );
  // }
}

class BasicInfoAuthButton extends StatefulWidget {
  const BasicInfoAuthButton({Key? key}) : super(key: key);

  @override
  State<BasicInfoAuthButton> createState() => _BasicInfoAuthButtonState();
}

class _BasicInfoAuthButtonState extends State<BasicInfoAuthButton> {

  Future backButtonAction(BuildContext context) async {
    // context.read<AddEventProvider>().dateSelectNextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: Consumer<SigninProvider>(
        builder: (context, data, child) => SizedBox(
          width: double.infinity,
          height: 76,
          child: ElevatedButton(
              onPressed: () {
                /// data input
                SigninModel.phone = data.phoneNumber;

                data.basicInfoButtonState == true ? Navigator.push(context, MaterialPageRoute(builder: (_) => PhoneAuthScreen(phoneNumber: data.phoneNumber))) : {};
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: data.basicInfoButtonState == true
                      ? StaticColor.categorySelectedColor
                      : StaticColor.unSelectedColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: const [
                SizedBox(
                    height: 56,
                    child: Center(
                        child: Text('연락처 인증받기',
                            style: TextStyle(
                                fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)))),
              ])),
        ),
      ),
    );
  }
}
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/contact_data_done_view.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactDataExist extends StatefulWidget {
  const ContactDataExist({super.key});

  @override
  State<ContactDataExist> createState() => _ContactDataExistState();
}

class _ContactDataExistState extends State<ContactDataExist> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, data, child) {

        bool viewUpdate = data.updateState;

        return FutureBuilder(
            future: Future.wait([
              ContactRequest().contactListRequest(),
              ContactRequest().contactListRequest(1),
              ContactRequest().contactListRequest(2),
              ContactRequest().contactListRequest(3),
              ContactRequest().contactListRequest(4),
            ]),
            builder: (context, snapshot) {
              if(snapshot.hasData) {

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150.0.w, height: 150.0.h));
                } else if(snapshot.connectionState == ConnectionState.done) {

                  List<ContactModel> loadContactModel = snapshot.data!.elementAt(0) ?? [];
                  List<ContactModel> loadContactModelFamily = snapshot.data!.elementAt(1) ?? [];
                  List<ContactModel> loadContactModelFriend = snapshot.data!.elementAt(2) ?? [];
                  List<ContactModel> loadContactModelCouple = snapshot.data!.elementAt(3) ?? [];
                  List<ContactModel> loadContactModelCoworker = snapshot.data!.elementAt(4) ?? [];

                  List<List<ContactModel>> contactCollector = [loadContactModel, loadContactModelFamily, loadContactModelFriend, loadContactModelCouple, loadContactModelCoworker];

                  if(loadContactModel.isEmpty) {
                    return Center(child: ContactLoadRequestView());
                  } else {
                    return ContactDataDone(contactCollector: contactCollector);
                  }

                } else {
                  return const SizedBox.shrink();
                }

              } else if(snapshot.hasError) {
                return const Text('Error fetching..');
              } else {
                return const SizedBox.shrink();
              }
            }
        );
      }
    );
  }
}

class ContactLoadRequestView extends StatefulWidget {
  const ContactLoadRequestView({super.key});

  @override
  State<ContactLoadRequestView> createState() => _ContactLoadRequestViewState();
}

class _ContactLoadRequestViewState extends State<ContactLoadRequestView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('친구 목록을 만들려면\n연락처를 불러와야해요', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400)),
        SizedBox(height: 24.0.h),
        ElevatedButton(
          onPressed: () async {
            getPermission();
        },
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0.h),
            child: const Text('연락처 불러오기', style: TextStyle(color: Colors.white)))),
        ),
      ],
    );
  }

  void getPermission() async {
    //(주의) Android 11버전 이상과 iOS에서는 유저가 한 두번 이상 거절하면 다시는 팝업 띄울 수 없습니다.
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      //연락처 권한 줬는지 여부
      setState(() {});

      /// save contact list
      List<ContactModel> initContactList = [];
      ContactRequest.contacts = await ContactsService.getContacts();
      for(int i=0; i< ContactRequest.contacts.length; i++) {
        print(ContactRequest.contacts.elementAt(i).familyName);
        String name = '';
        if(ContactRequest.contacts.elementAt(i).givenName == '') {
          name = ContactRequest.contacts.elementAt(i).familyName.toString();
        } else {
          name = ContactRequest.contacts.elementAt(i).givenName.toString();
        }

        initContactList.add(
            ContactModel(
              contactCategory: 1,
              name: name,
              // phone: ContactRequest.contacts.elementAt(i).phones!.toString(),
              phone: '',
              birthday: '',
              gender: '남성',
              profileImage: '',
            )
        );
      }

      bool result = await ContactRequest().contactListCreateRequest(initContactList);

      /// 연락처 불러오기 성공하면 저장하고, 저장한걸 불러오자
      if(result == true) {
        setState(() {

        });
        context.read<ContactProvider>().viewUpdate(!context.read<ContactProvider>().updateState);
        // context.read<ContactProvider>().contactListLoad();
      }

      // for (int i = 0; i < ContactRequest.contacts.length; i++) {
      //   if (ContactRequest.contacts[i].givenName == '') {
      //     // print(ContactRequest.contacts[i].familyName);
      //   } else {
      //     // print(ContactRequest.contacts[i].givenName);
      //   }
      //   setState(() {});
      // }
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request(); //허락해달라고 팝업띄우는 코드
    }
    // 하지만 아이폰의 경우 OS가 금지하는 경우도 있고 (status.isRestricted)
    // 안드로이드의 경우 아예 앱 설정에서 꺼놓은 경우 (status.isPermanentlyDenied)
    // 그것도 체크하고 싶으면
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

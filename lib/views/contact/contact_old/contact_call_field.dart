import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactCallField extends StatefulWidget {
  const ContactCallField({Key? key}) : super(key: key);

  @override
  State<ContactCallField> createState() => _ContactCallFieldState();
}

class _ContactCallFieldState extends State<ContactCallField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          getPermission();
        },
        child: const SizedBox(
            width: 100, height: 40, child: Center(child: Text('연락처 불러오기', style: TextStyle(color: Colors.white)))),
      ),
      //   ) : const SizedBox.shrink(),
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
        context.read<ContactProvider>().contactListLoad();
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

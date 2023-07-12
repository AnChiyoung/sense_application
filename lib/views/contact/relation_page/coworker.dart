import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/screens/contact/contact_detail_screen.dart';

class CoworkerView extends StatefulWidget {
  const CoworkerView({super.key});

  @override
  State<CoworkerView> createState() => _CoworkerViewState();
}

class _CoworkerViewState extends State<CoworkerView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ContactRequest().contactListRequest(4),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(child: Text('Error fetching!!'));
          } else if(snapshot.hasData) {

            /// data get!!
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
            } else if(snapshot.connectionState == ConnectionState.done) {

              ContactTabModel? resultModel = snapshot.data;
              List<ContactModel>? familyModelList = resultModel!.contactModelList;
              if(familyModelList!.isEmpty) {
                return Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'));
              } else if(familyModelList!.isNotEmpty) {
                return CoworkerList(contactListModel: familyModelList);
              }

              return Container();
            } else {
              return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
            }

          } else {
            return const Center(child: Text('Error fetching!!'));
          }
        }
    );
  }
}

class CoworkerList extends StatefulWidget {
  List<ContactModel> contactListModel;
  CoworkerList({super.key, required this.contactListModel});

  @override
  State<CoworkerList> createState() => _CoworkerListState();
}

class _CoworkerListState extends State<CoworkerList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: widget.contactListModel.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // context.read<ContactProvider>().contactModelLoad(widget.contactListModel.elementAt(index).id!);
                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                    ContactDetailScreen(contactModel: widget.contactListModel.elementAt(index))));

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),

                /// gesture detector press용 color bug 해소를 위한 container
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      widget.contactListModel.elementAt(index).profileImage! == ''
                          ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                          : UserProfileImage(profileImageUrl: widget.contactListModel.elementAt(index).profileImage!),
                      const SizedBox(width: 8),
                      Text(widget.contactListModel.elementAt(index).name!,
                          style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}

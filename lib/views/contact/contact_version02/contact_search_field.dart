import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/screens/contact/contact_detail_screen.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactSearchField extends StatefulWidget {
  const ContactSearchField({super.key});

  @override
  State<ContactSearchField> createState() => _ContactSearchFieldState();
}

class _ContactSearchFieldState extends State<ContactSearchField> {

  TextEditingController searchController = TextEditingController();
  FocusNode searchFieldFocusNode = FocusNode();
  String inputSearchText = '';

  @override
  void initState() {
    searchFieldFocusNodeListen();
    super.initState();
  }

  void searchFieldFocusNodeListen() {
    searchFieldFocusNode.addListener(() {
      if(searchFieldFocusNode.hasFocus) {
        context.read<ContactProvider>().isSearchState(true);
      } else {
        context.read<ContactProvider>().isSearchState(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // final searchState = context.watch<ContactProvider>().searchState;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: [
            Consumer<ContactProvider>(
              builder: (context, data, child) {
                if(data.searchState == true) {
                  return backWidget();
                } else {
                  return const SizedBox.shrink();
                }
              }
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    contactSearchBox(),
                    Padding(padding: const EdgeInsets.only(right: 2), child: searchButton()),
                  ]
              ),
            ),
          ],
        )
    );
  }

  Widget backWidget() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40,
        height: 40,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {
            searchFieldFocusNode.unfocus(); /// 중요. 검색화면에서 뒤로갔을 때 포커싱은 여전히 검색탭에 되어있어서, 연락처 상세화면 같은 다른 동작 후에 검색화면이 리턴된다.
            context.read<ContactProvider>().isSearchState(false);
          },
          child: Center(child: Image.asset('assets/create_event/button_back.png', width: 24, height: 24)),
        ),
      ),
    );
  }

  Widget contactSearchBox() {
    return TextFormField(
      controller: searchController,
      focusNode: searchFieldFocusNode,
      autofocus: false,
      obscureText: false,
      maxLines: 1,
      maxLength: 7,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(color: Colors.black), /// input text color
      decoration: InputDecoration(
        isDense: false,
        filled: true,
        fillColor: StaticColor.loginInputBoxColor,
        contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
        counterText: '',
        hintText: '친구를 검색해 주세요',
        hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            width: 1, color: Colors.transparent,
          )
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1, color: Colors.transparent,
          ),
        ),
      ),
      onChanged: (value) {
        inputSearchText = value;
        /// 검색어 변경
        context.read<ContactProvider>().searchTextChange(value.toLowerCase());
      },
      // onTap: () {
        // // context.read<ContactProvider>().isSearchState(true);
        // if(context.read<ContactProvider>().searchFocus == 0) {
        //   print(context.read<ContactProvider>().searchFocus);
        //   context.read<ContactProvider>().isSearchState(true);
        //   context.read<ContactProvider>().searchFocusUpdate();
        // } else {
        //   print(context.read<ContactProvider>().searchFocus);
        // }
      // }
    );
  }

  Widget searchButton() {
    return Consumer<ContactProvider>(
      builder: (context, data, child) => data.searchState == true
        ? Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            onTap: () {
              if(inputSearchText == '') {
              } else {
                searchController.clear();
                inputSearchText = '';
                context.read<ContactProvider>().searchTextChange('');
              }
            },
            child: SizedBox(
                width: 36,
                height: 36,
                child: Center(child: inputSearchText == ''
                    ? Image.asset('assets/feed/search_button.png', width: 24, height: 24, color: StaticColor.grey80033)
                    : Image.asset('assets/contact/searchbox_delete_button.png', width: 24, height: 24, color: StaticColor.grey2))),
          )
        )
        : Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onTap: () {
                context.read<ContactProvider>().isSearchState(true);
              },
              child: SizedBox(
                width: 36,
                height: 36,
                child: Center(child: Image.asset('assets/contact/search_button.png', width: 24, height: 24))),
            )
          ),
    );
  }
}

class SearchResultSection extends StatefulWidget {
  const SearchResultSection({super.key});

  @override
  State<SearchResultSection> createState() => _SearchResultSectionState();
}

class _SearchResultSectionState extends State<SearchResultSection> {

  late Future onceRunFuture;
  List<ContactModel> searchResultList = [];

  @override
  void initState() {
    onceRunFuture = _fetchData();
    super.initState();
  }

  Future<List<ContactModel>> _fetchData() async {
    List<ContactModel> result = await ContactRequest().contactListRequest();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, data, child) {

          searchResultList.clear();
          String searchText = data.searchText;

          return Expanded(
            child: FutureBuilder(
                future: onceRunFuture,
                builder: (context, snapshot) {
                  if(snapshot.hasError) {
                    return const Text('fetching error..');
                  } else if(snapshot.hasData) {

                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    } else if(snapshot.connectionState == ConnectionState.done) {

                      /// fetching data
                      List<ContactModel> model = snapshot.data!;
                      // List<ContactModel> model = snapshot.data.contactModelList;
                      // int modelCount = snapshot.data.count;

                      /// search result : intenal listview
                      /// 대소문자 구분? 구분x?
                      for(int i = 0; i < model.length; i++) {
                        /// 소문자 조져보자.
                        if(model.elementAt(i).name!.toLowerCase().contains(searchText.toLowerCase())) {
                          searchResultList.add(model.elementAt(i));
                        }
                      }

                      // print('---');
                      // print(searchText);
                      // print(searchResultList);
                      // print('---');

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                        child: ListView.builder(
                            itemCount: searchResultList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // context.read<ContactProvider>().contactModelLoad(widget.callContact.elementAt(index).id!);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ContactDetailScreen(contactModel: searchResultList.elementAt(index))));
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
                                        searchResultList.elementAt(index).profileImage! == ''
                                            ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                                            : UserProfileImage(profileImageUrl: searchResultList.elementAt(index).profileImage!),
                                        const SizedBox(width: 8),
                                        Text(searchResultList.elementAt(index).name!,
                                            style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      );

                    } else {
                      return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    }
                  } else {
                    return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                  }
                }
            ),
          );
        }
    );
  }
}
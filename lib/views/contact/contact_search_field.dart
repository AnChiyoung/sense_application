import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactSearchField extends StatefulWidget {
  const ContactSearchField({Key? key}) : super(key: key);

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
        // context.read<ContactProvider>().isSearchState(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final searchState = context.watch<ContactProvider>().searchState;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: [
          searchState == true ? backWidget() : const SizedBox.shrink(),
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
          child: Center(child: Image.asset('assets/add_event/button_back.png', width: 24, height: 24)),
        ),
      ),
    );
  }

  Widget contactSearchBox() {
    return TextFormField(
      controller: searchController,
      focusNode: searchFieldFocusNode,
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class FavoriteListView extends StatefulWidget {
  ContactModel contactModel;
  FavoriteListView({super.key, required this.contactModel});

  @override
  State<FavoriteListView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteListView> {

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, data, child) {

        if(data.contactModel == ContactProvider.publicEmptyObject) {
          name = widget.contactModel.name ?? '미등록';
        } else {
          name = data.contactModel.name ?? '미등록';
        }

        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 33.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$name님의 취향', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: StaticColor.grey100F6,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(child: Text('아직 취향이 정해지지 않았어요', style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w400))),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

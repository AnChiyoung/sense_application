import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';

class FavoriteListView extends StatefulWidget {
  ContactModel contactModel;
  FavoriteListView({super.key, required this.contactModel});

  @override
  State<FavoriteListView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteListView> {

  String name = '';

  @override
  void initState() {
    name = widget.contactModel.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Text('dd', overflow: TextOverflow.ellipsis, ),
          ),
        ],
      ),
    );
  }
}

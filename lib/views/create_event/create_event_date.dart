import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/add_event/date_select_view.dart';

class CreateEventDateView extends StatefulWidget {
  const CreateEventDateView({super.key});

  @override
  State<CreateEventDateView> createState() => _CreateEventDateViewState();
}

class _CreateEventDateViewState extends State<CreateEventDateView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateViewSection(),
        DateSelectSection(),
      ],
    );
  }
}

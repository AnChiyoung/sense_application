import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/event_info/event_info_header.dart';
import 'package:sense_flutter_application/views/event_info/event_info_tab.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class EventInfoView extends StatefulWidget {
  const EventInfoView({super.key});

  @override
  State<EventInfoView> createState() => _EventInfoVioewState();
}

class _EventInfoVioewState extends State<EventInfoView> {

  late Future loadFuture;

  Future<EventModel> _fetchData() async {
    return await EventRequest().eventRequest(context.read<CEProvider>().eventUniqueId);
  }

  @override
  void initState() {
    loadFuture = _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: loadFuture,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if(snapshot.connectionState == ConnectionState.done) {

            EventModel getModel = snapshot.data ?? EventModel();
            setModelInfo(getModel, context);

            return Column(
              children: [
                EventInfoHeader(),
                Expanded(child: EventInfoTab()),
              ]
            );

          } else {
            return CircularProgressIndicator();
          }
        } else if(snapshot.hasError) {
          return CircularProgressIndicator();
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }

  void setModelInfo(EventModel getModel, BuildContext context) {
    context.read<CEProvider>().getModel(getModel);
  }
}

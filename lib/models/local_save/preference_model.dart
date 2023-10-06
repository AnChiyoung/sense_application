// import 'package:hive/hive.dart';
// import 'package:sense_flutter_application/models/event/event_model.dart';
//
// class Preferences {
//   static void recentlyEventSave(EventModel eventModel) async {
//     var box = await Hive.openBox('eventModelListBox');
//     var eventModelListBox = Hive.box('eventModelListBox');
//     List<EventModel> eventModels = eventModelListBox.get('list') ?? [];
//     if(eventModels.length == 10) {
//       eventModels.removeAt(0);
//     }
//     eventModels.add(eventModel);
//     eventModelListBox.put('eventModelListBox', eventModels);
//     // await box.close();
//   }
//
//   static List<EventModel> recentlyEventLoad() {
//     var box = Hive.box('eventModelListBox');
//     return box.get('eventModelListBox');
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/logger.dart';
// import 'package:sense_flutter_application/models/event/event_model.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
// import 'package:sense_flutter_application/views/event_info/event_info_content.dart';
// import 'package:sense_flutter_application/views/event_info/event_info_header.dart';
// import 'package:sense_flutter_application/views/event_info/event_info_tab.dart';
//
// class EventInfoLoadView extends StatefulWidget {
//   int visitCount;
//   int recommendCount;
//   EventInfoLoadView({super.key, required this.visitCount, required this.recommendCount});
//
//   @override
//   State<EventInfoLoadView> createState() => _EventInfoLoadViewState();
// }
//
// class _EventInfoLoadViewState extends State<EventInfoLoadView> {
//
//   final GlobalKey<ScaffoldState> key = GlobalKey();
//   late Future onceRunFuture;
//
//   @override
//   void initState() {
//     onceRunFuture = _fetchData();
//     super.initState();
//   }
//
//   Future<EventModel> _fetchData() async {
//     EventModel result = await EventRequest().eventRequest(context.read<CreateEventImproveProvider>().eventUniqueId);
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     /// safe area height
//     final safeAreaTopPadding = MediaQuery.of(context).padding.top;
//     final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
//
//     return FutureBuilder(
//       future: onceRunFuture,
//       builder: (context, snapshot) {
//         if(snapshot.hasError) {
//           // return Text('hasError');
//           return const SizedBox.shrink();
//         } else if(snapshot.hasData) {
//           if(snapshot.connectionState == ConnectionState.waiting) {
//             // return Text('waiting');
//             return const SizedBox.shrink();
//           } else if(snapshot.connectionState == ConnectionState.done) {
//
//             EventModel loadEventModel = snapshot.data ?? EventModel();
//             context.read<CreateEventImproveProvider>().eventModelChange(loadEventModel);
//
//             String title = loadEventModel.eventTitle ?? '';
//             context.read<CreateEventImproveProvider>().eventDataLoad(
//               loadEventModel.eventTitle ?? '',
//               loadEventModel.eventCategoryObject!.id ?? -1,
//               loadEventModel.targetCategoryObject!.id ?? -1,
//               loadEventModel.eventDate ?? '',
//               loadEventModel.description ?? '',
//             );
//             context.read<CreateEventProvider>().cityInitLoad(loadEventModel.city!.id!);
//
//             SenseLogger().debug(
//               '${context.read<CreateEventImproveProvider>().title}\n' +
//               '${context.read<CreateEventImproveProvider>().category}\n' +
//                   '${context.read<CreateEventImproveProvider>().target}\n' +
//                   '${context.read<CreateEventImproveProvider>().date}\n' +
//                   '${context.read<CreateEventImproveProvider>().memo}\n'
//             );
//
//             return Column(
//               children: [
//                 /// 이벤트 타이틀 변경이 일어나면 헤더도 변화
//                 Consumer<CreateEventImproveProvider>(
//                   builder: (context, data, child) {
//                     String title = data.title;
//                     return EventInfoHeader(eventModel: loadEventModel, title: title);
//                   }
//                 ),
//                 EventInfoTabBar(),
//                 Expanded(child: ScrollConfiguration(
//                   behavior: const ScrollBehavior().copyWith(overscroll: false),
//                   child: SingleChildScrollView(child: EventContent(visitCount: widget.visitCount, recommendCount: widget.recommendCount)))),
//               ],
//             );
//
//           } else {
//             // return Text('else');
//             return const SizedBox.shrink();
//           }
//         } else {
//           // return Text('else2');
//           return const SizedBox.shrink();
//         }
//       }
//     );
//   }
// }
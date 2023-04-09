import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/feed/feed_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        FeedHeader(),
        FeedTagList(),
        FeedPostList(),
      ],
    );
  }
}

// class TestRegionNavigator extends StatefulWidget {
//   @override
//   _TestRegionNavigatorState createState() => _TestRegionNavigatorState();
// }

// class _TestRegionNavigatorState extends State<TestRegionNavigator> {
//   GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         debugPrint('onWillPop $_navigatorKey');
//         debugPrint('onWillPop ${_navigatorKey.currentState}');
//         if (_navigatorKey.currentState!.canPop()) {
//           _navigatorKey.currentState!.pop();
//           return false;
//         }
//         return true;
//       },
//       child: Navigator(
//         key: _navigatorKey,
//         onGenerateRoute: (RouteSettings settings) {
//           WidgetBuilder builder;
//           if (settings.name == '/feed') {
//             builder = (BuildContext context) => FeedScreen();
//           } else if (settings.name == '/feed_search') {
//             builder = (BuildContext context) => FeedSearchScreen();
//           } else {
//             throw Exception('Invalid route: ${settings.name}');
//           }
//           return MaterialPageRoute(builder: builder, settings: settings);
//         },
//       ),
//     );
//   }
// }

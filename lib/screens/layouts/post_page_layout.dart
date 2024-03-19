import 'package:sense_flutter_application/screens/widgets/app_bar/post_top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PostPageLayout extends ConsumerWidget {

  final String ?title;
  final Widget body;
  final Widget ?floating;
  final Function callBack;
  
  const PostPageLayout({super.key, required this.title, required this.body, this.floating, required this.callBack});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PostTopNavBar(callBack: callBack,),
      body: body,
      floatingActionButton: floating,
    );
  }
}

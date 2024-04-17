import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/store/providers/Post/single_post_collection_provider.dart';

class PostPageLayout extends ConsumerWidget {
  final String? title;
  final Widget body;
  final Widget? floating;
  final Widget? bottomNavigationBar;

  const PostPageLayout(
      {super.key, required this.body, this.title, this.floating, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(postNavigationHistoryProvider);
    print(history);

    return MaterialApp(
      theme: ThemeData(
          primaryColor: primaryColor[50],
          highlightColor: const Color.fromRGBO(200, 200, 200, 1),
          textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor[50]),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: Color.fromRGBO(187, 187, 187, 1),
            ),
          )),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: SvgPicture.asset('lib/assets/images/icons/svg/top_bar/caret-left.svg'),
              onPressed: () {
                if (history.isNotEmpty) {
                  final String route = history.last;
                  final list = history.toList();
                  list.removeLast();
                  ref.read(postLoadingProvider.notifier).state = true;
                  ref.read(singlePostProvider.notifier).fetchPost(route).then((value) {
                    ref.read(postNavigationHistoryProvider.notifier).state = list;
                  });
                  GoRouter.of(context).pop();
                } else {
                  GoRouter.of(context).go('/home');
                }
              }),
          shape: const Border(bottom: BorderSide(width: 1, color: Color(0xFFEEEEEE))),
          title: Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: body,
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floating,
      ),
    );
  }
}

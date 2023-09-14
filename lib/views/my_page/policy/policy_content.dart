import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyContent extends StatefulWidget {
  const PolicyContent({super.key});

  @override
  State<PolicyContent> createState() => _PolicyContentState();
}

class _PolicyContentState extends State<PolicyContent> {

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: "### title test",
    );
    // return FutureBuilder(
    //   future: rootBundle.loadString('assets/policy/policy01.md'),
    //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //     if(snapshot.hasData) {
    //       return Markdown(
    //         data: snapshot.data!,
    //         styleSheet: MarkdownStyleSheet(
    //           h1: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400),
    //           h2: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w400),
    //           blockquoteDecoration: BoxDecoration(
    //             color: Colors.grey,
    //           ),
    //         ),
    //       );
    //     } else if(snapshot.hasError) {
    //       return Text('no data..');
    //     } else {
    //       return Text('no data..');
    //     }
    //   }
    // );
  }
}

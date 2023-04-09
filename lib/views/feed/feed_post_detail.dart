import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  // final Post post;

  const PostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hi'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('hello'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ContactFriendScreen extends StatefulWidget {
  const ContactFriendScreen({Key? key}) : super(key: key);

  @override
  State<ContactFriendScreen> createState() => _ContactFriendScreenState();
}

class _ContactFriendScreenState extends State<ContactFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Placeholder(),
          Text('피카츄라이츄파이리꼬부기버터플야도란피죤투또가스'),
        ]
      ),
    );
  }
}

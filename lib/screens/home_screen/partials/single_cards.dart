
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/screens/widgets/common/post_card.dart';

class SingleCards extends StatelessWidget {

  const SingleCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 16),
      constraints: const BoxConstraints(
        maxWidth: 500
      ),
      child: Column(
        children: [
        ...List.generate(10, 
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PostCard(
              subject: '향기 가득한 입생로랑 리브르 르 퍼퓸 - ${index + 1}',
              subtext: '향기 가득한 입생로랑 리브르 르 퍼퓸 외 5종',)
            ),
          )
      ],),
    );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridCards extends StatelessWidget {
  const GridCards({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    int columns = 2;

    if (screenSize.width >= 600 && screenSize.width < 1200) {
      columns = 3;
    } else if (screenSize.width >= 1200) {
      columns = 6;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // Number of columns
        childAspectRatio: 162/212, // Aspect ratio of each item
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),

      // addAutomaticKeepAlives: false,
      // crossAxisSpacing: 12,
      // mainAxisSpacing: 16,
      itemCount: 20,
      itemBuilder: ((context, index) {
        return GridCard(
          image: 'lib/assets/images/card_image.png',
          title: 'Title',
          description: 'Description',
        );
      }),
    );
  }
}

class GridCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const GridCard({super.key, 
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    //  Text('향기 가득한 입생로랑 리브르 르 퍼퓸 5종류의 선물')
    return 

    Column(
        children: [
         Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('lib/assets/images/card_image.png'),
                fit: BoxFit.cover
              ),
            ),
          ),
         ),
          SizedBox(height: 10),
          Text('향기 가득한 입생로랑 리브르 르 퍼퓸 5종류의 선물')
        ],
      );
  }
}
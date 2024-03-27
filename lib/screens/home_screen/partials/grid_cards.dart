import 'package:flutter/material.dart';

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

    return GridView.count(
      crossAxisCount: columns,
      children: List.generate(20, (index) => GridCard(
          image: 'lib/assets/images/card_image.png',
          title: 'Title',
          description: 'Description',
        ),),
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
    return Card(
      child: Column(
        children: [
          Expanded(child: Image.asset('lib/assets/images/card_image.png')),
        ],
      ),
    );
  }
}
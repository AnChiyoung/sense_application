
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {

  final String subject;
  final String ?subtext;

  const PostCard({super.key, required this.subject, this.subtext});

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 335/398,
            child: 
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 2), // Shadow position
                      blurRadius: 4,
                    )
                  ],
                  image: DecorationImage(image: AssetImage('lib/assets/images/card_image.png'), fit: BoxFit.cover)
                ),
              ),
          ),
          Container(
            // height: 88,
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              color: Color.fromRGBO(238, 238, 238, 1),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  offset: Offset(0, 2), // Shadow position
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: 
                    const TextStyle(
                      color: Color(0xFF151515),
                      overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w700
                    ),
                  ),
                const SizedBox(height: 6),
                Text(
                  subtext ?? '',
                  style: 
                    const TextStyle(
                      color: Color(0xFF333333),
                      overflow: TextOverflow.ellipsis, fontSize: 12, fontWeight: FontWeight.w400
                    ),
                ),
              ],
            ),
          )
        ],
      );
  }
}
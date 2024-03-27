
import 'package:flutter/material.dart';

class BannerArea extends StatefulWidget {

  final List<Widget> children;

  const BannerArea({super.key, required this.children});
  
  @override
  State<BannerArea> createState() => _BannerAreaState();
}

class _BannerAreaState extends State<BannerArea> {

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    int BannerAreaCount =  widget.children.length;
  
    return 
      Stack(
      children: [
        Positioned(
          child: 
            AspectRatio(
              aspectRatio: 375 / 240,
              child: 
                PageView(
                  onPageChanged: (value) {
                    setState(() {
                      counter = value + 1;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  children: widget.children,
                )
          ),
        ),
        Positioned( 
          bottom: 21,
          right: 20,
          child: 
            Chip(
              label: 
                Text(
                  '$counter/$BannerAreaCount',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 0
                  ),
                ),
              padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
              side: BorderSide.none,
              backgroundColor: const Color.fromRGBO(21, 21, 21, 0.60),
            )
        )
      ],
    );
  }
}
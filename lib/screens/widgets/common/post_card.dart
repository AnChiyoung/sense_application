import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class PostCard extends StatelessWidget {
  final String subject;
  final String? subtext;
  final String thumbnail;
  final VoidCallback onTap;

  const PostCard(
      {super.key, required this.subject, this.subtext, this.thumbnail = '', required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 335 / 398,
            child: CachedNetworkImage(
              imageUrl: thumbnail,
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: primaryColor[50],
              )),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0, 2), // Shadow position
                        blurRadius: 4,
                      )
                    ],
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
              ),
            ),
          ),
          Container(
            // height: 88,
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
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
                  subject.replaceAll('\n', ' '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Color(0xFF151515),
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  subtext ?? '',
                  style: const TextStyle(
                      color: Color(0xFF333333),
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

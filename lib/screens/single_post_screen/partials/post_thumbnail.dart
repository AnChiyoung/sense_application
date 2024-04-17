import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostThumbnail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String date;
  final String likeCount;

  const PostThumbnail(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.date,
      this.likeCount = '0'});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 420,
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(21, 21, 21, 0.60),
                  Color.fromRGBO(21, 21, 21, 0.00),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subTitle,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 24),
                        IntrinsicHeight(
                            child: Row(
                          children: [
                            Text(date,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500)),
                            const VerticalDivider(
                              color: Colors.white,
                              thickness: 1,
                              width: 20,
                            ),
                            SvgPicture.asset('lib/assets/images/icons/svg/heart.svg',
                                width: 16, height: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(likeCount,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500))
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

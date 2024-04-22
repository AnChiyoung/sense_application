import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_toast.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class RelatedPost extends StatelessWidget {
  final List<dynamic> relatedPosts;
  final Function onNavigate;
  final int? prevPostId;
  final int? nextPostId;

  const RelatedPost({
    super.key,
    required this.relatedPosts,
    required this.onNavigate,
    required this.prevPostId,
    required this.nextPostId,
  });

  List<List<T>> chunk<T>(List<T> list, int chunkSize) {
    var length = list.length;
    List<List<T>> chunks = [];

    for (int i = 0; i < length; i += chunkSize) {
      int end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(list.sublist(i, end));
    }

    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    PageController scrollController = PageController();

    List<List<dynamic>> chunkedPosts = chunk(relatedPosts, 2);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '관련 게시글',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 26,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          scrollController.previousPage(
                              duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        },
                        child: const Text(
                          '이전',
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Color(0XFFE0E0E0),
                        thickness: 1,
                      ),
                      InkWell(
                        onTap: () {
                          scrollController.nextPage(
                              duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        },
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 209,
          child: PageView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: chunkedPosts.length,
            itemBuilder: (context, index) {
              return Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildRelatedPosts(chunkedPosts[index]),
              );
            },
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Row(
          children: [
            Expanded(
                child: CustomButton(
              prefixIcon: const Icon(
                Icons.arrow_back_ios,
                size: 16,
                color: Color(0xFF555555),
              ),
              height: 40,
              textColor: const Color(0xFF555555),
              onPressed: () {
                if (prevPostId != null) {
                  GoRouter.of(context).pushReplacement('/post/${prevPostId ?? ''}');
                } else {
                  CustomToast.warningToast(context, '이전 게시물이 없습니다.');
                }
              },
              backgroundColor: const Color(0xFFF6F6F6),
              labelText: '이전 글',
              fontSize: 12,
            )),
            Expanded(
                child: CustomButton(
              suffixIcon: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF555555),
              ),
              height: 40,
              textColor: const Color(0xFF555555),
              onPressed: () {
                if (nextPostId != null) {
                  GoRouter.of(context).pushReplacement('/post/${nextPostId ?? ''}');
                } else {
                  CustomToast.warningToast(context, '다음 게시물이 없습니다.');
                }
              },
              backgroundColor: const Color(0xFFF6F6F6),
              labelText: '다음 글',
              fontSize: 12,
            ))
          ],
        )
      ],
    );
  }

  List<Widget> buildRelatedPosts(List<dynamic> chunkedPosts) {
    List<Widget> relatedPosts = [];
    for (var i = 0; i < chunkedPosts.length; i++) {
      relatedPosts.add(Expanded(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: chunkedPosts[i]['thumbnail_media_url'] ?? '',
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: primaryColor[50] ?? Colors.white,
              )),
              imageBuilder: (context, imageProvider) => InkWell(
                onTap: () {
                  onNavigate();
                  GoRouter.of(context).push('/post/${chunkedPosts[i]['id']}');
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 8 + 10, right: 8 + 10),
                  height: 161,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    (chunkedPosts[i]['title'] ?? '').replaceAll('\n', ' '),
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    chunkedPosts[i]['sub_title'] ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF777777),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            )
          ],
        ),
      ));
      if (i % 2 == 0) {
        // relatedPosts.add(const SizedBox(
        //   width: 16,
        // ));
      }

      if (chunkedPosts.length == 1) {
        relatedPosts.add(Expanded(child: Container()));
      }
    }
    return relatedPosts;
  }
}

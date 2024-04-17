import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class StoreProducts extends StatelessWidget {
  final List<dynamic> storeProducts;
  final Null Function(int productId, bool value)? likedProduct;
  const StoreProducts({super.key, required this.storeProducts, this.likedProduct});

  @override
  Widget build(BuildContext context) {
    // print(storeProducts[0]['product_review_data']);
    int size = storeProducts.length;
    return Column(
        children: List.generate(size, (index) {
      return Column(
        children: [
          ProductCard(
            id: storeProducts[index]['id'],
            imageUrl: storeProducts[index]['product_thumbnail_image_url'] ?? '',
            title: storeProducts[index]['title'] ?? '',
            subTitle: storeProducts[index]['sub_title'] ?? '',
            price: storeProducts[index]['price'].toString(),
            category: storeProducts[index]['product_category'] ?? '',
            rating: storeProducts[index]['grade'].toString(),
            isLike: storeProducts[index]['is_liked'] ?? false,
            review: storeProducts[index]['product_review_data'] ?? [],
            actionEvent: (event, value) => {
              if (event == 'like') {likedProduct!(value['id'], value['value'])}
            },
          ),
          if (size - 1 != index) const SizedBox(height: 16)
        ],
      );
    }).toList());
  }
}

class ProductCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final String subTitle;
  final String price;
  final String? category;
  final String? rating;
  final bool isLike;
  final List<dynamic> review;
  final Set<void> Function(String event, dynamic value) actionEvent;

  const ProductCard(
      {super.key,
      required this.id,
      this.imageUrl = '',
      required this.title,
      required this.subTitle,
      required this.price,
      this.category,
      required this.rating,
      this.isLike = false,
      required this.review,
      required this.actionEvent});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mapReview = review.firstOrNull ?? {};

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: const Color(0xFFEEEEEE),
          decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              image: imageUrl.isEmpty
                  ? null
                  : DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)),
          width: 129,
          height: 129,
          // color: const Color(0xFFEEEEEE),
          child: imageUrl.isEmpty
              ? const Center(
                  child: Icon(Icons.image, color: Color(0xFFBBBBBB), size: 40),
                )
              : const SizedBox(),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 22,
                    child: TextButton(
                        onPressed: () => {},
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(right: 6, left: 6, top: 0, bottom: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: primaryColor[50] ?? Colors.white)),
                            side: BorderSide(color: primaryColor[50] ?? Colors.white)),
                        child: Text(category ?? '',
                            style: TextStyle(fontSize: 12, color: primaryColor[50]))),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'lib/assets/images/icons/svg/cart.svg',
                        // color: primaryColor[50],
                        width: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                          onTap: () => {
                                actionEvent('like', {"id": id, "value": !isLike}),
                              },
                          child: SvgPicture.asset(
                            isLike
                                ? 'lib/assets/images/icons/svg/heart_fill.svg'
                                : 'lib/assets/images/icons/svg/heart.svg',
                            color: isLike ? const Color(0xFFF23B3B) : const Color(0xFF555555),
                            width: 18,
                          ))
                    ],
                  )
                ],
              ),
              Text(title,
                  style: const TextStyle(
                      color: Color(0xFF151515),
                      fontSize: 16,
                      height: 1.8,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis)),
              // const SizedBox(
              //   height: 4,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'lib/assets/images/icons/svg/pin.svg',
                    width: 16,
                  ),
                  const Expanded(
                      child: Text(
                    '경기 성남시 삼평동 우림W시티 3층 302호',
                    style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
                  ))
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset(
                    'lib/assets/images/icons/svg/star.svg',
                    width: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    rating ?? '0.0',
                    style: const TextStyle(color: Color(0xFF555555), fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 9,
              ),
              if (mapReview.isNotEmpty)
                Container(
                  padding: const EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
                  ),
                  child: Row(
                    children: [
                      // Review User Name
                      Text(mapReview['user']?['username'] ?? mapReview['user']?['email'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF777777))),
                      const SizedBox(
                        width: 4,
                      ),

                      // Review content
                      Expanded(
                          child: Text('${mapReview['content'] ?? ''}',
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999))))
                    ],
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}

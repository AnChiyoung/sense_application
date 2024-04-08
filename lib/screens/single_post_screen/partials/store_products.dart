import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class StoreProducts extends StatelessWidget {
  final List<dynamic> storeProducts;
  final Null Function(int productId)? likedProduct;
  const StoreProducts({super.key, required this.storeProducts, this.likedProduct});

  @override
  Widget build(BuildContext context) {
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
            discount: '1',
            rating: storeProducts[index]['grade'].toString(),
            isLike: storeProducts[index]['is_liked'] ?? false,
            actionEvent: (event, value) => {
              print('event: $event, value: $value'),
              if (event == 'like') {likedProduct!(value['id'])}
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
  final String? discount;
  final String? rating;
  final bool isLike;
  final Set<void> Function(String event, dynamic value) actionEvent;

  const ProductCard(
      {super.key,
      required this.id,
      this.imageUrl = '',
      required this.title,
      required this.subTitle,
      required this.price,
      this.discount,
      required this.rating,
      this.isLike = false,
      required this.actionEvent});

  @override
  Widget build(BuildContext context) {
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
                        child: Text('멕시코 요리',
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
                            color: primaryColor[50],
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
                  const Text(
                    '4.3',
                    style: TextStyle(color: Color(0xFF555555), fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 9,
              ),
              Container(
                padding: const EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
                ),
                child: const Row(
                  children: [
                    Text('김영하',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF777777))),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Text(
                            '타코야끼집이여서 갔는데 타코가 더 맛있어요~! 주문팁은 왕타코맛있어요! 라고 외치시면 바니가 서비스 많이 줍니다. 소스를 좋아하는데 바니 사장님이 소스도 많이 주시기도하고 서비스로 감자튀김도 주셨는데 이것도 다른 집 감자튀김이랑 뭔가 달라요 엄청 부드럽고 맛있어요 저 지금 수정중입니다...',
                            style: TextStyle(
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

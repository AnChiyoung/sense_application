import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class FeedFlexible extends StatefulWidget {
  const FeedFlexible({super.key});

  @override
  State<FeedFlexible> createState() => _FeedFlexibleState();
}

class _FeedFlexibleState extends State<FeedFlexible> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Column(
        children: [
          Text('핀란드어로 꽃을 의미하는 KUKKA는 일상에서도 꽃을 즐기는 문화를 지향하는 플라워 기반 라이프 스타일 브랜드예요. 특별한 날은 더 특별하게, 평범한 날에도 꽃을 더해 특별하게 만들어주고 있어요. 꽃을 일상에서 자연스럽게 즐기는 핀란드의 꽃문화를 꾸까만의 방식으로 한국에 전파하고 있죠.',
            style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 16.0.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://cf.sens.im/media/sense/image/20230912T064338.png',
            )
          ),
          SizedBox(height: 16.0.h),
          Text('또한 꾸까에서는 꽃과 관련된 다양한 서비스를 제공하고 있습니다. 꽃다발, 꽃바구니부터 화병이나 머그컵, 꽃 관리를 위한 도구들도 살펴볼 수 있어요. 여기에 온라인으로 클래스를 들으면서 만들어 볼 수 있는 DIY키트도 있기 때문에 말 그대로 꽃에 관련한 모든 것을 만나볼 수 있는 셈이죠.\n\n이제는 꽃도 구독하는 시대\n\n다양한 구독 상품에 익숙한 지금, 꾸까에서는 꽃도 구독으로 받아볼 수 있습니다. 한 번만 신청해두면 내가 원하는 주기마다 전문 플로리스트가 엄선한 꽃을 받아볼 수 있어요.\n내가 정한 기간마다 새로운 꽃들로 꾸며지는 공간을 보며 행복을 만끽할 수 있습니다. 여기에 꾸까의 시그니처 화병과 영양제도 무료로 제공되고, 최대 10%까지 할인된 가격으로 꽃을 받아볼 수 있기 때문에 합리적이라고도 할 수 있고요.',
            style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 16.0.h),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: CachedNetworkImage(
                imageUrl: 'https://cf.sens.im/media/sense/image/20230912T064502.png',
              )
          ),
          SizedBox(height: 16.0.h),
          Text('꾸까에서는 기업, 브랜드를 대상으로도 다양한 서비스를 제공하고 있어요. 직원들의 생일에 자동으로 꽃을 선물하는 서비스부터 사내복지를 위한 플라워 솔루션과 브랜드의 개성을 꽃으로 표현한 프로모션 패키지도 있죠. 꾸까의 서비스를 경험하고 난 후에는 일상 속 작은 이벤트때마다 자연스럽게 꽃이 생각날 거예요.',
            style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w400),
          )
        ]
      ),
    );
  }
}

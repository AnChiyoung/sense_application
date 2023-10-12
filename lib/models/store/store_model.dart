// import 'package:http/http.dart' as http;
//
// class StoreRequest {
//   // 상품 모델 리스트 불러옴
//   Future<List<EventModel>> eventListRequest([int? selectMonth, int? selectYear]) async {
//
//     String monthQuery = '';
//     String yearQuery = '';
//
//     if(selectMonth != null) {
//       monthQuery = '?month=${selectMonth.toString()}';
//     }
//
//     if(selectYear != null) {
//       yearQuery = '&year=${selectYear.toString()}';
//     }
//
//     SenseLogger().debug('${ApiUrl.releaseUrl}/events$monthQuery$yearQuery');
//
//     final response = await http.get(
//       Uri.parse('${ApiUrl.releaseUrl}/events$monthQuery$yearQuery&is_participated=true'),
//       headers: {
//         'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//     );
//
//     if(response.statusCode == 200 || response.statusCode == 201) {
//       SenseLogger().debug('success to event list load');
//       List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
//       List<EventModel> models = body.isEmpty || body == null ? [] : body.map((e) => EventModel.fromJson(e)).toList();;
//       return models;
//     } else {
//       SenseLogger().debug('fail to event list load');
//       return [];
//     }
//   }
// }
//
// // 상품 모델
// class ProductModel {
//   int? id;
//   String? imageUrl;
//   String? brandTitle;
//   String? title;
//   String? originPrice;
//   String? discountPrice;
//   String? discountRate;
//
//   ProductModel({
//     this.id = -1,
//     this.imageUrl = '',
//     this.brandTitle = '',
//     this.title = '',
//     this.originPrice = '',
//     this.discountPrice = '',
//     this.discountRate = '',
//   });
//
//   ProductModel.fromJson(dynamic json) {
//     id = json["id"] ?? -1;
//     imageUrl = json["image_url"] ?? '';
//     brandTitle = json["brand_title"] ?? '';
//     title = json["title"] ?? '';
//     originPrice = json["origin_price"] ?? '';
//     discountPrice = json["discount_price"] ?? '';
//     discountRate = json["discount_rate"] ?? '';
//   }
// }
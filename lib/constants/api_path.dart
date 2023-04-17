/// url 및 params 정책은 백엔드 개발자와 상의한다.
/// server base url은 하위 슬래시까지 표기 x : sense/api
/// api url은 하위 슬래시까지 표기 x : base url + /login/kakao

class ApiUrl {
  static const String baseUrl = 'https://dev.server.sense.runners.im/api/v1';
  static String teddy01 = '$baseUrl/kakao/login';
// post create event model
  static String createEventPath = '$baseUrl/event';
  static String recommendListPath = '$baseUrl/suggestions?recommend_type=';
}
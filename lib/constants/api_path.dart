/// url 및 params 정책은 백엔드 개발자와 상의한다.
/// server base url은 하위 슬래시까지 표기 x : sense/api
/// api url은 하위 슬래시까지 표기 x : base url + /login/kakao

class ApiUrl {
  static String devUrl = 'https://dev.server.sense.runners.im/api/v1/';
  static String stagingUrl = 'https://stg.server.sense.runners.im/api/v1';
// post create event model
  static String createEventPath = '$devUrl/event';
  static String recommendListPath = '$devUrl/suggestions?recommend_type=';
}
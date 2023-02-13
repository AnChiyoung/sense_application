/// url 및 params 정책은 백엔드 개발자와 상의한다.
/// server base url은 하위 슬래시까지 표기 x : sense/api
/// api url은 하위 슬래시까지 표기 x : base url + /login/kakao

String serverBaseUrl = 'dev.server.sense.runners.im/api/v1';
String teddy01 = serverBaseUrl + '/kakao/login';
// 각자 기입. 변수명 자유롭게
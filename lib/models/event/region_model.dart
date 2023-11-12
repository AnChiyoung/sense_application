import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/constants/api_path.dart';

class RegionRequest {

  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 50,
      colors: false,
      printTime: true,
    ),
  );

  Future<List<City>> cityListRequest() async {

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/business/cities'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('city 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<City> models = body.isEmpty ? [] : body.map((e) => City.fromJson(e)).toList();
      return models;
    } else {
      logger.v('city 불러오기 실패');
      return [];
    }
  }

  Future<List<SubCity>> subCityListRequest(String cityNumber) async {

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/business/city/$cityNumber/subcities'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('subcity 불러오기 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<SubCity> models = body.isEmpty ? [] : body.map((e) => SubCity.fromJson(e)).toList();
      return models;
    } else {
      logger.v('subcity 불러오기 실패');
      return [];
    }
  }
}

class City {
  int? id;
  String? title;

  City({
    this.id,
    this.title,
  });

  City.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

class SubCity {
  int? id;
  String? title;

  SubCity({
    this.id,
    this.title,
  });

  SubCity.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

/// local region 20230810
class LocalRegionModel {
  String? cityName;
  List<String>? subCityList = [];

  LocalRegionModel({
    this.cityName,
    this.subCityList,
  });

  LocalRegionModel.fromJson(dynamic json) {
    cityName = json['city'] ?? '';
    subCityList = json['subCity'] ?? [];
  }
}

var regionDummyModel = [
  {'city': '서울',
    'subCity': [
      '강남', '삼성', '송파', '교대',
      '시청', '명동',
      '종로', '인사동', '동대문', '강북',
      '서대문', '신촌', '용산', '이태원',
      '영등포', '구로', '금천', '김포공항',
      '건대', '성수', '천호',
    ]
  },
  {'city': '경기',
    'subCity': [
      '수원', '인계', '동탄',
      '용인', '여주', '이천',
      '부천', '성남', '안양',
      '고양', '파주', '김포', '의정부',
      '가평', '양평', '포천',
    ]
  },
  {'city': '인천',
    'subCity': [
      '송도', '소래포구', '구월',
      '인천공항', '영종도', '월미도',
      '부평', '계양', '서구',
      '강화', '웅진',
    ]
  },
  {'city': '강원',
    'subCity': [
      '속초', '양양', '고성',
      '강릉', '동해', '삼척',
      '평창', '정선', '원주', '횡성',
      '춘천', '홍천', '인제', '철원',
    ]
  },
  {'city': '경상',
    'subCity': [
      '경주', '포항', '영덕',
      '울산', '창원', '김해', '진주',
      '대구', '문경', '구미', '영주',
    ]
  },
  {'city': '전라',
    'subCity': [
      '여수', '광양', '순천',
      '전주', '군산', '부안', '남원',
      '광주', '목포', '나주', '담양',
    ]
  },
  {'city': '충청',
    'subCity': [
      '유성구', '청주', '세종',
      '천안', '아산',
      '단양', '충주', '제천', '괴산',
      '안면도', '꽃지', '몽산포',
    ]
  },
  {'city': '부산',
    'subCity': [
      '해운대', '센텀', '송정', '기장',
      '광안리', '연제',
      '부산역', '남포동', '자갈치',
      '서면', '동래', '금정', '남구',
      '사상', '강서', '사하',
    ]
  },
  {'city': '제주',
    'subCity': [
      '제주공항', '협재', '함덕',
      '중문', '표선', '성산',
    ]
  },
];
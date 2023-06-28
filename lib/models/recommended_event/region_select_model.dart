class RegionModel {
  String regionList;
  List<Set<String>> subRegionList;

  RegionModel({
    required this.regionList,
    required this.subRegionList,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      regionList: json['regionList'] as String,
      subRegionList: json['subRegionList'] as List<Set<String>>,
    );
  }

  Map<String, dynamic> toJson() => {
    'regionList': regionList,
    'subRegionList': subRegionList,
  };
}

var regionDummyModel = [
  {'regionList': '서울',
    'subRegionList': [
      {'서울 전체'},
      {'강남', '삼성', '송파', '교대'},
      {'시청', '명동'},
      {'종로', '인사동', '동대문', '강북'},
      {'서대문', '신촌', '용산', '이태원'},
      {'영등포', '구로', '금천', '김포공항'},
      {'건대', '성수', '천호'},
    ]
  },
  {'regionList': '경기',
    'subRegionList': [
      {'경기 전체'},
      {'수원', '인계', '동탄'},
      {'용인', '여주', '이천'},
      {'부천', '성남', '안양'},
      {'고양', '파주', '김포', '의정부'},
      {'가평', '양평', '포천'},
    ]
  },
  {'regionList': '인천',
    'subRegionList': [
      {'인천 전체'},
      {'송도', '소래포구', '구월'},
      {'인천공항', '영종도', '월미도'},
      {'부평', '계양', '서구'},
      {'강화', '웅진'},
    ]
  },
  {'regionList': '강원',
    'subRegionList': [
      {'강원 전체'},
      {'속초', '양양', '고성'},
      {'강릉', '동해', '삼척'},
      {'평창', '정선', '원주', '횡성'},
      {'춘천', '홍천', '인제', '철원'},
    ]
  },
  {'regionList': '경상',
    'subRegionList': [
      {'경상 전체'},
      {'경주', '포항', '영덕'},
      {'울산', '창원', '김해', '진주'},
      {'대구', '문경', '구미', '영주'},
    ]
  },
  {'regionList': '전라',
    'subRegionList': [
      {'전라 전체'},
      {'여수', '광양', '순천'},
      {'전주', '군산', '부안', '남원'},
      {'광주', '목포', '나주', '담양'},
    ]
  },
  {'regionList': '충청',
    'subRegionList': [
      {'충청 전체'},
      {'유성구', '청주', '세종'},
      {'천안', '아산'},
      {'단양', '충주', '제천', '괴산'},
      {'안면도', '꽃지', '몽산포'},
    ]
  },
  {'regionList': '부산',
    'subRegionList': [
      {'부산 전체'},
      {'해운대', '센텀', '송정', '기장'},
      {'광안리', '연제'},
      {'부산역', '남포동', '자갈치'},
      {'서면', '동래', '금정', '남구'},
      {'사상', '강서', '사하'},
    ]
  },
  {'regionList': '제주',
    'subRegionList': [
      {'제주 전체'},
      {'제주공항', '협재', '함덕'},
      {'중문', '표선', '성산'},
    ]
  },
];
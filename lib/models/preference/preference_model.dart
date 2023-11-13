enum EnumPreferenceType {
  food('음식'),
  lodging('숙소'),
  travel('여행');

  final String value;
  const EnumPreferenceType(this.value);
}

///
/// 음식 취향 어드민 리스트
///
class PreferenceFoodModel {
  final int id;
  final String title;
  final String imageUrl;

  PreferenceFoodModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory PreferenceFoodModel.fromJson(Map<String, dynamic> json) {
    return PreferenceFoodModel(
      id: json['id'] ?? -1,
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
      };

  @override
  String toString() => 'PreferenceFoodModel(id: $id, title: $title, imageUrl: $imageUrl)';
}

enum EnumPreferenceTasteType {
  sweet('단맛'),
  salty('짠맛'),
  spicy('매운맛');

  final String value;
  const EnumPreferenceTasteType(this.value);
}

class PreferenceTasteModel {
  final int id;
  final EnumPreferenceTasteType type;
  final String title;
  final String imageUrl;

  PreferenceTasteModel({
    required this.id,
    required this.type,
    required this.title,
    required this.imageUrl,
  });

  factory PreferenceTasteModel.fromJson(Map<String, dynamic> json) {
    return PreferenceTasteModel(
      id: json['id'] ?? -1,
      type: EnumPreferenceTasteType.values.firstWhere(
        (element) => element.value == json['type'],
        orElse: () => EnumPreferenceTasteType.sweet,
      ),
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.value,
        'title': title,
        'image_url': imageUrl,
      };

  @override
  String toString() =>
      'PreferenceTasteModel(id: $id, type: $type, title: $title, imageUrl: $imageUrl)';
}

///
/// 숙소 취향 어드민 리스트
///
enum EnumPreferenceLodgingType {
  environments('환경'),
  options('옵션'),
  types('타입');

  final String value;
  const EnumPreferenceLodgingType(this.value);
}

class PreferenceLodgingModel {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;

  PreferenceLodgingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  factory PreferenceLodgingModel.fromJson(Map<String, dynamic> json) {
    return PreferenceLodgingModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      subtitle: json['sub_title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'sub_title': subtitle,
        'image_url': imageUrl,
      };

  @override
  String toString() =>
      'PreferenceLodgingModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl)';
}

///
/// 여행 취향 어드민 리스트
///
enum EnumPreferenceTravelType {
  distance('옵션'),
  environments('환경'),
  mates('메이트');

  final String value;
  const EnumPreferenceTravelType(this.value);
}

class PreferenceTravelModel {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;

  PreferenceTravelModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  factory PreferenceTravelModel.fromJson(Map<String, dynamic> json) {
    return PreferenceTravelModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      subtitle: json['sub_title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'sub_title': subtitle,
        'image_url': imageUrl,
      };

  @override
  String toString() =>
      'PreferenceTravelModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl)';
}

///
/// 유저 취향 전체 목록
///
class UserPreferenceListItemModel {
  final int id;
  final String imageUrl;
  final EnumPreferenceType type;
  final String title;
  final String content;

  UserPreferenceListItemModel({
    required this.id,
    required this.imageUrl,
    required this.type,
    required this.title,
    required this.content,
  });

  factory UserPreferenceListItemModel.fromJson(Map<String, dynamic> json) {
    return UserPreferenceListItemModel(
      id: json['id'] ?? -1,
      imageUrl: json['image_url'] ?? '',
      type: EnumPreferenceType.values.firstWhere(
        (element) => element.value == json['type'],
        orElse: () => EnumPreferenceType.food,
      ),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_url': imageUrl,
        'type': type.value,
        'title': title,
        'content': content,
      };

  @override
  String toString() =>
      'UserPreferenceListItemModel(id: $id, imageUrl: $imageUrl, type: $type, title: $title, content: $content)';
}

///
/// 유저 음식 취향
///
class UserFoodPreferenceModel {
  final int id;
  final int user;
  final EnumPreferenceType type = EnumPreferenceType.food;
  final String title;
  final String content;
  final String dislikeMemo;
  List<UserFoodPreferenceFood> foods;
  List<UserFoodPreferenceTaste> spicyTastes;
  List<UserFoodPreferenceTaste> sweetTastes;
  List<UserFoodPreferenceTaste> saltyTastes;

  UserFoodPreferenceModel({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.dislikeMemo,
    this.foods = const [],
    this.spicyTastes = const [],
    this.sweetTastes = const [],
    this.saltyTastes = const [],
  });

  factory UserFoodPreferenceModel.fromJson(Map<String, dynamic> json) {
    return UserFoodPreferenceModel(
      id: json['id'] ?? -1,
      user: json['user'] ?? -1,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      dislikeMemo: json['dislike_memo'] ?? '',
      foods: List<UserFoodPreferenceFood>.from(
          json['foods'].map((x) => UserFoodPreferenceFood.fromJson(x))),
      spicyTastes: List<UserFoodPreferenceTaste>.from(
          json['spicy_tastes'].map((x) => UserFoodPreferenceTaste.fromJson(x))),
      sweetTastes: List<UserFoodPreferenceTaste>.from(
          json['sweet_tastes'].map((x) => UserFoodPreferenceTaste.fromJson(x))),
      saltyTastes: List<UserFoodPreferenceTaste>.from(
          json['salty_tastes'].map((x) => UserFoodPreferenceTaste.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'type': type.value,
        'title': title,
        'content': content,
        'dislike_memo': dislikeMemo,
        'foods': foods.map((x) => x.toJson()).toList(),
        'spicy_tastes': spicyTastes.map((x) => x.toJson()).toList(),
        'sweet_tastes': sweetTastes.map((x) => x.toJson()).toList(),
        'salty_tastes': saltyTastes.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() =>
      'UserFoodPreferenceModel(id: $id, user: $user, type: $type, title: $title, content: $content, dislikeMemo: $dislikeMemo, foods: $foods, spicyTastes: $spicyTastes, sweetTastes: $sweetTastes, saltyTastes: $saltyTastes)';
}

class UserFoodPreferenceFood {
  final int id;
  final String title;
  final String foodImageUrl;

  UserFoodPreferenceFood({
    required this.id,
    required this.title,
    required this.foodImageUrl,
  });

  factory UserFoodPreferenceFood.fromJson(Map<String, dynamic> json) {
    return UserFoodPreferenceFood(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      foodImageUrl: json['food_image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'food_image_url': foodImageUrl,
      };

  @override
  String toString() =>
      'UserFoodPreferenceFood(id: $id, title: $title, foodImageUrl: $foodImageUrl)';
}

class UserFoodPreferenceTaste {
  final int id;
  final String title;
  final EnumPreferenceTasteType type;

  UserFoodPreferenceTaste({
    required this.id,
    required this.title,
    required this.type,
  });

  factory UserFoodPreferenceTaste.fromJson(Map<String, dynamic> json) {
    return UserFoodPreferenceTaste(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      type: EnumPreferenceTasteType.values.firstWhere(
        (element) => element.value == json['type'],
        orElse: () => EnumPreferenceTasteType.sweet,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type.value,
      };

  @override
  String toString() => 'UserFoodPreferenceTaste(id: $id, title: $title, type: $type)';
}

///
/// 유저 숙소 취향
///
class UserLodgingPreferenceModel {
  final int id;
  final int user;
  final EnumPreferenceType type = EnumPreferenceType.lodging;
  final String title;
  final String content;
  final String dislikeMemo;
  List<LodgingPreferenceItem> environments;
  List<LodgingPreferenceItem> options;
  List<LodgingPreferenceItem> types;

  UserLodgingPreferenceModel({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.dislikeMemo,
    this.environments = const [],
    this.options = const [],
    this.types = const [],
  });

  factory UserLodgingPreferenceModel.fromJson(Map<String, dynamic> json) {
    return UserLodgingPreferenceModel(
      id: json['id'] ?? -1,
      user: json['user'] ?? -1,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      dislikeMemo: json['dislike_memo'] ?? '',
      environments: List<LodgingPreferenceItem>.from(
          json['environments'].map((x) => LodgingPreferenceItem.fromJson(x))),
      options: List<LodgingPreferenceItem>.from(
          json['options'].map((x) => LodgingPreferenceItem.fromJson(x))),
      types: List<LodgingPreferenceItem>.from(
          json['types'].map((x) => LodgingPreferenceItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'type': type.value,
        'title': title,
        'content': content,
        'dislike_memo': dislikeMemo,
        'environments': environments.map((x) => x.toJson()).toList(),
        'options': options.map((x) => x.toJson()).toList(),
        'types': types.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() =>
      'UserLodgingPreferenceModel(id: $id, user: $user, type: $type, title: $title, content: $content, dislikeMemo: $dislikeMemo, environments: $environments, options: $options, types: $types)';
}

class LodgingPreferenceItem {
  final int id;
  final String title;
  final String imageUrl;

  LodgingPreferenceItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory LodgingPreferenceItem.fromJson(Map<String, dynamic> json) {
    return LodgingPreferenceItem(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
      };

  @override
  String toString() => 'LodgingPreferenceItem(id: $id, title: $title, imageUrl: $imageUrl)';
}

///
/// 유저 여행 취향
///
class UserTravelPreferenceModel {
  final int id;
  final int user;
  final EnumPreferenceType type = EnumPreferenceType.travel;
  final String title;
  final String content;
  final String dislikeMemo;
  List<UserTravelPreferenceItem> distances;
  List<UserTravelPreferenceItem> environments;
  List<UserTravelPreferenceItem> mates;

  UserTravelPreferenceModel({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.dislikeMemo,
    this.distances = const [],
    this.environments = const [],
    this.mates = const [],
  });

  factory UserTravelPreferenceModel.fromJson(Map<String, dynamic> json) {
    return UserTravelPreferenceModel(
      id: json['id'] ?? -1,
      user: json['user'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      dislikeMemo: json['dislike_memo'] ?? '',
      distances: List<UserTravelPreferenceItem>.from(
          json['spicy_tastes'].map((x) => UserTravelPreferenceItem.fromJson(x))),
      environments: List<UserTravelPreferenceItem>.from(
          json['sweet_tastes'].map((x) => UserTravelPreferenceItem.fromJson(x))),
      mates: List<UserTravelPreferenceItem>.from(
          json['salty_tastes'].map((x) => UserTravelPreferenceItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'type': type.value,
        'title': title,
        'content': content,
        'dislike_memo': dislikeMemo,
        'distances': distances.map((x) => x.toJson()).toList(),
        'environments': environments.map((x) => x.toJson()).toList(),
        'mates': mates.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() =>
      'UserTravelPreferenceModel(id: $id, user: $user, type: $type, title: $title, content: $content, dislikeMemo: $dislikeMemo, distances: $distances, environments: $environments, mates: $mates)';
}

class UserTravelPreferenceItem {
  final int id;
  final String title;
  final String imageUrl;

  UserTravelPreferenceItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory UserTravelPreferenceItem.fromJson(Map<String, dynamic> json) {
    return UserTravelPreferenceItem(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
      };

  @override
  String toString() => 'UserTravelPreferenceItem(id: $id, title: $title, imageUrl: $imageUrl)';
}

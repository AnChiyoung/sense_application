class User {
  final int ?id;
  final String ?username;
  final String email;
  final String birthday;
  final String phone;
  final String gender;
  final String ?profileImage;
  final bool ?isSignup;
  final bool ?isAddProfile;
  final String ?description;
  final Enum ?relationshipStatus;
  final String ?mbti;
  final bool isOwnCar;
  final bool isPushAlarm;
  final bool isMarketingAlarm;
  final String ?stores;
  final String ?password;

  User({
    this.id,
    this.username,
    required this.email,
    required this.birthday,
    required this.phone,
    required this.gender,
    this.password,
    this.profileImage,
    this.isSignup,
    this.isAddProfile,
    this.description,
    this.relationshipStatus,
    this.mbti,
    this.isOwnCar = false,
    this.isPushAlarm = false,
    this.isMarketingAlarm = false,
    this.stores,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      birthday: json['birthday'],
      gender: json['gender']
    );
  }
}
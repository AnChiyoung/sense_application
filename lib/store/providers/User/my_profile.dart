
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/models/user.dart';

class MyProfile extends StateNotifier<User> {
  MyProfile(): super(
    User(
      email: '',
      birthday: '',
      phone: '',
      gender: ''
    )
  );

  void setProfile(User user) {
    state = user;
  }
}

final myProfileProvider = StateNotifierProvider((ref) {
  return MyProfile();
});

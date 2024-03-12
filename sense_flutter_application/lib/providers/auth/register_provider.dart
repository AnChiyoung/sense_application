import 'package:sense_flutter_application/apis/auth/auth_api.dart';
import 'package:sense_flutter_application/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkMailRepositoryProvider = StateProvider<AuthApi>((ref) {
  return AuthApi();
});

final emailInputProvider = StateProvider<String>((ref) {
  return '';
});

final emailErrorProvider = StateProvider<String?>((ref) {
  return null;
});

final isEmailAvailable = StateProvider<bool>((ref) {
  return false;
});
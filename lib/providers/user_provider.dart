import 'package:sense_flutter_application/apis/login_api.dart';
import 'package:sense_flutter_application/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = StateProvider<LoginApi>((ref) {
  return LoginApi();
});

// final userFutureProvider = FutureProvider<List<User>>((ref) async {
//   return ref.watch(loginRepositoryProvider).loginUser();
// });
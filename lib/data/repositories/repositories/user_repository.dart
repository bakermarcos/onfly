import 'package:onfly/domain/entities/user_app.dart';

abstract class UserRepository {
  Future<UserApp> registerUser({required UserApp userApp});

  Future<UserApp> login({
    required String email,
    required String password,
  });
}

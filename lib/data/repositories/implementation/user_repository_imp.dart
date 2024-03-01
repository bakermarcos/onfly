import 'package:onfly/data/datasources/remote/api/user_data_source_api.dart';
import 'package:onfly/data/repositories/repositories/user_repository.dart';
import 'package:onfly/domain/entities/user_app.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSourceApi userDataSource;
  UserRepositoryImpl(this.userDataSource);

  @override
  Future<UserApp> registerUser({required UserApp userApp}) async {
    return await userDataSource.registerUser(userApp: userApp);
  }

  @override
  Future<UserApp> login(
      {required String email, required String password}) async {
    return await userDataSource.login(email: email, password: password);
  }
}

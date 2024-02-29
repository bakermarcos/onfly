import 'package:onfly/data/datasources/remote/user_data_source.dart';
import 'package:onfly/domain/entities/user.dart';

class RemoteUserDataSource implements UserDataSource {
  @override
  Future<User> getUserData() async {
    //TODO: Implement this
    return User(
        id: 0,
        name: 'name',
        email: 'email',
        password: 'password',
        company: 'company');
  }

  @override
  Future<User> login() async {
    //TODO: Implement this
    return User(
        id: 0,
        name: 'name',
        email: 'email',
        password: 'password',
        company: 'company');
  }

  @override
  Future<String> registerUser() async {
    //TODO: Implement this
    return 'Success';
  }
}

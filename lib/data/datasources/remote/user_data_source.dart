import 'package:onfly/domain/entities/user.dart';

abstract class UserDataSource {
 Future<User> getUserData();

 Future<String> registerUser();

 Future<User> login();
}
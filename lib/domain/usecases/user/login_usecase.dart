import 'package:onfly/data/repositories/repositories/user_repository.dart';
import 'package:onfly/domain/entities/user_app.dart';

class LoginUseCase {
  final UserRepository userRepository;
  LoginUseCase(this.userRepository);
  Future<UserApp> call({
    required String email,
    required String password,
  }) async{
    return await userRepository.login(email: email, password: password);
  }
}

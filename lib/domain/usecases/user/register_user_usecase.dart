import 'package:onfly/data/repositories/repositories/user_repository.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RegisterUseCase {
  final UserRepository userRepository;
  RegisterUseCase(this.userRepository);
  Future<UserApp> call({required UserApp userApp}) async {
    return await userRepository.registerUser(userApp: userApp);
  }
}

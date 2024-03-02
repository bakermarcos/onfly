import 'package:firebase_auth/firebase_auth.dart';
import 'package:onfly/data/datasources/remote/api/user_data_source_api.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RemoteUserDataSourceApi implements UserDataSourceApi {
  final FirebaseAuth _firebaseAuth;
  RemoteUserDataSourceApi(this._firebaseAuth);

  @override
  Future<UserApp> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return UserApp(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName??'Usuário',
        email: email,
        password: password,
        isLogged: true,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserApp> registerUser({required UserApp userApp}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userApp.email, password: userApp.password);
      _firebaseAuth.currentUser!.updateDisplayName(userApp.name);
      return userApp.copyWith(id: _firebaseAuth.currentUser!.uid);
    } catch (error) {
      rethrow;
    }
  }
}

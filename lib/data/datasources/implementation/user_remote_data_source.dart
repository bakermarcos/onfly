import 'package:firebase_auth/firebase_auth.dart';
import 'package:onfly/data/datasources/remote/user_data_source.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RemoteUserDataSource implements UserDataSource {
  @override
  Future<UserApp> login(
      {required String email, required String password}) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return UserApp(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName!,
        email: email,
        password: password,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserApp> registerUser({required UserApp userApp}) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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

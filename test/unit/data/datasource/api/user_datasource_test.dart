import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly/data/datasources/implementation/api/user_remote_data_source_api.dart';
import 'package:onfly/data/datasources/remote/api/user_data_source_api.dart';
import 'package:onfly/domain/entities/user_app.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class UserMock extends Mock implements User {}

void main() {
  FirebaseAuth firebaseAuthMock = FirebaseAuthMock();
  late UserDataSourceApi userDataSource;
  UserApp userTest = UserApp(
      email: 'test@test.com', name: 'test', password: 'password123', id: '0');

  setUp(() async {
    userDataSource = RemoteUserDataSourceApi(firebaseAuthMock);
  });

  group('Deve testar registerUser', () {
    test('Deve retornar um usuario ao registrar', () async {
      UserMock userMock = UserMock();
      when(() => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenAnswer(
        (invocation) async {
          return UserCredentialMock();
        },
      );

      when(
        () => firebaseAuthMock.currentUser,
      ).thenReturn(userMock);

      when(() => userMock.updateDisplayName(any())).thenAnswer(
        (invocation) async {},
      );

      when(() => userMock.uid).thenReturn('1');

      final response = await userDataSource.registerUser(userApp: userTest);

      expect(response.id, '1');
    });
    test('Deve retornar uma exception', () async {
      when(() => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenThrow(Exception());

      expect(() => userDataSource.registerUser(userApp: userTest),
          throwsA(isA<Exception>()));
    });
  });
}

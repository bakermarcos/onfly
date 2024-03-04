import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly/data/datasources/remote/api/card_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/card_data_source_local.dart';
import 'package:onfly/data/repositories/implementation/card_repository_imp.dart';
import 'package:onfly/data/repositories/repositories/card_repository.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

class CardDataSourceApiMock extends Mock implements CardDataSourceApi {}

class CardDataSourceLocalMock extends Mock implements CardDataSourceLocal {}

void main() {
  final CardDataSourceApi cardDataSourceApi = CardDataSourceApiMock();
  final CardDataSourceLocal cardDataSourceLocal = CardDataSourceLocalMock();
  CardRepository cardRepository =
      CardRepositoryImp(cardDataSourceApi, cardDataSourceLocal);
  UserApp userApp = UserApp(name: 'name', email: 'email', password: 'password');
  double balance = 2000;
  CorporateCard card = CorporateCard(
      id: 0,
      cardNumber: 0,
      balance: balance,
      initialBalance: 2000,
      cardFlag: 'cardFlag');

  setUp(() {
    registerFallbackValue(userApp);
    registerFallbackValue(card);
  });

  test('Deve realizar o update do saldo na API', () async {
    // arrange
    when(() => cardDataSourceApi.updateBalance(
            userApp: any(named: 'userApp'), balance: any(named: 'balance')))
        .thenAnswer((invocation) async => balance);
    when(() => cardDataSourceLocal.updateBalance(
        balance: any(named: 'balance'),
        card: any(named: 'card'))).thenAnswer((invocation) async => 0);
    // act
    final result = await cardRepository.updateBalance(
        userApp: userApp, balance: balance, card: card);

    expect(result, balance);
    verify(
      () => cardDataSourceLocal.updateBalance(
          card: card, balance: balance, isSync: false),
    ).called(1);
  });
  test('Deve realizar o update do saldo apenas no local para sincronização',
      () async {
    // arrange
    when(() => cardDataSourceApi.updateBalance(
        userApp: any(named: 'userApp'),
        balance: any(named: 'balance'))).thenThrow(Exception());
    when(() => cardDataSourceLocal.updateBalance(
        isSync: any(named: 'isSync'),
        balance: any(named: 'balance'),
        card: any(named: 'card'))).thenAnswer(
      (invocation) async => balance,
    );

    // act
    final result = cardRepository.updateBalance(
        userApp: userApp, balance: balance, card: card);

    expect(() => result, throwsA(isA<Exception>()));
    verify(
      () => cardDataSourceLocal.updateBalance(
          card: card, balance: balance, isSync: true),
    ).called(1);
    verifyNever(
      () => cardDataSourceLocal.updateBalance(
          card: card, balance: balance, isSync: false),
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:onfly/main.dart' as app;
import 'package:onfly/presentation/home/screens/home_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Page integration test', () {
    testWidgets('Write email in login', (widgetTester) async {
      await app.main();
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(
          find.byKey(const Key('email_form_field')), 'teste@teste.com');

      await widgetTester.pumpAndSettle();

      expect(find.byType(TextFormField), findsAtLeast(2));
      expect(find.textContaining('teste'), findsOneWidget);
    });
    testWidgets('Write password in login', (widgetTester) async {
      await app.main();
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(
          find.byKey(const Key('password_form_field')), 'password');

      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byIcon(Icons.visibility));

      await widgetTester.pumpAndSettle();

      expect(find.byType(TextFormField), findsAtLeast(2));
      expect(find.textContaining('password'), findsOneWidget);
    });
    testWidgets('Login and go to home page', (widgetTester) async {
      await app.main();
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(
          find.byKey(const Key('email_form_field')), 'teste@teste.com');

      await widgetTester.enterText(
          find.byKey(const Key('password_form_field')), 'password123');

      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Login'));

      await widgetTester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
    });
    testWidgets('Try login and failed to login', (widgetTester) async {
      await app.main();
      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(
          find.byKey(const Key('email_form_field')), 'teste@teste.com');

      await widgetTester.enterText(
          find.byKey(const Key('password_form_field')), '123');

      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Login'));

      await widgetTester.pumpAndSettle();

      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(TextFormField), findsAtLeast(2));
    });
  });
}

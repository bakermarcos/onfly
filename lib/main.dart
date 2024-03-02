import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';
import 'package:onfly/firebase_options.dart';
import 'package:onfly/presentation/login/screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initHive().then((value) async => await openBoxes());
  runApp(const MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CorporateCardAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(TravelAdapter());
  Hive.registerAdapter(UserAppAdapter());
}

Future<void> openBoxes() async {
  await Hive.openBox<UserApp>('user_data');
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox<Travel>('travels');
  await Hive.openBox<CorporateCard>('card_data');

  await Hive.openBox<UserApp>('sync_user_data');
  await Hive.openBox<Expense>('sync_expenses');
  await Hive.openBox<Travel>('sync_travels');
  await Hive.openBox<CorporateCard>('sync_card_data');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnFly',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}

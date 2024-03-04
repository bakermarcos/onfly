import 'package:hive/hive.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

class LogoutService {
  static Future<void> logout() async {
    await _clearBoxes();
  }

  static Future<void> _clearBoxes() async {
    await Hive.box<UserApp>('user_data').clear();
    await Hive.box<Expense>('expenses').clear();
    await Hive.box<Travel>('travels').clear();
    await Hive.box<CorporateCard>('card_data').clear();
    await Hive.box<UserApp>('sync_user_data').clear();
    await Hive.box<Expense>('sync_expenses').clear();
    await Hive.box<Travel>('sync_travels').clear();
    await Hive.box<CorporateCard>('sync_card_data').clear();
  }
}

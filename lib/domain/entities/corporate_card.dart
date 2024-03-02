// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onfly/domain/entities/expense.dart';
part 'corporate_card.g.dart';

@HiveType(typeId: 3)
class CorporateCard {
  @HiveField(0)
  int id;
  @HiveField(1)
  int cardNumber;
  @HiveField(2)
  int balance;
  @HiveField(3)
  List<Expense> expenses;

  CorporateCard({
    required this.id,
    required this.cardNumber,
    required this.balance,
    required this.expenses,
  });

  CorporateCard copyWith({
    int? id,
    int? cardNumber,
    int? balance,
    List<Expense>? expenses,
  }) {
    return CorporateCard(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      balance: balance ?? this.balance,
      expenses: expenses ?? this.expenses,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardNumber': cardNumber,
      'balance': balance,
      'expenses': expenses.map((x) => x.toMap()).toList(),
    };
  }

  factory CorporateCard.fromMap(Map<String, dynamic> map) {
    return CorporateCard(
      id: map['id'] as int,
      cardNumber: map['cardNumber'] as int,
      balance: map['balance'] as int,
      expenses: List<Expense>.from(
        (map['expenses'] as List<int>).map<Expense>(
          (x) => Expense.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CorporateCard.fromJson(String source) =>
      CorporateCard.fromMap(json.decode(source) as Map<String, dynamic>);

  static CorporateCard empty() {
    return CorporateCard(
      id: 0,
      cardNumber: 0,
      balance: 2000,
      expenses: [],
    );
  }

  @override
  String toString() {
    return 'CorporateCard(id: $id, cardNumber: $cardNumber, balance: $balance, expenses: $expenses)';
  }

  @override
  bool operator ==(covariant CorporateCard other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.cardNumber == cardNumber &&
        other.balance == balance &&
        listEquals(other.expenses, expenses);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cardNumber.hashCode ^
        balance.hashCode ^
        expenses.hashCode;
  }
}

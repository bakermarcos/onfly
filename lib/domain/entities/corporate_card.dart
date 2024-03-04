// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'corporate_card.g.dart';

@HiveType(typeId: 3)
class CorporateCard {
  @HiveField(0)
  int id;
  @HiveField(1)
  int cardNumber;
  @HiveField(2)
  double balance;
  @HiveField(3)
  double initialBalance;
  @HiveField(4)
  String cardFlag;

  CorporateCard(
      {required this.id,
      required this.cardNumber,
      required this.balance,
      required this.initialBalance,
      required this.cardFlag});

  CorporateCard copyWith(
      {int? id,
      int? cardNumber,
      double? balance,
      double? initialBalance,
      String? cardFlag}) {
    return CorporateCard(
        id: id ?? this.id,
        cardNumber: cardNumber ?? this.cardNumber,
        balance: balance ?? this.balance,
        initialBalance: initialBalance ?? this.initialBalance,
        cardFlag: cardFlag ?? this.cardFlag);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardNumber': cardNumber,
      'balance': balance,
      'initialBalance': initialBalance,
      'cardFlag': cardFlag,
    };
  }

  factory CorporateCard.fromMap(Map<String, dynamic> map) {
    return CorporateCard(
      cardFlag: map['cardFlag'] as String,
      id: map['id'] as int,
      cardNumber: map['cardNumber'] as int,
      balance: double.parse(map['balance'].toString()),
      initialBalance: double.parse(
        map['initialBalance'].toString(),
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
      initialBalance: 2000,
      cardFlag: 'none',
    );
  }

  @override
  String toString() {
    return 'CorporateCard(id: $id, cardNumber: $cardNumber, balance: $balance, initialBalance: $initialBalance, cardFlag: $cardFlag)';
  }

  @override
  bool operator ==(covariant CorporateCard other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.cardNumber == cardNumber &&
        other.balance == balance &&
        other.initialBalance == initialBalance &&
        other.cardFlag == cardFlag;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cardNumber.hashCode ^
        balance.hashCode ^
        initialBalance.hashCode ^
        cardFlag.hashCode;
  }
}

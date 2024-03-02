// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'expense.g.dart';
@HiveType(typeId: 2)
class Expense {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String value;
  @HiveField(3)
  final String date;
  Expense({
    required this.id,
    required this.name,
    required this.value,
    required this.date,
  });

  static Expense empty() {
    return Expense(
      id: 0,
      name: 'name',
      value: '0',
      date: '10/01/2024',
    );
  }

  Expense copyWith({
    int? id,
    String? name,
    String? value,
    String? date,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value,
      'date': date,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, value: $value, date: $date)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.value == value &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ value.hashCode ^ date.hashCode;
  }
}

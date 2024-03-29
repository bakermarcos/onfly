// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_app.g.dart';

@HiveType(typeId: 0)
class UserApp {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4, defaultValue: false)
  bool isLogged;
  UserApp({
    this.id = '0',
    required this.name,
    required this.email,
    required this.password,
    this.isLogged = false,
  });

  static UserApp empty() {
    return UserApp(
      id: '0',
      name: 'name',
      email: 'email@email.com',
      password: 'password',
    );
  }

  UserApp copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    bool? isLogged,
  }) {
    return UserApp(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLogged: isLogged ?? this.isLogged,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'isLogged': isLogged,
    };
  }

  factory UserApp.fromMap(Map<String, dynamic> map) {
    return UserApp(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      isLogged: map['isLogged'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserApp.fromJson(String source) =>
      UserApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserApp(id: $id, name: $name, email: $email, password: $password, isLogged: $isLogged)';
  }

  @override
  bool operator ==(covariant UserApp other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.isLogged == isLogged;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        isLogged.hashCode;
  }
}

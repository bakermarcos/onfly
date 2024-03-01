// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserApp {
  String id;
  String name;
  String email;
  String password;
  UserApp({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  UserApp copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    return UserApp(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserApp.fromMap(Map<String, dynamic> map) {
    return UserApp(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserApp.fromJson(String source) => UserApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserApp(id: $id, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant UserApp other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}

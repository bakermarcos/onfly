// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'travel.g.dart';

@HiveType(typeId: 1)
class Travel {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String airport;
  @HiveField(2)
  final String airline;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String boardingPass;
  Travel({
    required this.id,
    required this.airport,
    required this.airline,
    required this.date,
    required this.boardingPass,
  });

  Travel copyWith({
    int? id,
    String? airport,
    String? airline,
    String? date,
    String? boardingPass,
  }) {
    return Travel(
      id: id ?? this.id,
      airport: airport ?? this.airport,
      airline: airline ?? this.airline,
      date: date ?? this.date,
      boardingPass: boardingPass ?? this.boardingPass,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'airport': airport,
      'airline': airline,
      'date': date,
      'boardingPass': boardingPass,
    };
  }

  factory Travel.fromMap(Map<String, dynamic> map) {
    return Travel(
      id: map['id'] as int,
      airport: map['airport'] as String,
      airline: map['airline'] as String,
      date: map['date'] as String,
      boardingPass: map['boardingPass'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Travel.fromJson(String source) =>
      Travel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Travel(id: $id, airport: $airport, airline: $airline, date: $date, boardingPass: $boardingPass)';
  }

  @override
  bool operator ==(covariant Travel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.airport == airport &&
        other.airline == airline &&
        other.date == date &&
        other.boardingPass == boardingPass;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        airport.hashCode ^
        airline.hashCode ^
        date.hashCode ^
        boardingPass.hashCode;
  }
}

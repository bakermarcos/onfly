// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Travel {
  final int id;
  final String title;
  final String from;
  final String to;
  final String date;
  final String boardingPass;

  Travel({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.date,
    required this.boardingPass,
  });

  Travel copyWith({
    int? id,
    String? title,
    String? from,
    String? to,
    String? date,
    String? boardingPass,
  }) {
    return Travel(
      id: id ?? this.id,
      title: title ?? this.title,
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
      boardingPass: boardingPass ?? this.boardingPass,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'from': from,
      'to': to,
      'date': date,
      'boardingPass': boardingPass,
    };
  }

  factory Travel.fromMap(Map<String, dynamic> map) {
    return Travel(
      id: map['id'] as int,
      title: map['title'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      date: map['date'] as String,
      boardingPass: map['boardingPass'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Travel.fromJson(String source) => Travel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Travel(id: $id, title: $title, from: $from, to: $to, date: $date, boardingPass: $boardingPass)';
  }

  @override
  bool operator ==(covariant Travel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.from == from &&
      other.to == to &&
      other.date == date &&
      other.boardingPass == boardingPass;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      from.hashCode ^
      to.hashCode ^
      date.hashCode ^
      boardingPass.hashCode;
  }
}

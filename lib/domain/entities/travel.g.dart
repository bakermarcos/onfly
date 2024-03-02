// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelAdapter extends TypeAdapter<Travel> {
  @override
  final int typeId = 1;

  @override
  Travel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Travel(
      id: fields[0] as int,
      airport: fields[1] as String,
      airline: fields[2] as String,
      date: fields[3] as String,
      boardingPass: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Travel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.airport)
      ..writeByte(2)
      ..write(obj.airline)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.boardingPass);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

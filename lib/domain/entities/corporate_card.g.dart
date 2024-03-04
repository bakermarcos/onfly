// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CorporateCardAdapter extends TypeAdapter<CorporateCard> {
  @override
  final int typeId = 3;

  @override
  CorporateCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CorporateCard(
      id: fields[0] as int,
      cardNumber: fields[1] as int,
      balance: fields[2] as double,
      initialBalance: fields[3] as double,
      cardFlag: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CorporateCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.balance)
      ..writeByte(3)
      ..write(obj.initialBalance)
      ..writeByte(4)
      ..write(obj.cardFlag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorporateCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

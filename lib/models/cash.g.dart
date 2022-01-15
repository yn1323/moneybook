// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CashAdapter extends TypeAdapter<Cash> {
  @override
  final int typeId = 0;

  @override
  Cash read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cash(
      id: fields[0] as String,
      category: fields[1] as String,
      member: fields[2] as String,
      date: fields[3] as DateTime,
      price: fields[5] as int,
      memo: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cash obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.member)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.memo)
      ..writeByte(5)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

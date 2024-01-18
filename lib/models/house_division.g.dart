// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_division.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseDivisionAdapter extends TypeAdapter<HouseDivision> {
  @override
  final int typeId = 1;

  @override
  HouseDivision read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HouseDivision(
      name: fields[0] as String,
      width: fields[1] as double,
      height: fields[2] as double,
      kwAmount: fields[3] as double,
      filmsAmount: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HouseDivision obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.kwAmount)
      ..writeByte(4)
      ..write(obj.filmsAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseDivisionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

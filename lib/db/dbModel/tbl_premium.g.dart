// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_premium.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLPremiumAdapter extends TypeAdapter<TBLPremium> {
  @override
  final int typeId = 11;

  @override
  TBLPremium read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLPremium(
      id: fields[0] as int?,
      isPremium: fields[1] as bool?,
      lastDay: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TBLPremium obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isPremium)
      ..writeByte(2)
      ..write(obj.lastDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLPremiumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_term_condition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLTermAndConditionAdapter extends TypeAdapter<TBLTermAndCondition> {
  @override
  final int typeId = 3;

  @override
  TBLTermAndCondition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLTermAndCondition(
      id: fields[0] as int?,
      termMM: fields[1] as String?,
      termEng: fields[2] as String?,
      createdBy: fields[3] as String?,
      updatedBy: fields[4] as String?,
      createdAt: fields[5] as String?,
      updatedAt: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TBLTermAndCondition obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.termMM)
      ..writeByte(2)
      ..write(obj.termEng)
      ..writeByte(3)
      ..write(obj.createdBy)
      ..writeByte(4)
      ..write(obj.updatedBy)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLTermAndConditionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

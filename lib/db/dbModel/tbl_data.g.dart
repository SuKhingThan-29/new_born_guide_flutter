// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLDataAdapter extends TypeAdapter<TBLData> {
  @override
  final int typeId = 5;

  @override
  TBLData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLData(
      categoryId: fields[0] as int?,
      categoryName: fields[1] as String?,
      type: fields[2] as String?,
      isActive: fields[3] as int?,
      content: (fields[4] as List?)?.cast<TBLContent>(),
    );
  }

  @override
  void write(BinaryWriter writer, TBLData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.categoryName)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

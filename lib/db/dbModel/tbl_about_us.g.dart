// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_about_us.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TblAboutUsAdapter extends TypeAdapter<TblAboutUs> {
  @override
  final int typeId = 0;

  @override
  TblAboutUs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TblAboutUs(
      id: fields[0] as int?,
      aboutMM: fields[1] as String?,
      aboutEng: fields[2] as String?,
      createdBy: fields[3] as String?,
      updatedBy: fields[4] as String?,
      createdAt: fields[5] as String?,
      updatedAt: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TblAboutUs obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.aboutMM)
      ..writeByte(2)
      ..write(obj.aboutEng)
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
      other is TblAboutUsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

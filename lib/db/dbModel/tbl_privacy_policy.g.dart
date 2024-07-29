// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_privacy_policy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TblPrivacyPolicyAdapter extends TypeAdapter<TblPrivacyPolicy> {
  @override
  final int typeId = 4;

  @override
  TblPrivacyPolicy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TblPrivacyPolicy(
      id: fields[0] as int?,
      titleMM: fields[1] as String?,
      titleEng: fields[2] as String?,
      createdBy: fields[3] as String?,
      updatedBy: fields[4] as String?,
      createdAt: fields[5] as String?,
      updatedAt: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TblPrivacyPolicy obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleMM)
      ..writeByte(2)
      ..write(obj.titleEng)
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
      other is TblPrivacyPolicyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

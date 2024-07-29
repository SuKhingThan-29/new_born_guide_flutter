// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLProfileAdapter extends TypeAdapter<TBLProfile> {
  @override
  final int typeId = 6;

  @override
  TBLProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLProfile(
      id: fields[0] as int?,
      username: fields[1] as String?,
      fullName: fields[2] as String?,
      isPremium: fields[3] as int?,
      image: fields[4] as String?,
      phoneNo: fields[5] as String?,
      password: fields[6] as String?,
      email: fields[7] as String?,
      gender: fields[8] as String?,
      dob: fields[9] as String?,
      isParent: fields[10] as int?,
      isPregnent: fields[11] as int?,
      createdAt: fields[12] as String?,
      updatedAt: fields[13] as String?,
      createdBy: fields[14] as String?,
      updatedBy: fields[15] as String?,
      isUpload: fields[16] as bool?,
      convKey: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TBLProfile obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.isPremium)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.phoneNo)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.dob)
      ..writeByte(10)
      ..write(obj.isParent)
      ..writeByte(11)
      ..write(obj.isPregnent)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.createdBy)
      ..writeByte(15)
      ..write(obj.updatedBy)
      ..writeByte(16)
      ..write(obj.isUpload)
      ..writeByte(17)
      ..write(obj.convKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

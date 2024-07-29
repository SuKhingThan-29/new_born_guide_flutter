// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TblNotificationAdapter extends TypeAdapter<TblNotification> {
  @override
  final int typeId = 9;

  @override
  TblNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TblNotification(
      id: fields[0] as int?,
      title: fields[1] as String?,
      createdBy: fields[2] as String?,
      updatadBy: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TblNotification obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.createdBy)
      ..writeByte(3)
      ..write(obj.updatadBy)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TblNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

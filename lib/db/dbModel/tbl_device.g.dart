// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_device.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLDeviceAdapter extends TypeAdapter<TBLDevice> {
  @override
  final int typeId = 10;

  @override
  TBLDevice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLDevice(
      id: fields[0] as int?,
      customerId: fields[1] as int?,
      deviceName: fields[2] as String?,
      deviceId: fields[3] as String?,
      isSelected: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TBLDevice obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerId)
      ..writeByte(2)
      ..write(obj.deviceName)
      ..writeByte(3)
      ..write(obj.deviceId)
      ..writeByte(4)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLDeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

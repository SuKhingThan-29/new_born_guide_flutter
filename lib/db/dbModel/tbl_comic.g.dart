// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_comic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLComicAdapter extends TypeAdapter<TBLComic> {
  @override
  final int typeId = 8;

  @override
  TBLComic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLComic(
      id: fields[0] as int?,
      contentId: fields[1] as int?,
      imageUrl: fields[2] as String?,
      voiceUrl: fields[3] as String?,
      createdBy: fields[4] as String?,
      updatedBy: fields[5] as String?,
      createdAt: fields[6] as String?,
      updatedAt: fields[7] as String?,
      userId: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TBLComic obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.contentId)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.voiceUrl)
      ..writeByte(4)
      ..write(obj.createdBy)
      ..writeByte(5)
      ..write(obj.updatedBy)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLComicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

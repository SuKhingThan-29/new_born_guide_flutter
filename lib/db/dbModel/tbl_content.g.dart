// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLContentAdapter extends TypeAdapter<TBLContent> {
  @override
  final int typeId = 7;

  @override
  TBLContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLContent(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      categoryId: fields[3] as int?,
      imageUrl: fields[4] as String?,
      url: fields[5] as String?,
      urlMp4: fields[6] as String?,
      mp4Size: fields[7] as String?,
      viewCount: fields[8] as int?,
      isActive: fields[9] as int?,
      reactCount: fields[10] as int?,
      userId: fields[11] as int?,
      loveAction: fields[12] as int?,
      saveAction: fields[13] as int?,
      perpage: fields[14] as int?,
      relatedContentId: fields[15] as int?,
      isHome: fields[16] as bool?,
      isContentDetail: fields[17] as bool?,
      createdAt: fields[18] as String?,
      isUpload: fields[19] as bool?,
      isDelete: fields[20] as bool?,
      type: fields[21] as String?,
      comic: (fields[22] as List?)?.cast<TBLComic>(),
      isPremium: fields[23] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TBLContent obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.urlMp4)
      ..writeByte(7)
      ..write(obj.mp4Size)
      ..writeByte(8)
      ..write(obj.viewCount)
      ..writeByte(9)
      ..write(obj.isActive)
      ..writeByte(10)
      ..write(obj.reactCount)
      ..writeByte(11)
      ..write(obj.userId)
      ..writeByte(12)
      ..write(obj.loveAction)
      ..writeByte(13)
      ..write(obj.saveAction)
      ..writeByte(14)
      ..write(obj.perpage)
      ..writeByte(15)
      ..write(obj.relatedContentId)
      ..writeByte(16)
      ..write(obj.isHome)
      ..writeByte(17)
      ..write(obj.isContentDetail)
      ..writeByte(18)
      ..write(obj.createdAt)
      ..writeByte(19)
      ..write(obj.isUpload)
      ..writeByte(20)
      ..write(obj.isDelete)
      ..writeByte(21)
      ..write(obj.type)
      ..writeByte(22)
      ..write(obj.comic)
      ..writeByte(23)
      ..write(obj.isPremium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

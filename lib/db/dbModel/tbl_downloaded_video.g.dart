// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_downloaded_video.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TblDownloadedVideoAdapter extends TypeAdapter<TblDownloadedVideo> {
  @override
  final int typeId = 12;

  @override
  TblDownloadedVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TblDownloadedVideo(
      content: fields[0] as TBLContent?,
      taskId: fields[1] as String?,
      status: fields[2] as DownloadTaskStatus?,
      progress: fields[3] as int?,
      url: fields[4] as String?,
      filename: fields[5] as String?,
      savedDir: fields[6] as String?,
      timeCreated: fields[7] as int?,
      filePath: fields[8] as String?,
      fileSize: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TblDownloadedVideo obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.progress)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.filename)
      ..writeByte(6)
      ..write(obj.savedDir)
      ..writeByte(7)
      ..write(obj.timeCreated)
      ..writeByte(8)
      ..write(obj.filePath)
      ..writeByte(9)
      ..write(obj.fileSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TblDownloadedVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

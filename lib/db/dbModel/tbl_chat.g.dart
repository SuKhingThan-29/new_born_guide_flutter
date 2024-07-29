// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbl_chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBLChatAdapter extends TypeAdapter<TBLChat> {
  @override
  final int typeId = 2;

  @override
  TBLChat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBLChat(
      groupId: fields[0] as int?,
      groupName: fields[1] as String?,
      groupImage: fields[2] as String?,
      groupConvKey: fields[3] as String?,
      lastMessage: fields[4] as String?,
      lastTime: fields[5] as String?,
      unreadCount: fields[6] as int?,
      chatType: fields[7] as String?,
      receiveId: fields[8] as int?,
      receiveName: fields[9] as String?,
      receiveImage: fields[11] as String?,
      receiveConvKey: fields[10] as String?,
      convkey: fields[12] as String?,
      senderId: fields[13] as int?,
      senderImage: fields[15] as String?,
      senderName: fields[14] as String?,
      receivePhone: fields[16] as String?,
      isOwner: fields[17] as int?,
      isAdmin: fields[18] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TBLChat obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.groupName)
      ..writeByte(2)
      ..write(obj.groupImage)
      ..writeByte(3)
      ..write(obj.groupConvKey)
      ..writeByte(4)
      ..write(obj.lastMessage)
      ..writeByte(5)
      ..write(obj.lastTime)
      ..writeByte(6)
      ..write(obj.unreadCount)
      ..writeByte(7)
      ..write(obj.chatType)
      ..writeByte(8)
      ..write(obj.receiveId)
      ..writeByte(9)
      ..write(obj.receiveName)
      ..writeByte(10)
      ..write(obj.receiveConvKey)
      ..writeByte(11)
      ..write(obj.receiveImage)
      ..writeByte(12)
      ..write(obj.convkey)
      ..writeByte(13)
      ..write(obj.senderId)
      ..writeByte(14)
      ..write(obj.senderName)
      ..writeByte(15)
      ..write(obj.senderImage)
      ..writeByte(16)
      ..write(obj.receivePhone)
      ..writeByte(17)
      ..write(obj.isOwner)
      ..writeByte(18)
      ..write(obj.isAdmin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBLChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

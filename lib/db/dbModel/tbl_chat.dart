import 'package:hive/hive.dart';

part 'tbl_chat.g.dart';

@HiveType(typeId: 2)
class TBLChat extends HiveObject {
  @HiveField(0)
  int? groupId;
  @HiveField(1)
  String? groupName;
  @HiveField(2)
  String? groupImage;
  @HiveField(3)
  String? groupConvKey;
  @HiveField(4)
  String? lastMessage;
  @HiveField(5)
  String? lastTime;
  @HiveField(6)
  int? unreadCount;
  @HiveField(7)
  String? chatType;
  @HiveField(8)
  int? receiveId;
  @HiveField(9)
  String? receiveName;
  @HiveField(10)
  String? receiveConvKey;
  @HiveField(11)
  String? receiveImage;
  @HiveField(12)
  String? convkey;
  @HiveField(13)
  int? senderId;
  @HiveField(14)
  String? senderName;
  @HiveField(15)
  String? senderImage;
  @HiveField(16)
  String? receivePhone;
  @HiveField(17)
  int? isOwner;
  @HiveField(18)
  int? isAdmin;

  TBLChat(
      {this.groupId,
      this.groupName,
      this.groupImage,
      this.groupConvKey,
      this.lastMessage,
      this.lastTime,
      this.unreadCount,
      this.chatType,
      this.receiveId,
      this.receiveName,
      this.receiveImage,
      this.receiveConvKey,
      this.convkey,
      this.senderId,
      this.senderImage,
      this.senderName,
      this.receivePhone,
      this.isOwner,
      this.isAdmin});

  factory TBLChat.fromJson(Map<String, dynamic> jsonData) {
    return TBLChat(
      groupId: jsonData['group_id'],
      groupName: jsonData['group_name'],
      groupImage: jsonData['group_img'],
      groupConvKey: jsonData['group_conv_key'],
      lastMessage: jsonData['last_message'],
      lastTime: jsonData['last_time'],
      unreadCount: jsonData['unread_count'],
      chatType: jsonData['chat_type'],
      receiveId: jsonData['receive_id'],
      receiveName: jsonData['receive_name'],
      receiveImage: jsonData['receive_image'],
      receiveConvKey: jsonData['receive_conv_key'],
      convkey: jsonData['conversation_key'],
      senderId: jsonData['sender_id'],
      senderName: jsonData['sender_name'],
      senderImage: jsonData['sender_img'],
      receivePhone: jsonData['receive_phone'],
      isOwner: jsonData['is_owner'],
      isAdmin: jsonData['is_admin'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["group_id"] = groupId;
    data['group_name'] = groupName;
    data['group_img'] = groupImage;
    data["group_conv_key"] = groupConvKey;
    data['last_message'] = lastMessage;
    data['last_time'] = lastTime;
    data["unread_count"] = unreadCount;
    data['chat_type'] = chatType;
    data['receive_id'] = receiveId;
    data['receive_name'] = receiveName;
    data["receive_image"] = receiveImage;
    data['receive_conv_key'] = receiveConvKey;
    data['conversation_key'] = convkey;
    data["sender_id"] = senderId;
    data['sender_name'] = senderName;
    data['sender_img'] = senderImage;
    data['receive_phone'] = receivePhone;
    data['is_owner'] = isOwner;
    data['is_admin'] = isAdmin;
    return data;
  }
}

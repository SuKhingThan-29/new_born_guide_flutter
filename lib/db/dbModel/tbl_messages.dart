
class TBLMessages {
  int? id;
  String? message;
  String? messageType;
  int? senderId;
  int? receiveId;
  String? convKey;
  String? createdAt;
  int? replyMessageId;
  String? replyMessage;

  TBLMessages(
      {this.id,
      this.message,
      this.messageType,
      this.senderId,
      this.receiveId,
      this.convKey,
      this.createdAt,
      this.replyMessageId,
      this.replyMessage});

  factory TBLMessages.fromJson(Map<String, dynamic> jsonData) {
    return TBLMessages(
      id: jsonData['id'],
      message: jsonData['message'],
      messageType: jsonData['message_type'],
      senderId: jsonData['sender_id'],
      receiveId: jsonData['receive_id'],
      convKey: jsonData['conversation_key'],
      createdAt: jsonData['created_at'],
      replyMessageId: jsonData['reply_messageid'],
      replyMessage: jsonData['reply_message'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["id"] = id;
    data['message'] = message;
    data['message_type'] = messageType;
    data["sender_id"] = senderId;
    data['receive_id'] = receiveId;
    data['conversation_key'] = convKey;
    data["created_at"] = createdAt;
    data['reply_messageid'] = replyMessageId;
    data['reply_message'] = replyMessage;
    return data;
  }
}

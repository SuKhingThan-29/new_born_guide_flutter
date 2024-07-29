

class ChatMessage {
  String? message;
  String? messageType;
  String? chatType;
  String? senderId;
  String? senderName;
  String? senderImage;
  String? senderConvKey;
  String? receiveId;
  String? receiveName;
  String? receiveConvKey;
  String? convKey;
  String? createdAt;
  int? replyMessageId;
  String? replyMessage;
  int? id;
  List<CustomerReact>? customerReact;
  bool? isReact;

  ChatMessage(
      {this.message,
      this.messageType,
      this.senderId,
      this.senderName,
      this.senderImage,
      this.senderConvKey,
      this.receiveId,
      this.receiveName,
      this.receiveConvKey,
      this.convKey,
      this.createdAt,
      this.replyMessageId,
      this.replyMessage,
      this.chatType,
      this.id,
      this.customerReact,
      this.isReact});

  factory ChatMessage.fromJson(Map<String, dynamic> jsonData) {
    var _reactList = (jsonData['customer_react'] != null)
        ? jsonData['customer_react'] as List
        : [];
    List<CustomerReact> reacts =
        _reactList.map((e) => CustomerReact.fromJson(e)).toList();
    return ChatMessage(
        message: jsonData['message'],
        messageType: jsonData['message_type'],
        chatType: jsonData['chat_type'],
        senderId: jsonData['sender_id'].toString(),
        senderName: jsonData['sender_name'],
        senderImage: jsonData['sender_img'],
        senderConvKey: jsonData['sender_conv_key'],
        receiveId: jsonData['receive_id'].toString(),
        receiveName: jsonData['receive_name'],
        receiveConvKey: jsonData['receive_conv_key'],
        convKey: jsonData['conversation_key'],
        createdAt: jsonData['created_at'],
        replyMessageId: jsonData['reply_messageid'],
        replyMessage: jsonData['reply_message'],
        id: jsonData['id'],
        customerReact: reacts,);
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['message'] = message;
    data['message_type'] = messageType;
    data['chat_type'] = chatType;
    data["sender_id"] = senderId;
    data["sender_name"] = senderName;
    data["sender_img"] = senderImage;
    data["sender_conv_key"] = senderConvKey;
    data['receive_id'] = receiveId;
    data['receive_name'] = receiveName;
    data['receive_conv_key'] = receiveConvKey;
    data['conversation_key'] = convKey;
    data["created_at"] = createdAt;
    data['reply_messageid'] = replyMessageId;
    data['reply_message'] = replyMessage;
    return data;
  }
}

class CustomerReact {
  int? id;
  int? userId;
  int? messageId;

  CustomerReact({
    this.id,
    this.userId,
    this.messageId,
  });

  factory CustomerReact.fromJson(Map<String, dynamic> jsonData) {
    return CustomerReact(
      userId: jsonData['user_id'],
      messageId: jsonData['message_id'],
      id: jsonData['id'],
    );
  }
}

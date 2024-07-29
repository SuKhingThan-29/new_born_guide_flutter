class TBLChatInfo {
  int? receiveId;
  String? receiveName;
  String? receiveConvKey;
  String? receiveImg;
  int? blockStatus;
  int? muteStatus;
  int? unreadCount;
  String? convKey;
  String? lastMessage;
  String? lastTime;
  String? chatType;
  int? blockTo;
  int? blockBy;
  int? muteTo;
  int? muteby;

  TBLChatInfo(
      {this.receiveId,
      this.receiveName,
      this.receiveConvKey,
      this.receiveImg,
      this.blockStatus,
      this.muteStatus,
      this.unreadCount,
      this.convKey,
      this.lastMessage,
      this.lastTime,
      this.chatType,
      this.blockTo,
      this.blockBy,
      this.muteTo,
      this.muteby});

  factory TBLChatInfo.fromJson(Map<String, dynamic> jsonData) {
    return TBLChatInfo(
      receiveId: jsonData['receive_id'],
      receiveName: jsonData['receive_name'],
      receiveConvKey: jsonData['receive_conv_key'],
      receiveImg: jsonData['receive_img'],
      blockStatus: jsonData['block_status'],
      muteStatus: jsonData['mute_status'],
      unreadCount: jsonData['unread_count'],
      convKey: jsonData['conv_key'],
      lastMessage: jsonData['last_message'],
      lastTime: jsonData['last_time'],
      chatType: jsonData['chat_type'],
      blockTo: jsonData['block_to'],
      blockBy: jsonData['block_by'],
      muteTo: jsonData['mute_to'],
      muteby: jsonData['mute_by'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["receive_id"] = receiveId;
    data['receive_name'] = receiveName;
    data['receive_conv_key'] = receiveConvKey;
    data["receive_img"] = receiveImg;
    data['block_status'] = blockStatus;
    data['mute_status'] = muteStatus;
    data["unread_count"] = unreadCount;
    data['conv_key'] = convKey;
    data['last_message'] = lastMessage;
    data['last_time'] = lastTime;
    data['chat_type'] = chatType;
    data['block_to'] = blockTo;
    data['block_by'] = blockBy;
    data['mute_to'] = muteTo;
    data['mute_by'] = muteby;
    return data;
  }
}

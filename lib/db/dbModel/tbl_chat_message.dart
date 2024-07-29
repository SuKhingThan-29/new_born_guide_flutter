import 'package:chitmaymay/db/dbModel/tbl_chatinfo.dart';
import 'package:chitmaymay/model/chat_message.dart';

class TBLChatMessage {
  List<dynamic>? data;
  TBLChatInfo? chatInfo;
  bool? status;

  TBLChatMessage({
    this.data,
    this.chatInfo,
    this.status,
  });

  factory TBLChatMessage.fromJson(Map<String, dynamic> jsonData) {
    return TBLChatMessage(
      data: (jsonData['data'] != null)
          ? (jsonData['data'] as List<dynamic>)
              .map((e) => ChatMessage.fromJson(e))
              .toList()
          : [],
      chatInfo: jsonData['chatinfo'] != null
          ? TBLChatInfo.fromJson(jsonData['chatinfo'])
          : TBLChatInfo(),
      status: jsonData['status'],
    );
  }
}

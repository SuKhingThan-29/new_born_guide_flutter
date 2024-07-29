class TBLGroup {
  int? id;
  String? groupName;
  String? groupImg;
  int? isOwner;
  int? isAdmin;
  String? groupConvKey;
  String? lastMessage;
  String? lastTime;

  TBLGroup(
      {this.id,
      this.groupName,
      this.groupImg,
      this.isOwner,
      this.isAdmin,
      this.groupConvKey,
      this.lastMessage,
      this.lastTime});

  factory TBLGroup.fromJson(Map<String, dynamic> jsonData) {
    return TBLGroup(
        id: jsonData['id'] ?? '',
        groupName: jsonData['group_name'] ?? '',
        groupImg: jsonData['group_img'] ?? '',
        isOwner: jsonData['is_owner'] ?? '',
        isAdmin: jsonData['is_admin'] ?? '',
        groupConvKey: jsonData['group_conv_key'] ?? '',
        lastMessage: jsonData['last_message'] ?? '',
        lastTime: jsonData['last_time'] ?? '');
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["id"] = id;
    data['group_name'] = groupName;
    data['group_img'] = groupImg;
    data["is_owner"] = isOwner;
    data['is_admin'] = isAdmin;
    data['group_conv_key'] = groupConvKey;
    data['last_message'] = lastMessage;
    data['last_time'] = lastTime;
    return data;
  }
}

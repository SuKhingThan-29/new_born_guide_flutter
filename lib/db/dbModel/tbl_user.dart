class TBLUser {
  int? id;
  String? phone;
  String? name;
  String? receiveConvKey;
  String? imageUrl;
  String? email;
  bool? selected;
  String? convKey;

  TBLUser(
      {this.id,
      this.phone,
      this.name,
      this.receiveConvKey,
      this.imageUrl,
      this.email,
      this.selected,
      this.convKey});

  factory TBLUser.fromJson(Map<String, dynamic> jsonData) {
    return TBLUser(
        id: jsonData['receive_id'] ?? '',
        phone: jsonData['receive_phone'] ?? '',
        name: jsonData['receive_name'] ?? '',
        receiveConvKey: jsonData['receive_conv_key'] ?? '',
        imageUrl: jsonData['receive_image'] ?? '',
        convKey: jsonData['conversation_key'] ?? '',
        email: jsonData['receive_email'] ?? '');
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["receive_id"] = id;
    data['receive_phone'] = phone;
    data['receive_name'] = name;
    data["receive_conv_key"] = receiveConvKey;
    data['receive_image'] = imageUrl;
    data['receive_email'] = email;
    data['conversation_key'] = convKey;
    return data;
  }
}

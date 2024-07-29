class TBLBlockUser {
  int? id;
  String? phone;
  String? name;
  String? imageUrl;
  String? email;

  TBLBlockUser({
    this.id,
    this.phone,
    this.name,
    this.imageUrl,
    this.email,
  });

  factory TBLBlockUser.fromJson(Map<String, dynamic> jsonData) {
    return TBLBlockUser(
        id: jsonData['id'] ?? '',
        name: jsonData['name'] ?? '',
        phone: jsonData['phone'] ?? '',
        email: jsonData['email'] ?? '',
        imageUrl: jsonData['image_url'] ?? '');
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["id"] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image_url'] = imageUrl;
    return data;
  }
}

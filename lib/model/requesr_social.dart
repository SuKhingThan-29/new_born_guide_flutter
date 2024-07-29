class RequestSocial {
  String? socialId;
  String? name;
  String? fullName;
  String? email;
  String? deviceId;
  String? deviceName;
  String? secretKey;

  RequestSocial(
      {this.socialId,
      this.name,
      this.fullName,
      this.email,
      this.deviceId,
      this.deviceName,
      this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['social_id'] = socialId;
    data['name'] = name;
    data['full_name'] = fullName;
    data['email'] = email;
    data['device_id'] = deviceId;
    data['device_name'] = deviceName;
    data['secret_key'] = secretKey;
    return data;
  }
}

import '../../chitmaymay_api/chitMayMayApi.dart';
import 'package:hive/hive.dart';
part 'tbl_profile.g.dart';

@HiveType(typeId: 6)
class TBLProfile {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? fullName;
  @HiveField(3)
  int? isPremium;
  @HiveField(4)
  String? image;
  @HiveField(5)
  String? phoneNo;
  @HiveField(6)
  String? password;
  @HiveField(7)
  String? email;
  @HiveField(8)
  String? gender;
  @HiveField(9)
  String? dob;
  @HiveField(10)
  int? isParent;
  @HiveField(11)
  int? isPregnent;
  @HiveField(12)
  String? createdAt;
  @HiveField(13)
  String? updatedAt;
  @HiveField(14)
  String? createdBy;
  @HiveField(15)
  String? updatedBy;
  @HiveField(16)
  bool? isUpload;
  @HiveField(17)
  String? convKey;

  TBLProfile(
      {this.id,
      this.username,
      this.fullName,
      this.isPremium,
      this.image,
      this.phoneNo,
      this.password,
      this.email,
      this.gender,
      this.dob,
      this.isParent,
      this.isPregnent,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.isUpload,
      this.convKey});

  TBLProfile.fromJson(Map<dynamic, dynamic> json) {
    id = json['user_id'];
    username = json['name'];
    fullName = json['full_name'];
    phoneNo = json['phone'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    dob = json['date_birth'];
    gender = json['gender'];
    isParent = json['is_parent'];
    isPregnent = json['is_pregnent'];
    image = json['image_url'];
    isPremium = json['is_subscribe'];
    convKey = json['customer_conv_key'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["user_id"] = id;
    data['name'] = username;
    data['full_name'] = fullName;
    data['phone'] = phoneNo;
    data["password"] = password;
    data['date_birth'] = dob;
    data['gender'] = gender;
    data['is_parent'] = isParent;
    data["is_pregnent"] = isPregnent;
    data['secret_key'] = secret_key;
    data['image_url'] = image;
    data['is_subscribe'] = isPremium;
    data['customer_conv_key'] = convKey;
    data['secret_key'] = secret_key;
    return data;
  }

  Map<dynamic, dynamic> profileToJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["user_id"] = id;
    data['name'] = username;
    data['full_name'] = fullName;
    data['phone'] = phoneNo;
    data["password"] = password;
    data['date_birth'] = dob;
    data['gender'] = gender;
    data['is_parent'] = isParent;
    data["is_pregnent"] = isPregnent;
    data["image_url"] = image;
    data["email"] = email;
    data['secret_key'] = secret_key;
    return data;
  }
}

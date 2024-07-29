import 'package:hive/hive.dart';
part 'tbl_privacy_policy.g.dart';

@HiveType(typeId: 4)
class TblPrivacyPolicy {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? titleMM;
  @HiveField(2)
  String? titleEng;
  @HiveField(3)
  String? createdBy;
  @HiveField(4)
  String? updatedBy;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? updatedAt;
  TblPrivacyPolicy(
      {this.id,
      this.titleMM,
      this.titleEng,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});
  factory TblPrivacyPolicy.fromJson(Map<String, dynamic> jsonData) {
    return TblPrivacyPolicy(
        id: jsonData['id'],
        titleMM: jsonData['title_mm'],
        titleEng: jsonData['title_eng'],
        createdBy: jsonData['created_by'],
        updatedBy: jsonData['updated_by'],
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at']);
  }
}

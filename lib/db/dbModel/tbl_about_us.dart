import 'package:hive/hive.dart';
part 'tbl_about_us.g.dart';
@HiveType(typeId: 0)
class TblAboutUs extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? aboutMM;
  @HiveField(2)
  String? aboutEng;
  @HiveField(3)
  String? createdBy;
  @HiveField(4)
  String? updatedBy;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? updatedAt;
  TblAboutUs(
      {this.id,
      this.aboutMM,
      this.aboutEng,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});
  factory TblAboutUs.fromJson(Map<String, dynamic> jsonData) {
    return TblAboutUs(
        id: jsonData['id'],
        aboutMM: jsonData['about_mm'],
        aboutEng: jsonData['about_eng'],
        createdBy: jsonData['created_by'],
        updatedBy: jsonData['updated_by'],
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at']);
  }
}

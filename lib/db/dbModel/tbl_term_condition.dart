import 'package:hive/hive.dart';
part 'tbl_term_condition.g.dart';

@HiveType(typeId: 3)
class TBLTermAndCondition extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? termMM;
  @HiveField(2)
  String? termEng;
  @HiveField(3)
  String? createdBy;
  @HiveField(4)
  String? updatedBy;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? updatedAt;
  TBLTermAndCondition(
      {this.id,
      this.termMM,
      this.termEng,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});
  factory TBLTermAndCondition.fromJson(Map<String, dynamic> jsonData) {
    return TBLTermAndCondition(
        id: jsonData['id'],
        termMM: jsonData['term_mm'],
        termEng: jsonData['term_eng'],
        createdBy: jsonData['created_by'],
        updatedBy: jsonData['updated_by'],
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at']);
  }
}

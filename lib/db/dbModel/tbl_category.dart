import 'package:hive/hive.dart';
part 'tbl_category.g.dart';
@HiveType(typeId: 1)
class TBLCategory extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String categoryName;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String createdBy;
  @HiveField(4)
  final String updatedBy;
  @HiveField(5)
  final String createdAt;
  @HiveField(6)
  final String updatedAt;
  TBLCategory(this.id, this.categoryName, this.image, this.createdBy,
      this.updatedBy, this.createdAt, this.updatedAt);
  factory TBLCategory.fromJson(Map<String, dynamic> jsonData) {
    return TBLCategory(
        jsonData['id'],
        jsonData['category_name'],
        jsonData['image'],
        jsonData['created_by'],
        jsonData['updated_by'],
        jsonData['created_date'],
        jsonData['updated_date']);
  }
}

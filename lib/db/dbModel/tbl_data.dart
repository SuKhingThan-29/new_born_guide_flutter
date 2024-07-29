import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:hive/hive.dart';
part 'tbl_data.g.dart';

@HiveType(typeId: 5)
class TBLData {
  @HiveField(0)
  int? categoryId;
  @HiveField(1)
  String? categoryName;
  @HiveField(2)
  String? type;
  @HiveField(3)
  int? isActive;
  @HiveField(4)
  List<TBLContent>? content;
  TBLData(
      {this.categoryId,
      this.categoryName,
      this.type,
      this.isActive,
      this.content});

  factory TBLData.fromJson(Map<String, dynamic> jsonData) {
    var _contentList = jsonData['content'] as List;
    List<TBLContent> contents =
        _contentList.map((e) => TBLContent.fromJson(e)).toList();
    return TBLData(
        categoryId: jsonData['category_id'],
        categoryName: jsonData['category_name'],
        type: jsonData['type'],
        isActive: jsonData['is_active'],
        content: contents);
  }
}

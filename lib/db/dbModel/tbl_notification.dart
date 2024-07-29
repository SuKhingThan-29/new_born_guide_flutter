import 'package:hive/hive.dart';
part 'tbl_notification.g.dart';

@HiveType(typeId: 9)
class TblNotification {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? createdBy;
  @HiveField(3)
  String? updatadBy;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;
  TblNotification(
      {this.id,
      this.title,
      this.createdBy,
      this.updatadBy,
      this.createdAt,
      this.updatedAt});
  factory TblNotification.fromJson(Map<String, dynamic> jsonData) {
    return TblNotification(
        id: jsonData['id'],
        title: jsonData['title'],
        createdBy: jsonData['created_by'],
        updatadBy: jsonData['updated_by'],
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at']);
  }
}

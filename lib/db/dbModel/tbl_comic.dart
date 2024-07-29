import 'package:hive/hive.dart';
part 'tbl_comic.g.dart';
@HiveType(typeId: 8)
class TBLComic {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? contentId;
  @HiveField(2)
  String? imageUrl;
  @HiveField(3)
  String? voiceUrl;
  @HiveField(4)
  String? createdBy;
  @HiveField(5)
  String? updatedBy;
  @HiveField(6)
  String? createdAt;
  @HiveField(7)
  String? updatedAt;
  @HiveField(8)
  int? userId;
  TBLComic(
      {this.id,
      this.contentId,
      this.imageUrl,
      this.voiceUrl,
      this.createdBy,
       this.updatedBy,
       this.createdAt,
       this.updatedAt,
       this.userId});

  factory TBLComic.fromJson(Map<String, dynamic> jsonData) {
    return TBLComic(
        id: jsonData['id'],
        contentId: jsonData['content_id'],
        imageUrl: jsonData['image_url'],
        voiceUrl: jsonData['voice_url'],
        createdBy: jsonData['created_by'],
        updatedBy: jsonData['updated_by'],
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at']);
  }
}

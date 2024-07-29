import 'package:chitmaymay/db/dbModel/tbl_comic.dart';
import 'package:hive/hive.dart';
part 'tbl_content.g.dart';

@HiveType(typeId: 7)
class TBLContent {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? categoryId;
  @HiveField(4)
  String? imageUrl;
  @HiveField(5)
  String? url;
  @HiveField(6)
  String? urlMp4;
  @HiveField(7)
  String? mp4Size;
  @HiveField(8)
  int? viewCount;
  @HiveField(9)
  int? isActive;
  @HiveField(10)
  int? reactCount;
  @HiveField(11)
  int? userId;
  @HiveField(12)
  int? loveAction;
  @HiveField(13)
  int? saveAction;
  @HiveField(14)
  int? perpage;
  @HiveField(15)
  int? relatedContentId;
  @HiveField(16)
  bool? isHome;
  @HiveField(17)
  bool? isContentDetail;
  @HiveField(18)
  String? createdAt;
  @HiveField(19)
  bool? isUpload;
  @HiveField(20)
  bool? isDelete;
  @HiveField(21)
  String? type;
  @HiveField(22)
  List<TBLComic>? comic;
  @HiveField(23)
  bool? isPremium;

  TBLContent(
      {this.id,
      this.title,
      this.description,
      this.categoryId,
      this.imageUrl,
      this.url,
      this.urlMp4,
      this.mp4Size,
      this.viewCount,
      this.isActive,
      this.reactCount,
      this.userId,
      this.loveAction,
      this.saveAction,
      this.perpage,
      this.relatedContentId,
      this.isHome,
      this.isContentDetail,
      this.createdAt,
      this.isUpload,
      this.isDelete,
      this.type,
      this.comic,
      this.isPremium});

  factory TBLContent.fromJson(Map<String, dynamic> jsonData) {
    var _comicList = jsonData['comic'] as List;
    List<TBLComic> comicLists =
        _comicList.map((e) => TBLComic.fromJson(e)).toList();
    return TBLContent(
      id: jsonData['id'],
      title: jsonData['title'] ?? '',
      description: jsonData['description'] ?? '',
      categoryId: jsonData['category_id'] ?? 0,
      imageUrl: jsonData['image_url'] ?? '',
      url: jsonData['url'] ?? '',
      urlMp4: jsonData['url_mp4'] ?? '',
      mp4Size: jsonData['mp4_size'] ?? '',
      viewCount: jsonData['view_count'] == '' ? '' : jsonData['view_count'],
      isActive: jsonData['is_active'] == '' ? '' : jsonData['is_active'],
      reactCount: jsonData['react_count'] ?? 0,
      saveAction: jsonData['save_action'],
      loveAction: jsonData['love_action'],
      createdAt: jsonData['created_at'],
      type: jsonData['type'],
      comic: comicLists,
      isPremium: jsonData['is_premium']?? false,
    );
  }
}

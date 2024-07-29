
class TBLSlide {
  int? id;
  String? title;
  String? imageUrl;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  TBLSlide(
      {this.id,
      this.title,
      this.imageUrl,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  TBLSlide.fromJson(Map<dynamic, dynamic> json) {
    id = json['user_id'];
    title = json['title'];
    imageUrl = json['image_url'];
    createdBy = json['created_at'];
    updatedBy = json['updated_at'];
    createdAt = json['created_by'];
    updatedAt = json['updated_by'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["user_id"] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['created_at'] = createdBy;
    data["updated_at"] = updatedBy;
    data['created_by'] = createdAt;
    data['updated_by'] = updatedAt;
    return data;
  }
}

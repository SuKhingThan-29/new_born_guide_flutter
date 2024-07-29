
class TBLPayment {
  int? id;
  String? name;
  String? imageUrl;
  String? created;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  TBLPayment(
      {this.id,
      this.name,
      this.imageUrl,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});
  factory TBLPayment.fromJson(Map<String, dynamic> jsonData) {
    return TBLPayment(
        id: jsonData['id']?? 0,
        name: jsonData['name'],
        imageUrl: jsonData['image_url'],
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at'],
        createdBy: jsonData['created_by'],
        updatedBy: jsonData['updated_by']);
  }
}

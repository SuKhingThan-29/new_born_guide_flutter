
class TBLSubscription {
  int? id;
  String? title;
  int? prices;
  int? originPrices;
  int? duration;
  int? total;
  int? userId;
  String? recommend;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  TBLSubscription(
      {this.id,
      this.title,
      this.prices,
      this.originPrices,
      this.duration,
      this.total,
      this.userId,
      this.recommend,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});
  factory TBLSubscription.fromJson(Map<String, dynamic> jsonData) {
    return TBLSubscription(
        id: jsonData['id'],
        title: jsonData['title'],
        prices: jsonData['prices'],
        duration: jsonData['duration'],
        originPrices: jsonData['origin_prices'] ?? 0,
        total: jsonData['total'],
        userId: 0,
        recommend: jsonData['recommend'] ?? '',
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at'],
        createdBy: jsonData['created_by'],
        updatedBy: jsonData['updated_by']);
  }
}

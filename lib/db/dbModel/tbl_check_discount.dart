class TBLCheckDiscount{
  int? id;
  String? discountCode;
  int? useNumber;
  int? prices;
  int? duration;
  int? activeStatus;
  int? isDeleted;
  int? userId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  TBLCheckDiscount(
      {this.id,
      this.discountCode,
      this.useNumber,
      this.prices,
      this.duration,
      this.activeStatus,
      this.isDeleted,
      this.userId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});
  factory TBLCheckDiscount.fromJson(Map<String, dynamic> jsonData) {
    return TBLCheckDiscount(
        id: jsonData['id'],
        discountCode: jsonData['discount_code'],
        useNumber: jsonData['use_number'],
        prices: jsonData['prices'],
        duration: jsonData['duration'],
        activeStatus: jsonData['active_status'],
        isDeleted: jsonData['is_deleted'],
        userId: 0,
        createdAt: jsonData['created_at'],
        updatedAt: jsonData['updated_at'],
        createdBy: jsonData['created_by'],
        updatedBy: jsonData['updated_by']);
  }
}

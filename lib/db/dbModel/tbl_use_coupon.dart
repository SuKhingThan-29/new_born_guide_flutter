
class TBLUseCoupon {
  int? id;
  int? duration;
  String? startDate;
  String? endDate;
  int? price;
  int? userId;

  TBLUseCoupon(
      {this.id,
      this.duration,
      this.startDate,
      this.endDate,
      this.price,
      this.userId});
  factory TBLUseCoupon.fromJson(Map<String, dynamic> jsonData) {
    return TBLUseCoupon(
      id: jsonData['id'],
      duration: jsonData['duration'],
      startDate: jsonData['start_date'],
      endDate: jsonData['end_date'],
      price: jsonData['prices'],
      userId: 0,
    );
  }
}

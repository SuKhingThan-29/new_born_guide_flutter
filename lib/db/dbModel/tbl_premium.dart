import 'package:hive/hive.dart';
part 'tbl_premium.g.dart';

@HiveType(typeId: 11)
class TBLPremium {
  @HiveField(0)
  int? id;
  @HiveField(1)
  bool? isPremium;
  @HiveField(2)
  String? lastDay;

  TBLPremium({this.id, this.isPremium, this.lastDay});

  factory TBLPremium.fromJson(Map<String, dynamic> jsonData) {
    return TBLPremium(
      id: jsonData['id'],
      isPremium: jsonData['is_primium'],
      lastDay: jsonData['last_day'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["user_id"] = id;
    data['is_primium'] = isPremium;
    data['last_day'] = lastDay;

    return data;
  }
}

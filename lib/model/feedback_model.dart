import '../chitmaymay_api/chitMayMayApi.dart';

class FeedBackModel {
  String? title;
  String? description;
  int? userId;

  FeedBackModel({this.title, this.description, this.userId});

  FeedBackModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = userId;
    data['title'] = title;
    data['description'] = description;
    data['secret_key'] = secret_key;
    return data;
  }
}

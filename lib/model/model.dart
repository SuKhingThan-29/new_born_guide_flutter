import 'package:flutter_downloader/flutter_downloader.dart';

class ItemHolder {
  ItemHolder({this.name, this.task});

  final String? name;
  final TaskInfo? task;

}

class TaskInfo {
  TaskInfo({this.name, this.link,this.title,this.imageUrl,this.contentId});

  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  final String? title;
  final String? imageUrl;
  final int? contentId;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
}
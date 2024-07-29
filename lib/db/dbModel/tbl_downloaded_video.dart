import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';

import 'tbl_content.dart';

part 'tbl_downloaded_video.g.dart';

@HiveType(typeId: 12)
class TblDownloadedVideo extends HiveObject {
  @HiveField(0)
  TBLContent? content;
  @HiveField(1)
  String? taskId;
  @HiveField(2)
  DownloadTaskStatus? status;
  @HiveField(3)
  int? progress;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? filename;
  @HiveField(6)
  String? savedDir;
  @HiveField(7)
  int? timeCreated;
  @HiveField(8)
  String? filePath;
  @HiveField(9)
  String? fileSize;

  TblDownloadedVideo(
      {this.content,
      this.taskId,
      this.status,
      this.progress,
      this.url,
      this.filename,
      this.savedDir,
      this.timeCreated,
      this.filePath,
      this.fileSize});
}
